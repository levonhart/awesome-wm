-- vim:foldmethod=marker
local awful = require('awful')
local beautiful = require('beautiful')

require('awful.autofocus')

local hotkeys_popup = require('module.hotkeys_popup')

local modkey = require('configuration.keys.mod').mod_key
local altkey = require('configuration.keys.mod').alt_key
local apps = require('configuration.apps')

local rofibin = os.getenv('HOME') .. '/.config/rofi/bin/'

local global_keys = awful.util.table.join(

-- Awesome {{{ --
    awful.key({ modkey,           }, "F1", hotkeys_popup.show_help,
              {description="show help", group="awesome"}),

    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),

    awful.key({ modkey, "Control", "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,         }, "Delete", function ()
                  awful.spawn(apps.default.rofi_powermenu)
              end,
              {description = "open power menu", group = "awesome"}),

	awful.key({ modkey, 'Control' }, 'q', function()
			awesome.emit_signal('module::exit_screen:show')
		end,
		{description = 'toggle exit screen', group = 'awesome'}),

-- }}} Awesome --

-- Layout {{{ --
    awful.key({ modkey,           }, ".",     function () awful.tag.incmwfact( 0.02)          end,
              {description = "increase master width factor", group = "layout"}),

    awful.key({ modkey,           }, ",",     function () awful.tag.incmwfact(-0.02)          end,
              {description = "decrease master width factor", group = "layout"}),

    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),

    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),

    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),

    awful.key({ modkey, "Control" }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),

    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),
-- }}} Layout --

-- Tag {{{ --
    awful.key({ "Mod3",           }, "h",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),

    awful.key({ "Mod3",           }, "l",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),

    awful.key({ modkey,             }, "Escape",
          function ()
              if client.focus then
                  local tag = client.focus.first_tag
                  if tag then
                      client.focus:move_to_tag(tag)
                  end
              end
          end,
          {description = "move focused client to its first tag only", group = "tag"}),

	-- awful.key({ modkey,           }, 'o', function()
	--         awful.tag.incgap(1)
	--     end,
	--     {description = 'increase gap', group = 'layout'}),
    --
	-- awful.key({ modkey, 'Shift'   }, 'o', function()
	--         awful.tag.incgap(-1)
	--     end,
	--     {description = 'decrease gap', group = 'layout'}),
    --
	-- awful.key({ modkey, 'Control' }, 'w', function ()
	--         -- tag_view_nonempty(-1)
	--         local focused = awful.screen.focused()
	--         for i = 1, #focused.tags do
	--             awful.tag.viewidx(-1, focused)
	--             if #focused.clients > 0 then
	--                 return
	--             end
	--         end
	--     end,
	--     {description = 'view previous non-empty tag', group = 'tag'}),
    --
	-- awful.key({ modkey, 'Control' }, 's', function ()
	--         -- tag_view_nonempty(1)
	--         local focused =  awful.screen.focused()
	--         for i = 1, #focused.tags do
	--             awful.tag.viewidx(1, focused)
	--             if #focused.clients > 0 then
	--                 return
	--             end
	--         end
	--     end,
	--     {description = 'view next non-empty tag', group = 'tag'}
	-- ),

-- }}} Tag --

