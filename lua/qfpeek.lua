local api = vim.api
local ns = api.nvim_create_namespace('QfPeek')
local augroup = api.nvim_create_augroup('QfPeek', {})

local M = {}

---@param buf number
---@param enter boolean
---@param opts? vim.api.keyset.win_config
---@return number win_id 0 if failed
local function open_win(buf, enter, opts)
    local default_opts = {
        relative = "win",
        win = api.nvim_get_current_win(),
        anchor = "SW",
        row = -1,
        col = 1,
        width = api.nvim_win_get_width(0),
        height = vim.o.previewheight,
        title = "QfPeek",
        title_pos = "center",
    }
    opts = vim.tbl_deep_extend("force", default_opts, opts or {})
    local win = api.nvim_open_win(buf, enter, opts)
    api.nvim_create_autocmd("WinLeave", {
        group = augroup,
        callback = function()
            if api.nvim_get_current_win() == win then
                api.nvim_win_close(win, true)
            end
        end,
    })

    return win
end

function M.on_cmd()
	local qf_buf = api.nvim_get_current_buf()

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
	local buf, lnum, end_lnum, col, end_col = item.bufnr, item.lnum, item.end_lnum, item.col, item.end_col
	local floatwin
	if not vim.b.qfpeek_floatwin or not api.nvim_win_is_valid(vim.b.qfpeek_floatwin) then
		floatwin = open_win(buf, false, vim.g.qfpeek_floatwin_opts)
		api.nvim_buf_set_var(qf_buf, 'qfpeek_floatwin', floatwin)
	end

	lnum = lnum > 0 and lnum or 1
	col = col > 0 and col or 1
	api.nvim_win_set_cursor(floatwin, { lnum, col - 1 })

	end_lnum = end_lnum > 0 and end_lnum or lnum
	end_col = end_col > 0 and end_col or col
	vim.hl.range(buf, ns, 'Substitute', { lnum - 1, col - 1 }, { end_lnum - 1, end_col - 1 })
	api.nvim_create_autocmd('WinClosed', {
		pattern = tostring(floatwin),
		callback = function()
			api.nvim_buf_clear_namespace(buf, ns, lnum - 1, end_lnum)
		end,
    })
	api.nvim_create_autocmd('CursorMoved', {
		buffer = qf_buf,
        callback = function()
			if api.nvim_win_is_valid(floatwin) then
				api.nvim_win_close(floatwin, true)
			end
		end,
	})
end

return M
