local HttpService = game:GetService('HttpService');
local LocalPlayer = game:GetService('Players').LocalPlayer;

local FluentModded = {} do

    FluentModded.Folder = "Anastassy/Test_" .. LocalPlayer.Name .. ".cfg";
    FluentModded.Ignored = {};

    function FluentModded:Setup(Library)
        self.Library = Library;
        self.Options = Library.Options;

        if not isfolder("Anastassy") then
            makefolder("Anastassy");
        end

        if isfile("Anastassy/Test_" .. LocalPlayer.Name .. ".cfg") then
            delfile("Anastassy/Test_" .. LocalPlayer.Name .. ".cfg");
        end

        if not isfile("Anastassy/Test_" .. LocalPlayer.Name .. ".cfg") then
            writefile("Anastassy/Test_" .. LocalPlayer.Name .. ".cfg", "[]");
        end
    end

    function FluentModded:Save()
        local Config = {};

        for Idx, Option in next, self.Options do
            if (not table.find(self.Ignored, Idx)) then
                if Option.Type then
                    if Option.Type == "Colorpicker" then
                        Config[Idx] = {Option.Hue,Option.Sat, Option.Vib};
                    elseif Option.Type == "Keybind" then
                        Config[Idx] = {Option.Value, Option.Mode};
                    else
                        Config[Idx] = Option.Value;
                    end
                end;
            end;
        end;
        writefile(self.Folder, HttpService:JSONEncode(Config));
    end

    function FluentModded:Load()
        local Config = HttpService:JSONDecode(readfile(self.Folder));

        for Option, Value in next, Config do
            if self.Options[Option] and (not table.find(self.Ignored, Option)) then
                self.Option[Option]:SetValue(Value);
            end
        end
    end

    function FluentModded:Build(Tab)
        local Library = self.Library;
        local Section = Tab:AddSection("Interface");

        Section:AddDropdown("SettingsInterfaceTheme", {
            Title = "Theme",
            Description = "Changes the interface theme.",
            Values = Library.Themes,
            Default = "Aqua",
            Callback = function(Value)
                Library:SetTheme(Value)
                FluentModded:Save()
            end
        });

        Section:AddToggle("SettingsInterfaceTransparency", {
            Title = "Transparency",
            Description = "Makes the interface transparent.",
            Default = true,
            Callback = function(Value)
                Library:ToggleTransparency(Value)
                FluentModded:Save()
            end
        });
    end
end
return FluentModded;