-- Client {{{ --
    awful.key({ modkey,           }, "'", awful.tag.history.restore,
        {description = "view last", group = "client"}
    ),

    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),

    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),

    awful.key({ modkey, "Control" }, "c",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),


    awful.key({ modkey,           }, "j",
        function () awful.client.focus.bydirection("down") end,
        {description = "focus client below", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function () awful.client.focus.bydirection("up") end,
        {description = "focus client above", group = "client"}
    ),
    awful.key({ modkey,           }, "l",
        function () awful.client.focus.bydirection("right") end,
        {description = "focus client on right", group = "client"}
    ),
    awful.key({ modkey,           }, "h",
        function () awful.client.focus.bydirection("left") end,
        {description = "focus client on left", group = "client"}
    ),
    awful.key({ "Mod1",           }, "Tab", function () awful.client.focus.byidx( 1) end,
              {description = "focus next by index", group = "client"}),
    awful.key({ "Mod1", "Shift"   }, "Tab", function () awful.client.focus.byidx(-1) end,
              {description = "focus previous by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    awful.key({ "Mod3",           }, "j", function () awful.client.focus.byidx( 1) end,
              {description = "focus next by index", group = "client"}),
    awful.key({ "Mod3",           }, "k", function () awful.client.focus.byidx(-1) end,
              {description = "focus previous by index", group = "client"}),

    awful.key({ modkey,           }, "Tab",
        function () awful.spawn('rofi -show window') end,
        {description = "show client list", group = "client"}),

-- }}} Client --

-- Screen {{{ --
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),

-- }}} Screen --

-- Media Keys {{{ --
    awful.key( {                  }, 'XF86MonBrightnessUp',
        function()
            awful.spawn.easy_async_with_shell('xbacklight -get',
                function(stdout)
                    local brightness = string.match(stdout, '(%d+)')
                    awesome.emit_signal('widget::brightness:update',
                                        brightness + 10 % 100)
                end)
			awesome.emit_signal('module::brightness_osd:show', true)
            awful.spawn('xbacklight -inc 10')
        end,
    {description = 'brightness +10%', group = 'media'}),
    awful.key( {                  }, 'XF86MonBrightnessDown',
        function()
            awful.spawn.easy_async_with_shell('xbacklight -get',
                function(stdout)
                    local brightness = string.match(stdout, '(%d+)')
                    awesome.emit_signal('widget::brightness:update',
                                        brightness - 10 % 100)
                end)
            awful.spawn('xbacklight -dec 10')
			-- awesome.emit_signal('widget::brightness')
			awesome.emit_signal('module::brightness_osd:show', true)
        end,
    {description = 'brightness -10%', group = 'media'}),

	awful.key( {                  }, 'XF86AudioRaiseVolume',
		function()
			awful.spawn('amixer -D pulse sset Master 5%+', false)
            awesome.emit_signal('widget::volume')
            awesome.emit_signal('module::volume_osd:show', true)
		end,
		{description = 'increase volume up by 5%', group = 'media'}
	),
	awful.key( {                  }, 'XF86AudioLowerVolume',
		function()
			awful.spawn('amixer -D pulse sset Master 5%-', false)
            awesome.emit_signal('widget::volume')
            awesome.emit_signal('module::volume_osd:show', true)
		end,
		{description = 'decrease volume up by 5%', group = 'media'}
	),
	awful.key( {                  }, 'XF86AudioMute',
		function()
			awful.spawn('amixer -D pulse sset Master toggle', false)
		end,
		{description = 'toggle mute', group = 'media'}
	),
	awful.key( {                  }, 'XF86AudioNext',
		function()
			awful.spawn('playerctl next', false)
		end,
		{description = 'next music', group = 'media'}
	),
	awful.key( {                  }, 'XF86AudioPrev',
		function()
			awful.spawn('playerctl previous', false)
		end,
		{description = 'previous music', group = 'media'}
	),
	awful.key( {                  }, 'XF86AudioPlay',
		function()
			awful.spawn('playerctl play-pause', false)
		end,
		{description = 'play/pause music', group = 'media'}

	),
	-- awful.key( {                  }, 'XF86AudioMicMute',
	--     function()
	--         awful.spawn('pactl set-source-mute @DEFAULT_SOURCE@ toggle', false)
	--     end,
	--     {description = 'mute microphone', group = 'media'}
	-- ),

    awful.key( {                  }, 'XF86PowerDown',
        function()
            --
        end,
        {description = 'shutdown skynet', group = 'media'}
    ),
    awful.key( {                  }, 'XF86PowerOff',
        function()
			awesome.emit_signal('module::exit_screen:show')
        end,
        {description = 'toggle exit screen', group = 'media'}
    ),
    awful.key( {                  }, 'XF86Display',
        function()
            awful.spawn.single_instance('arandr', false)
        end,
        {description = 'arandr', group = 'media'}
    ),

-- }}} Media Keys --

