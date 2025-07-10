local qfpeek = require('qfpeek')

local buf = vim.api.nvim_get_current_buf()

vim.g.qfpeek_floatwin_opts = vim.g.qfpeek_floatwin_opts or qfpeek.default_floatwin_opts
vim.g.qfpeek_map = vim.g.qfpeek_map or 'K'

vim.api.nvim_buf_create_user_command(buf, "QfPeek", qfpeek.on_cmd, {
	nargs = '*',
	desc = 'Preview quickfix/location list entry under cursor'
})

vim.b.undo_ftplugin = table.concat({
	vim.b.undo_ftplugin or '',
	'delcommand -buffer QfPeek',
})

if vim.g.qfpeek_map ~= '' then
	vim.keymap.set('n', vim.g.qfpeek_map, vim.cmd.QfPeek, {
		buffer = buf,
		desc = 'Preview quickfix/location list entry under cursor'
	})
	vim.b.undo_ftplugin = vim.b.undo_ftplugin .. '\n unmap <buffer> ' .. vim.g.qfpeek_map
end
