local GameSettings = require('modules/GameSettings')
local GameSession = require('modules/GameSession')

local ToggleHud = {
    hud_group_path = '/interface/hud',
    crosshair_path = '/interface/hud/crosshairs',
    hud_hidden = false,
    hud_settings = {}
}

function ToggleHud:hideHud()
    local hud_group = Game.GetSettingsSystem():GetGroup(self.hud_group_path)

    -- save HUD settings
    self.hud_settings = GameSettings.ExportVars(nil, hud_group)
    -- hide HUD
    GameSettings.SetGroupBool(self.hud_group_path, false)
end

function ToggleHud:restoreHud()
    GameSettings.ImportVars(self.hud_settings)
end

function ToggleHud:new()
    registerForEvent('onInit', function()
        -- restore hud on exit in case it was hidden
        GameSession.OnEnd(function()
            if self.hud_hidden then
                self:restoreHud()
            end
        end)
    end)

    registerInput('ToggleHUD', 'Toggle HUD', function(keypress)
        if not keypress then
            return
        end

        if not self.hud_hidden then
            self:hideHud()
        else
            self:restoreHud()
        end

        self.hud_hidden = not self.hud_hidden
    end)

    registerInput('ToggleCrosshair', 'Toggle Crosshair', function(keypress)
        if not keypress then
            return
        end

        GameSettings.Toggle(self.crosshair_path)
    end)

    return self
end

return ToggleHud:new()
