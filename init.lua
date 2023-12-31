local GameSettings = require('modules/GameSettings')

registerHotkey('ToggleHUD', 'Toggle HUD', function()
	GameSettings.ToggleGroup('/interface/hud')
	
end)

registerHotkey('ToggleCrosshair', 'Toggle Crosshair', function()
	GameSettings.Toggle('/interface/hud/crosshairs')
end)
