local awful = require('awful')
local modkey = require('configuration.keys.mod').mod_key

return awful.util.table.join(
	awful.button( {}, 1, function(c)
			c:emit_signal('request::activate', "mouse_click")
			c:raise()
		end),
	awful.button( {modkey}, 1, function(c)
			c:emit_signal('request::activate', "mouse_click")
			c:raise()
		awful.mouse.client.move(c)
	end),
	awful.button( {modkey}, 3, function(c)
			c:emit_signal('request::activate', "mouse_click")
			c:raise()
		awful.mouse.client.resize(c)
		end),
	awful.button( {modkey}, 4, function()
			awful.layout.inc(1)
		end),
	awful.button( {modkey}, 5, function()
			awful.layout.inc(-1)
		end)
)