-- Launcher {{{ --
	awful.key({ modkey, "Control" }, 't', function()
			awesome.emit_signal('module::quake_terminal:toggle')
		end,
		{description = 'dropdown application', group = 'launcher'}),

	awful.key({ modkey            }, 'm', function()
			if awful.screen.focused().musicpop then
				awesome.emit_signal('widget::music', 'keyboard')
			end
		end,
		{description = 'toggle music widget', group = 'launcher'}),


	awful.key({ modkey,           }, 'Return', function()
			awful.spawn(apps.default.terminal)
		end,
		{description = 'open default terminal', group = 'launcher'}),

	awful.key({ modkey, "Shift" }, 't', function()
			awful.spawn(apps.default.terminal)
		end,
		{description = 'open default terminal', group = 'launcher'}),

	awful.key({ modkey,           }, 'e', function()
			awful.spawn(apps.default.file_manager)
		end,
		{description = 'open default file manager', group = 'launcher'}),

	awful.key({ modkey, 'Shift'   }, 'f', function()
			awful.spawn(apps.default.web_browser)
		end,
		{description = 'open default web browser', group = 'launcher'}
	),


    awful.key({ modkey,           }, "space",
        function () awful.spawn('rofi -show run') end,
        {description = "run program", group = "launcher"}),

    awful.key({ modkey,           }, "b",
        function () awful.spawn('bwmenu') end,
        {description = "password manager menu", group = "launcher"}),

    awful.key({ modkey,           }, "r",
        function () awful.spawn('rofi -show ') end,
        {description = "search for files", group = "launcher"}),

    awful.key({ modkey,           }, "F3",
        function () awful.spawn(apps.default.rofi_appmenu) end,
					
        {description = "launch applications", group = "launcher"}),

	awful.key({ 'Control','Shift' }, 'Escape', function()
			awful.spawn(apps.default.terminal .. ' -e htop')
		end,
		{description = 'open system monitor', group = 'launcher'}), 

	awful.key({ altkey,'Shift' }, 'Escape', function()
			awful.spawn(apps.default.terminal .. ' -e nvtop')
		end,
		{description = 'open GPU monitor', group = 'launcher'}), 

	-- awful.key({ modkey            }, 'e', function()
	--         local focused = awful.screen.focused()
    --
	--         if focused.central_panel then
	--             focused.central_panel:hide_dashboard()
	--         end
	--         awful.spawn(apps.default.rofi_appmenu, false)
	--     end,
	--     {description = 'open application drawer', group = 'launcher'}),

    awful.key({ modkey,           }, "XF86Launch1",
        function () awful.spawn(rofibin .. 'launcher_misc') end,
        {description = "launch applications", group = "launcher"}),

	-- awful.key({ modkey, 'Shift'   }, 'r', function()
	--         if awful.screen.focused().central_panel.visible then
	--             awful.screen.focused().central_panel:toggle()
	--         end
	--         awful.spawn(apps.default.rofi_global, false)
	--     end,
	--     {description = 'open sidebar and global search', group = 'launcher'}),

	awful.key({ modkey,           }, 'F5', function()
			local focused = awful.screen.focused()

			if focused.central_panel then
				if _G.central_panel_mode == 'today_mode' or not focused.central_panel.visible then
					focused.central_panel:toggle()
					switch_rdb_pane('today_mode')
				else
					switch_rdb_pane('today_mode')
				end

				_G.central_panel_mode = 'today_mode'
			end
		end,
		{description = 'open today panel', group = 'launcher'}),

	awful.key( {modkey}, 'F6', function()
			local focused = awful.screen.focused()

			if focused.central_panel then
				if _G.central_panel_mode == 'settings_mode' or not focused.central_panel.visible then
					focused.central_panel:toggle()
					switch_rdb_pane('settings_mode')
				else
					switch_rdb_pane('settings_mode')
				end

				_G.central_panel_mode = 'settings_mode'
			end
		end,
		{description = 'open settings panel', group = 'launcher'}),

-- }}} Launcher --

