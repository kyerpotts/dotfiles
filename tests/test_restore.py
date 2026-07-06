import os
import subprocess
import tempfile
import unittest
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]
RESTORE = REPO_ROOT / "restore.sh"


class RestoreScriptTest(unittest.TestCase):
    def run_restore(self, home: Path, *args: str) -> subprocess.CompletedProcess[str]:
        env = os.environ.copy()
        env["HOME"] = str(home)
        env["SHELL"] = "/bin/zsh"
        return subprocess.run(
            ["bash", str(RESTORE), *args],
            cwd=REPO_ROOT,
            env=env,
            text=True,
            capture_output=True,
            check=False,
        )

    def test_help_prints_usage_without_deploying(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            home = Path(temp_dir) / "home"
            home.mkdir()

            result = self.run_restore(home, "--help")

            self.assertEqual(result.returncode, 0, result.stderr + result.stdout)
            self.assertIn("Usage:", result.stdout)
            self.assertFalse((home / ".zshrc").exists())

    def test_dry_run_reports_actions_without_creating_links(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            home = Path(temp_dir) / "home"
            home.mkdir()

            result = self.run_restore(home, "--dry-run", "--no-shell")

            self.assertEqual(result.returncode, 0, result.stderr + result.stdout)
            self.assertIn("DRY RUN", result.stdout)
            self.assertIn("Would link:", result.stdout)
            self.assertFalse((home / ".zshrc").exists())

    def test_conflicting_file_is_backed_up_then_replaced_with_symlink(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            home = Path(temp_dir) / "home"
            home.mkdir()
            existing_zshrc = home / ".zshrc"
            existing_zshrc.write_text("old shell config\n")

            result = self.run_restore(home, "--no-shell")

            self.assertEqual(result.returncode, 0, result.stderr + result.stdout)
            self.assertTrue(existing_zshrc.is_symlink())
            self.assertEqual(existing_zshrc.resolve(), REPO_ROOT / ".zshrc")
            backups = list(home.glob(".zshrc.backup-*"))
            self.assertEqual(len(backups), 1)
            self.assertEqual(backups[0].read_text(), "old shell config\n")

    def test_no_shell_skips_shell_configuration(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            home = Path(temp_dir) / "home"
            home.mkdir()

            result = self.run_restore(home, "--no-shell")

            self.assertEqual(result.returncode, 0, result.stderr + result.stdout)
            self.assertIn("Skipping shell configuration", result.stdout)


if __name__ == "__main__":
    unittest.main()
