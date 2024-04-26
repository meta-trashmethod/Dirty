local a=tick();
local b=loadstring(game:HttpGet"https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua")();
local c=game:GetService"HttpService";
local d=game:GetService"Players".LocalPlayer;

local e="TESTMOD"
local f={}do

function f:Setup(g,h)
self.Library=g;
self.Options=g.Options;

if not isfolder"Anastassy"then
makefolder"Anastassy";
end;

if not isfile("Anastassy/"..e.."_"..d.Name..".cfg")then
writefile("Anastassy/"..e.."_"..d.Name..".cfg","[]");
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
function f:Save()
local g={};

for h,i in next,self.Options do
if i.Type then
if i.Type=="Colorpicker"then
g[h]={Color={i.Hue,i.Sat,i.Vib},Transparency=i.Transparency};
elseif i.Type=="Keybind"then
g[h]={Key=i.Value,Mode=i.Mode};
else
g[h]=i.Value;
end;
end;
end;

writefile("Anastassy/"..e.."_"..d.Name..".cfg",c:JSONEncode(g));
end;

function f:Load()
local g=c:JSONDecode(readfile("Anastassy/"..e.."_"..d.Name..".cfg"));

for h,i in next,g do
if self.Options[h]then
if i.Color and i.Transparency then
self.Options[h]:SetValue(i.Color,i.Transparency);
elseif i.Key and i.Mode then
self.Options[h]:SetValue(i.Key,i.Mode);
else
self.Options[h]:SetValue(i);
end;
end;
end;
end;
end;

local g=b:CreateWindow{
Title="King Legacy",
SubTitle="by Anastassy",
TabWidth=160,
Size=UDim2.fromOffset(580,460),
Acrylic=true,
Theme="Aqua"
};

local h=g:AddTab{Title="Main",Icon="layers"};

local i=g:AddTab{Title="Stats",Icon="bar-chart-horizontal-big"};

local j=g:AddTab{Title="Teleport",Icon="map-pin"};

local k=g:AddTab{Title="Settings",Icon="settings"};


local l=h:AddSection"Level";

l:AddToggle("Auto_Farm_Level",{Title="Auto Farm Level",Default=false});
l:AddToggle("Auto_Next_World",{Title="Auto Next World",Default=true});

getgenv().Tool={};
pcall(function()
for m,n in next,d.Backpack:GetChildren()do
if n:IsA"Tool"and not table.find(getgenv().Tool,n.Name)then
table.insert(getgenv().Tool,n.Name);
end
end
for o,p in next,d.Character:GetChildren()do
if p:IsA"Tool"and not table.find(getgenv().Tool,p.Name)then
table.insert(getgenv().Tool,p.Name);
end
end
end)

l:AddDropdown("Selected_Weapons",{Title="Select Combat / Weapons",Values=getgenv().Tool,Multi=false});

task.spawn(function()
while true do
wait(1);
pcall(function()
for o in next,getgenv().Tool do
getgenv().Tool[o]=nil
end
for p,q in next,d.Backpack:GetChildren()do
if q:IsA"Tool"and not table.find(getgenv().Tool,q.Name)then
table.insert(getgenv().Tool,q.Name);
end
end
for r,s in next,d.Character:GetChildren()do
if s:IsA"Tool"and not table.find(getgenv().Tool,s.Name)then
table.insert(getgenv().Tool,s.Name);
end
end
b.Options.Selected_Weapons:SetValues(getgenv().Tool);
end);
end;
end);

f:Setup(b,k)
g:SelectTab(1);

local r=tick()-a;
b:Notify{Title="Anastassy",Content="Loaded.",Duration=8};
b:Notify{Title="Anastassy",Content=string.format("Time Taken : %s Seconds",r)};
warn'Loaded.'
