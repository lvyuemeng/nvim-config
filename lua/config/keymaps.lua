-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jj", "<Esc>")

if vim.g.vscode then
  local vscode = require("vscode")

  -- Function to create VSCode keymappings
  local function vscode_map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, function()
      vscode.action(rhs)
    end, opts)
  end

  print("VSCode extension loaded:", package.loaded["vscode"] ~= nil)

  -- Buffer/Editor Management
  vscode_map("n", "<leader>bd", "workbench.action.closeActiveEditor")
  vscode_map("n", "<leader>bo", "workbench.action.closeOtherEditors")
  vscode_map("n", "<leader>bD", "workbench.action.closeEditorsInGroup")
  vscode_map("n", "<leader>bb", "workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup")
  vscode_map("n", "]b", "workbench.action.nextEditor")
  vscode_map("n", "[b", "workbench.action.previousEditor")

  -- Window Management
  vscode_map("n", "<leader>-", "workbench.action.splitEditorDown")
  vscode_map("n", "<leader>|", "workbench.action.splitEditorRight")

  -- File operations
  vscode_map("n", "<Leader>e", "workbench.view.explorer")
  vscode_map("n", "<leader>fn", "workbench.action.files.newUntitledFile")
  vscode_map("n", "<C-s>", "workbench.action.files.save")

  -- Code Navigation
  vscode_map("n", "gd", "editor.action.revealDefinition")
  vscode_map("n", "gD", "editor.action.peekDefinition")
  vscode_map("n", "gr", "editor.action.goToReferences")
  vscode_map("n", "gi", "editor.action.goToImplementation")
  vscode_map("n", "K", "editor.action.showHover")

  -- Search/Diagnostics
  vscode_map("n", "<leader>xl", "workbench.actions.view.problems")
  vscode_map("n", "]d", "editor.action.marker.nextInFiles")
  vscode_map("n", "[d", "editor.action.marker.previousInFiles")

  -- Code Actions
  vscode_map({ "n", "v" }, "<leader>ca", "editor.action.quickFix")
  vscode_map("n", "<leader>cr", "editor.action.rename")
  vscode_map({ "n", "v" }, "<leader>cf", "editor.action.formatDocument")

  -- Debugging
  vscode_map("n", "<Leader>dd", "workbench.action.debug.start")
  vscode_map("n", "<Leader>ds", "workbench.action.debug.stop")
  vscode_map("n", "<Leader>do", "workbench.action.debug.stepOver")
  vscode_map("n", "<Leader>di", "workbench.action.debug.stepInto")

  -- Terminal
  vscode_map("n", "<leader>ft", "workbench.action.terminal.toggleTerminal")
  vscode_map("t", "<C-/>", "workbench.action.toggleMaximizedPanel")

  -- UI Toggles
  vscode_map("n", "<leader>us", "workbench.action.toggleWordWrap")
  vscode_map("n", "<leader>ud", "errors.toggleProblems")
end

local os = vim.loop.os_uname().sysname

if os == "Linux" then
  if vim.fn.executable("fish") == 1 then
    vim.os.shell = "fish"
  else
    vim.o.shell = "bash"
  end
else
  if vim.fn.executable("pwsh") == 1 then
    vim.o.shell = "pwsh"
  else
    vim.o.shell = "powershell.exe"
  end
  vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command "
  vim.o.shellxquote = ""
  vim.o.shellquote = ""
  vim.o.shellpipe = "| Out-File -Encoding UTF8 %s"
  vim.o.shellredir = "| Out-File -Encoding UTF8 %s"
end
