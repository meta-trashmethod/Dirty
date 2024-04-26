
local a=tick();
local b=loadstring(game:HttpGet"https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua")();
local c="TESTMOD";
local d=game:GetService"HttpService";
local e=game:GetService"Players".LocalPlayer;
local f={}do

function f:Setup(g,h)
self.Library=g;
self.Options=g.Options;

if not isfolder"Anastassy"then
makefolder"Anastassy";
end;

if not isfile("Anastassy/"..c.."_"..e.Name..".cfg")then
writefile("Anastassy/"..c.."_"..e.Name..".cfg","[]");
end;

local i=h:AddSection"Interface";

i:AddDropdown("SettingsInterfaceTheme",{
Title="Theme",
Description="Changes the interface theme.",
Values=g.Themes,
Default=g.Theme,
Callback=function(j)
g:SetTheme(j);
f:Save();
end
});

i:AddToggle("SettingsInterfaceTransparent",{
Title="Transparency",
Description="Makes the interface transparent.",
Default=true,
Callback=function(j)
g:ToggleTransparency(j);
f:Save();
end
});

i:AddKeybind("SettingsInterfaceMenuKeybind",{
Title="Minimize Bind",
Default="Insert",
Callback=function(j)
f:Save();
end;
});

g.MinimizeKeybind=g.Options.SettingsInterfaceMenuKeybind;
end;
end;

local g=game:GetService"Players";
local h=g.LocalPlayer;

local i=b:CreateWindow{
Title="King Legacy",
SubTitle="by Anastassy",
TabWidth=160,
Size=UDim2.fromOffset(580,460),
Acrylic=true,
Theme="Aqua"
};

local j=i:AddTab{Title="Main",Icon="layers"};

local k=i:AddTab{Title="Stats",Icon="bar-chart-horizontal-big"};

local l=i:AddTab{Title="Teleport",Icon="map-pin"};

local m=i:AddTab{Title="Settings",Icon="settings"};


local n=j:AddSection"Level";

n:AddToggle("Auto_Farm_Level",{Title="Auto Farm Level",Default=false});
n:AddToggle("Auto_Next_World",{Title="Auto Next World",Default=true});

getgenv().Tool={};
pcall(function()
for o,p in next,h.Backpack:GetChildren()do
if p:IsA"Tool"and not table.find(getgenv().Tool,p.Name)then
table.insert(getgenv().Tool,p.Name);
end
end
for q,r in next,h.Character:GetChildren()do
if r:IsA"Tool"and not table.find(getgenv().Tool,r.Name)then
table.insert(getgenv().Tool,r.Name);
end
end
end)

n:AddDropdown("Selected_Weapons",{Title="Select Combat / Weapons",Values=getgenv().Tool,Multi=false});

task.spawn(function()
while true do
wait(1);
pcall(function()
for q in next,getgenv().Tool do
getgenv().Tool[q]=nil
end
for r,s in next,h.Backpack:GetChildren()do
if s:IsA"Tool"and not table.find(getgenv().Tool,s.Name)then
table.insert(getgenv().Tool,s.Name);
end
end
for t,u in next,h.Character:GetChildren()do
if u:IsA"Tool"and not table.find(getgenv().Tool,u.Name)then
table.insert(getgenv().Tool,u.Name);
end
end
b.Options.Selected_Weapons:SetValues(getgenv().Tool);
end);
end;
end);

f:Setup(b,m)
i:SelectTab(1);

local u=tick()-a;
b:Notify{Title="Anastassy",Content="Loaded.",Duration=8};
b:Notify{Title="Anastassy",Content=string.format("Time Taken : %s Seconds",u)};warn("Loaded.")
