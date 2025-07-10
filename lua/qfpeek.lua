local api = vim.api
local ns = api.nvim_create_namespace('QfPeek')

local M = {}

M.default_floatwin_opts = {
	width = 60,
	height = 10
}

function M.on_cmd()
	local line = vim.fn.line('.') -- 1-based line index
	local is_loc_list = vim.fn.getwininfo(api.nvim_get_current_win())[1].loclist == 1
	local get_qf_list = is_loc_list and function(...)
		return vim.fn.getloclist(0, ...)
	end or vim.fn.getqflist
	local items = get_qf_list({ idx = line, all = true }).items
	local item = items[1]
	if not item then
		return
	end
	local bufnr, lnum, end_lnum, col, end_col = item.bufnr, item.lnum, item.end_lnum, item.col, item.end_col
	local floating_preview_opts = vim.tbl_deep_extend('force', M.default_floatwin_opts, vim.g.qfpeek_floatwin_opts)
	local _, winid = vim.lsp.util.open_floating_preview({}, '', floating_preview_opts)
	api.nvim_win_set_buf(winid, bufnr)

	lnum = lnum > 0 and lnum or 1
	col = col > 0 and col or 1
	api.nvim_win_set_cursor(winid, { lnum, col - 1 })

	end_lnum = end_lnum > 0 and end_lnum or lnum
	end_col = end_col > 0 and end_col or col
	vim.hl.range(bufnr, ns, 'Substitute', { lnum - 1, col - 1 }, { end_lnum - 1, end_col - 1 })
	api.nvim_create_autocmd('WinClosed', {
		pattern = tostring(winid),
		callback = function()
			api.nvim_buf_clear_namespace(bufnr, ns, lnum - 1, end_lnum)
		end,
	})
end

return M
