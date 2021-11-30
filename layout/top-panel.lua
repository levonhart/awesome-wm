local wibox = require('wibox')
local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local icons = require('theme.icons')
local clickable_container = require('widget.clickable-container')
local task_list = require('widget.task-list')
local tag_list = require('widget.tag-list')

local top_panel = function(s)

	local panel = wibox {
		ontop = true,
		screen = s,
		type = 'dock',
		height = dpi(28),
		width = s.geometry.width,
		x = s.geometry.x,
		y = s.geometry.y,
		stretch = false,
		bg = beautiful.background,
		fg = beautiful.fg_normal
	}

	panel:struts {
		top = dpi(28)
	}

	panel:connect_signal(
		'mouse::enter',
		function() 
			local w = mouse.current_wibox
			if w then
				w.cursor = 'left_ptr'
			end
		end
	)

	s.search				= require('widget.search-apps')()
	local add_button 		= require('widget.open-default-app')(s)
	local clock 			= require('widget.clock')(s)
	local volume			= require('widget.volume-widget.volume')()
	s.updater 				= require('widget.package-updater')()
	s.screen_rec 			= require('widget.screen-recorder')()
	-- s.mpd       			= require('widget.mpd')()
	s.end_session			= require('widget.end-session')()
	-- s.global_search			= require('widget.global-search')()
	s.systray = wibox.widget {
		{
			base_size = dpi(20),
			horizontal = true,
			screen = 'primary',
			widget = wibox.widget.systray
		},
		visible = false,
		top = dpi(4),
		widget = wibox.container.margin
	}
	s.tray_toggler  		= require('widget.tray-toggle')
	s.bluetooth   			= require('widget.bluetooth')()
	s.network       		= require('widget.network')()
	s.battery     			= require('widget.battery')()
	-- local layout_box 		= require('widget.layoutbox')(s)

	panel : setup {
		layout = wibox.layout.align.horizontal,
		expand = 'none',
		{
			layout = wibox.layout.fixed.horizontal,
			s.search,
			add_button,
			tag_list(s),
		}, 
		{
			layout = wibox.layout.fixed.horizontal,
			-- task_list(s),
		},
		{
			layout = wibox.layout.fixed.horizontal,
			spacing = dpi(5),
			s.updater,
			s.systray,
			s.tray_toggler,
			s.network,
			s.bluetooth,
			volume,
			s.battery,
			layoutbox,
			s.screen_rec,
			-- s.global_search,
			-- s.mpd,
			clock,
			s.end_session
		}
	}

	return panel
end


return top_panel
