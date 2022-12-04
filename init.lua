require('n01x.base')
require('n01x.highlights')
require('n01x.maps')
require('n01x.plugins')

local has = vim.fn.has
local is_linux = has "unix"
local is_win = has "win32"

if is_linux then
	require('n01x.linux')
end

if is_win then
	require('n01x.windows')
end








