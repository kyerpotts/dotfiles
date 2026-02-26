return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.servers = opts.servers or {}
    opts.servers.clangd = opts.servers.clangd or {}

    local function ensure_arg(cmd, prefix, arg)
      for _, a in ipairs(cmd) do
        if a:sub(1, #prefix) == prefix then
          return
        end
      end
      table.insert(cmd, arg)
    end

    local cmd = opts.servers.clangd.cmd or { "clangd" }

    ensure_arg(
      cmd,
      "--query-driver=",
      "--query-driver=" .. (vim.env.HOME or "~") .. "/.platformio/packages/toolchain-*/bin/*"
    )

    opts.servers.clangd.cmd = cmd
  end,
}
