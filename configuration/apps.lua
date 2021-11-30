local filesystem = require('gears.filesystem')
local config_dir = filesystem.get_configuration_dir()
local utils_dir = config_dir .. 'utilities/'
local rofibin = os.getenv('HOME') .. '/.config/rofi/bin/'

return {
	-- The default applications that we will use in keybindings and widgets
	default = {
		-- Default terminal emulator
		terminal = 'kitty',
		-- Default web browser
		web_browser = 'firefox',
		-- Default text editor
		text_editor = 'nvim',
		-- Default file manager
		file_manager = 'nautilus',
		-- Default media player
		multimedia = 'smplayer',
		-- Default game, can be a launcher like steam
		game = 'steam',
		-- Default voip client
		voip = 'discord',
		-- Default graphics editor
		graphics = 'gimp-2.10',
		-- Default sandbox
		sandbox = 'virt-manager',
		-- Default IDE
		development = '',
		-- Default network manager
		network_manager = 'gnome-control-center wifi',
		-- Default bluetooth manager
		bluetooth_manager = 'gnome-control-center bluetooth',
		-- Default power manager
		power_manager = 'gnome-control-center power',
		-- Default GUI package manager
		package_manager = '',
		-- Default locker
		-- lock = 'awesome-client "awesome.emit_signal(\'module::lockscreen_show\')"',
		lock = 'sleep 1 && screenlock -i ' .. config_dir .. '/theme/wallpapers/lockscreen-bg.jpg',
		-- Default quake terminal
		quake = 'kitty --name QuakeTerminal',
		-- Default rofi global menu
		rofi_global = 'rofi -dpi ' .. screen.primary.dpi .. 
							' -show "Global Search" -modi "Global Search":' .. config_dir .. 
							'/configuration/rofi/global/rofi-spotlight.sh' .. 
							' -theme ' .. config_dir ..
							'/configuration/rofi/global/rofi.rasi',
		-- Default app menu
		-- rofi_appmenu = 'rofi -dpi ' .. screen.primary.dpi ..
		--                     ' -show drun -theme ' .. config_dir ..
		--                     '/configuration/rofi/appmenu/rofi.rasi'
		rofi_appmenu = rofibin .. 'launcher_misc -dpi ' .. screen.primary.dpi,

		-- Alternative power menu
		rofi_powermenu = rofibin .. 'menu_powermenu'

		-- You can add more default applications here
	},

	-- List of apps to start once on start-up
	run_on_start_up = {
		-- Compositor
		'picom -b --experimental-backends --dbus --config ' ..
		config_dir .. '/configuration/picom.conf',
		-- Blueman applet
		-- 'blueman-applet',
		-- Music server
		'mpd',
		-- Polkit
		-- '/usr/bin/lxqt-policykit-agent &'
		-- Load X colors
		'xrdb $HOME/.Xresources',
		-- Audio equalizer
		'easyeffects --gapplication-service',
		-- Lockscreen timer
		-- [[
		-- xidlehook --not-when-fullscreen --not-when-audio --timer 600 \
		-- "awesome-client 'awesome.emit_signal(\"module::lockscreen_show\")'" ""
		-- ]]
		-- Super to open menu
		'xcape -e "Super_L=Super_L|F3"',
		-- screen locker
		'xss-lock -- screenlock -i ' ..
		config_dir .. '/theme/wallpapers/lockscreen-bg.jpg',
		-- Keyboard layout
		'if test -f ~/.Xkeymap; then xkbcomp .Xkeymap $DISPLAY; fi',
		-- Load XDG autostart applications
        'dex --environment Awesome --autostart --search-paths "$XDG_CONFIG_DIRS/autostart:$XDG_CONFIG_HOME/autostart:$HOME/.config/autostart/:/etc/xdg/autostart/"', -- https://github.com/jceb/dex
	},

	-- List of binaries/shell scripts that will execute for a certain task
	utils = {
		-- Fullscreen screenshot
		full_screenshot = 'flameshot full -c -p "$(xdg-user-dir PICTURES)/Capturas de tela/"',
		-- Area screenshot
		area_screenshot = 'flameshot gui -p "$(xdg-user-dir PICTURES)/Capturas de tela/"',
		-- Update profile picture
		update_profile  = utils_dir .. 'profile-image'
	}
}
