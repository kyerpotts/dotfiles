return {
  {
    "kyerpotts/99",
    branch = "feat/add_snacks_support",
    dependencies = {
      "saghen/blink.compat",
    },
    keys = {
      {
        "<leader>as",
        function()
          require("99").search()
        end,
        desc = "99 Search",
      },
      {
        "<leader>av",
        function()
          require("99").vibe()
        end,
        desc = "99 Vibe",
      },
      {
        "<leader>ao",
        function()
          require("99").open()
        end,
        desc = "99 Open",
      },
      {
        "<leader>ax",
        function()
          require("99").stop_all_requests()
        end,
        desc = "99 Stop Requests",
      },
      {
        "<leader>ac",
        function()
          require("99").clear_previous_requests()
        end,
        desc = "99 Clear Requests",
      },
      {
        "<leader>al",
        function()
          require("99").view_logs()
        end,
        desc = "99 View Logs",
      },
      {
        "<leader>am",
        function()
          require("99.extensions.snacks").select_model()
        end,
        desc = "99 Select Model",
      },
      {
        "<leader>ap",
        function()
          require("99.extensions.snacks").select_provider()
        end,
        desc = "99 Select Provider",
      },
      {
        "<leader>ae",
        function()
          require("99").visual()
        end,
        mode = "v",
        desc = "99 Visual Edit",
      },
    },
    config = function()
      local _99 = require("99")

      -- For logging that is to a file if you wish to trace through requests
      -- for reporting bugs, i would not rely on this, but instead the provided
      -- logging mechanisms within 99.  This is for more debugging purposes
      local cwd = vim.uv.cwd()
      local basename = vim.fs.basename(cwd)
      _99.setup({
        provider = _99.Providers.OpenCodeProvider,
        model = "openai/gpt-5.3-codex",
        logger = {
          level = _99.DEBUG,
          path = "/tmp/" .. basename .. ".99.debug",
          print_on_error = true,
        },
        tmp_dir = "./tmp",

        --- Completions: #rules and @files in the prompt buffer
        completion = {
          -- I am going to disable these until i understand the
          -- problem better.  Inside of cursor rules there is also
          -- application rules, which means i need to apply these
          -- differently
          -- cursor_rules = "<custom path to cursor rules>"

          --- A list of folders where you have your own SKILL.md
          --- Expected format:
          --- /path/to/dir/<skill_name>/SKILL.md
          ---
          --- Example:
          --- Input Path:
          --- "scratch/custom_rules/"
          ---
          --- Output Rules:
          --- {path = "scratch/custom_rules/vim/SKILL.md", name = "vim"},
          --- ... the other rules in that dir ...
          ---
          custom_rules = {
            "scratch/custom_rules/",
          },

          --- Configure @file completion (all fields optional, sensible defaults)
          files = {
            -- enabled = true,
            -- max_file_size = 102400,     -- bytes, skip files larger than this
            -- max_files = 5000,            -- cap on total discovered files
            -- exclude = { ".env", ".env.*", "node_modules", ".git", ... },
          },

          --- What autocomplete do you use.  We currently only
          --- support cmp right now
          source = "blink",
        },

        --- WARNING: if you change cwd then this is likely broken
        --- ill likely fix this in a later change
        ---
        --- md_files is a list of files to look for and auto add based on the location
        --- of the originating request.  That means if you are at /foo/bar/baz.lua
        --- the system will automagically look for:
        --- /foo/bar/AGENT.md
        --- /foo/AGENT.md
        --- assuming that /foo is project root (based on cwd)
        md_files = {
          "AGENT.md",
        },
      })
    end,
  },
}
