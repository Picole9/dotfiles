-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- close some filetypes with <q>
local close_with_q = vim.api.nvim_create_augroup('close_with_q', { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = close_with_q,
    pattern = {
        "help",
        "lspinfo",
        "qf",
        "checkhealth",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- ansible-detection
if vim.filetype then
    vim.filetype.add({
        pattern = {
            [".*/playbooks/.*%.yml"] = "yaml.ansible",
            [".*/playbooks/.*%.yaml"] = "yaml.ansible",
            [".*/roles/.*/tasks/.*%.yml"] = "yaml.ansible",
            [".*/roles/.*/tasks/.*%.yaml"] = "yaml.ansible",
            [".*/roles/.*/handlers/.*%.yml"] = "yaml.ansible",
            [".*/roles/.*/handlers/.*%.yaml"] = "yaml.ansible",
        }
    })
else
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = {
            "*/playbooks/*.yml",
            "*/playbooks/*.yaml",
            "*/roles/*/tasks/*.yml",
            "*/roles/*/tasks/*.yaml",
            "*/roles/*/handlers/*.yml",
            "*/roles/*/handlers/*.yaml"
        },
        callback = function()
            vim.bo.filetype = "yaml.ansible"
        end,
    })
end