-- Utilities {{{ --
	awful.key({                   }, 'Print', function ()
			awful.spawn.easy_async_with_shell(apps.utils.full_screenshot,function() end)
		end,
		{description = 'fullscreen screenshot', group = 'utilities'}),

	awful.key({ modkey, 'Shift'   }, 's', function ()
			awful.spawn.easy_async_with_shell(apps.utils.area_screenshot,function() end)
		end,
		{description = 'area/selected screenshot', group = 'utilities'}),

	awful.key({ modkey            }, 'x', function()
			awesome.emit_signal('widget::blur:toggle')
		end,
		{description = 'toggle blur effects', group = 'utilities'}),


	-- awful.key(
	--     {modkey},
	--     ']',
	--     function()
	--         awesome.emit_signal('widget::blur:increase')
	--     end,
	--     {description = 'increase blur effect by 10%', group = 'utilities'}
	-- ),
	-- awful.key(
	--     {modkey},
	--     '[',
	--     function()
	--         awesome.emit_signal('widget::blur:decrease')
	--     end,
	--     {description = 'decrease blur effect by 10%', group = 'utilities'}
	-- ),

	awful.key({ modkey            }, 'n', function() 
			awesome.emit_signal('widget::blue_light:toggle')
		end,
		{description = 'toggle redshift filter', group = 'utilities'}),

	awful.key({ modkey,           }, ']', function ()
			if screen.primary.systray then
				if not screen.primary.tray_toggler then
					local systray = screen.primary.systray
					systray.visible = not systray.visible
				else
					awesome.emit_signal('widget::systray:toggle')
				end
			end
		end, 
		{description = 'toggle systray visibility', group = 'utilities'}),

	awful.key({ modkey, "Control" }, 'l', function()
			awful.spawn.with_shell(apps.default.lock)
		end,
		{description = 'lock the screen', group = 'utilities'})

-- }}} Utilities --
)

-- Tags loop {{{ --
-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	-- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
	local descr_view, descr_toggle, descr_move, descr_toggle_focus
	if i == 1 or i == 9 then
		descr_view = {description = 'view tag #', group = 'tag'}
		descr_toggle = {description = 'toggle tag #', group = 'tag'}
		descr_move = {description = 'move focused client to tag #', group = 'tag'}
		descr_toggle_focus = {description = 'toggle focused client on tag #', group = 'tag'}
	end
	global_keys =
		awful.util.table.join(
		global_keys,
		-- View tag only.
		awful.key({ modkey }, '#' .. i + 9, function()
				local focused = awful.screen.focused()
				local tag = focused.tags[i]
				if tag then
					tag:view_only()
				end
			end,
			descr_view),
		-- Toggle tag display.
		awful.key({ modkey, 'Control'  }, '#' .. i + 9, function()
				local focused = awful.screen.focused()
				local tag = focused.tags[i]
				if tag then
					awful.tag.viewtoggle(tag)
				end
			end,
			descr_toggle),
		-- Move client to tag.
		awful.key({ modkey, 'Shift'    }, '#' .. i + 9, function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:move_to_tag(tag)
					end
				end
			end,
			descr_move
		),
		-- Toggle tag on focused client.
		awful.key({ modkey, 'Control', 'Shift'}, '#' .. i + 9, function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:toggle_tag(tag)
					end
				end
			end,
			descr_toggle_focus
		)
	)
end

-- }}} Tags loop --

return global_keys
