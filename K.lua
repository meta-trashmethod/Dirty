local a=tick();
local b=loadstring(game:HttpGet"https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua")();
local c=game:GetService"HttpService";
local d=game:GetService"Players".LocalPlayer;

local e="TESTMOD"
local f={}do

function f.Setup(g,h,i)
g.Library=h;
g.Options=h.Options;

if not isfolder"Anastassy"then
makefolder"Anastassy";
end;

if not isfile("Anastassy/"..e.."_"..d.Name..".cfg")then
writefile("Anastassy/"..e.."_"..d.Name..".cfg","[]");
end;

local j=i:AddSection"Interface";

j:AddDropdown("SettingsInterfaceTheme",{
Title="Theme",
Description="Changes the interface theme.",
Values=h.Themes,
Default=h.Theme,
Callback=function(k)
h:SetTheme(k);
f:Save();
end
});

j:AddToggle("SettingsInterfaceTransparent",{
Title="Transparency",
Description="Makes the interface transparent.",
Default=true,
Callback=function(k)
h:ToggleTransparency(k);
f:Save();
end
});

j:AddKeybind("SettingsInterfaceMenuKeybind",{
Title="Minimize Bind",
Default="Insert",
Callback=function(k)
f:Save();
end;
});

h.MinimizeKeybind=h.Options.SettingsInterfaceMenuKeybind;
end;
function f.Save(g)
local h={};

for i,j in next,g.Options do
if j.Type then
if j.Type=="Colorpicker"then
h[i]={Color={j.Hue,j.Sat,j.Vib},Transparency=j.Transparency};
elseif j.Type=="Keybind"then
h[i]={Key=j.Value,Mode=j.Mode};
else
h[i]=j.Value;
end;
end;
end;

writefile("Anastassy/"..e.."_"..d.Name..".cfg",c:JSONEncode(h));
end;

function f.Load(g)
local h=c:JSONDecode(readfile("Anastassy/"..e.."_"..d.Name..".cfg"));

for i,j in next,h do
if g.Options[i]then
if j.Color and j.Transparency then
g.Options[i]:SetValue(j.Color,j.Transparency);
elseif j.Key and j.Mode then
g.Options[i]:SetValue(j.Key,j.Mode);
else
g.Options[i]:SetValue(j);
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
