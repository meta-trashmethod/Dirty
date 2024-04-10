local HttpService = game:GetService("HttpService")
local LocalPlayer = game:GetService("Players").LocalPlayer

local bb="TEST"


local FluentModded = {} do

    FluentModded.Ignore = {}
    FluentModded.Folder = "Anastassy"
    FluentModded.Settings = {
        SettingsInterfaceTheme = "Aqua",
        SettingsInterfaceTransparency = true,
        SettingsInterfaceMenuKeybind = "Home",
    }

    function FluentModded:Setup(Library)
        self.Library = Library
        self.Options = Library.Options

        if not isfolder(self.Folder) then
            makefolder(self.Folder)
        end
    
        if isfile(self.Folder .. "/" .. bb .. "_" .. LocalPlayer.Name .. ".cfg") then delfile(self.Folder .. "/" .. bb .. "_" .. LocalPlayer.Name .. ".cfg");

        if not isfile(self.Folder .. "/" .. bb .. "_" .. LocalPlayer.Name .. ".cfg") then
            writefile(self.Folder .. "/" .. bb .. "_" .. LocalPlayer.Name .. ".cfg", "[]");
        end
    end

    function FluentModded:Save()
        local Config = {};

        for Idx, Option in next, self.Options do
            if (not table.find(self.Ignore, Idx)) then
                if Option.Type then
                    Config[Idx] = Option.Type == "Colorpicker" and {{Option.Value[1], Option.Value[2], Option.Value[3] }, Option.Transparency} or Option.Type == "Keybind" and {Option.Value, Option.Mode} or Option.Value
                end
            end
        end

        writefile(self.Folder .. "/" .. bb .. "_" .. LocalPlayer.Name .. ".cfg", HttpService:JSONEncode(Config));
    end

    function FluentModded:Load()
        local Config = HttpService:JSONDecode(readfile(self.Folder .. "/" .. bb .. "_" .. LocalPlayer.Name .. ".cfg"));

        for Option, Value in next, Config do
            if self.Options[Option] and (not table.find(self.Ignore, Option)) then
                self.Options[Option]:SetValue(Value);
            end
        end
    end

    function FluentModded:Build(Tab)
        local Library = self.Library
        
        local Section = Tab:AddSection("Interface")

        Section:AddDropdown("SettingsInterfaceTheme", {
            Title = "Theme",
            Description = "Changes the interface theme.",
            Values = Library.Themes,
            Default = self.Settings.SettingsInterfaceTheme,
            Callback = function(Value)
                Library:SetTheme(Value)
                self.Settings.SettingsInterfaceTheme = Value
                self:Save()
            end
        });

        Section:AddToggle("SettingsInterfaceTransparency", {
            Title = "Transparency",
            Description = "Makes the interface transparent.",
            Default = self.Settings.SettingsInterfaceTransparency,
            Callback = function(Value)
                Library:ToggleTransparency(Value)
                self.Settings.SettingsInterfaceTransparency = Value
                self:Save()
            end
        });

    end

    
end

return FluentModded
