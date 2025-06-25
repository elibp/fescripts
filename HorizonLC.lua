game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)

if replicatesignal then
game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Success!"; Text = "Made by MelonScripter -- this guy <<<"; Icon = "rbxthumb://type=Asset&id=88461957728423&w=150&h=150"})
else
game:GetService("StarterGui"):SetCore("SendNotification", { Title = ":( Failed"; Text = "Executor does not support replicatesignal."; Icon = "rbxthumb://type=Asset&id=11161636113&w=150&h=150"})
print("Android - FrostWare, Nebula, Delta")
print("iOS - Delta")
print("Windows - Synapse Z")
return end

function Reanimate()
game.TestService.IsSleepAllowed = false
replicatesignal(game.Players.LocalPlayer.ConnectDiedSignalBackend)
wait(game.Players.RespawnTime + .1)
setfpscap(144)
local OptionsAccessories = nil
local OptionsRigTransparency = nil
local OptionsRigR15 = nil
local OptionsRigSetHumanoidDescription = nil
local OptionsRigSetCharacter = nil
local OptionsTeleportXandZoffset = nil
local OptionsTeleportYoffset = nil
local OptionsDisableScripts = nil
local OptionsDisableScreenGUIs = nil
local OptionsFlingEnabled = nil
local OptionsFlingToolFling = nil
local OptionsFlingTimeout = nil
local OptionsFlingVelocity = nil
local OptionsFlingHighlightTargets = nil

local BindableEvent = nil
local Boolean = false
local Humanoid = nil
local Rig = nil
local RigHumanoid = nil
local RigHumanoidRootPart = nil
local Success = false
local Time = nil
local DeltaTime = nil
local LastTime = nil

local Attachments = { }
local BaseParts = { }
local Blacklist = { }
local Enableds = { }
local Handles = { }
local Highlights = { }
local RBXScriptConnections = { }
local RigAccessories = { }
local Tables = { }
local Targets = { }

local CFrame = CFrame
local CFrameAngles = CFrame.Angles
local CFrameidentity = CFrame.identity
local CFramenew = CFrame.new

local coroutine = coroutine
local coroutinecreate = coroutine.create
local coroutineclose = coroutine.close
local coroutineresume = coroutine.resume

local Enum = Enum
local HumanoidStateType = Enum.HumanoidStateType
local Physics = HumanoidStateType.Physics
local Running = HumanoidStateType.Running
local Track = Enum.CameraType.Track
local UserInputType = Enum.UserInputType
local MouseButton1 = UserInputType.MouseButton1
local Touch = UserInputType.Touch

local game = game
local Clone = game.Clone
local Destroy = game.Destroy
local FindFirstAncestorOfClass = game.FindFirstAncestorOfClass
local FindFirstChildOfClass = game.FindFirstChildOfClass
local GetPropertyChangedSignal = game.GetPropertyChangedSignal
local GetChildren = game.GetChildren
local GetDescendants = game.GetDescendants
local IsA = game.IsA
local Players = FindFirstChildOfClass(game, "Players")
local CreateHumanoidModelFromUserId = Players.CreateHumanoidModelFromUserId
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local RunService = FindFirstChildOfClass(game, "RunService")
local PostSimulation = RunService.PostSimulation
local PreRender = RunService.PreRender
local PreSimulation = RunService.PreSimulation
local Connect = PostSimulation.Connect
local Disconnect = Connect(GetPropertyChangedSignal(game, "Parent"), function() end).Disconnect
local Wait = PostSimulation.Wait
local StarterGui = FindFirstChildOfClass(game, "StarterGui")
local SetCore = StarterGui.SetCore
local UserInputService = FindFirstChildOfClass(game, "UserInputService")
local IsMouseButtonPressed = UserInputService.IsMouseButtonPressed
local Workspace = FindFirstChildOfClass(game, "Workspace")
local CurrentCamera = Workspace.CurrentCamera

local Instancenew = Instance.new
local Humanoid = Instancenew("Humanoid")
local ApplyDescription = Humanoid.ApplyDescription
local ChangeState = Humanoid.ChangeState
local GetAppliedDescription = Humanoid.GetAppliedDescription
local Move = Humanoid.Move
Destroy(Humanoid)
local Part = Instancenew("Part")
local GetJoints = Part.GetJoints
Destroy(Part)

local math = math
local mathabs = math.abs
local mathrandom = math.random
local mathsin = math.sin

local osclock = os.clock

local pairs = pairs
local pcall = pcall

local script = script

local string = string
local stringchar = string.char
local stringfind = string.find
local stringrep = string.rep

local table = table
local tableclear = table.clear
local tablefind = table.find
local tableinsert = table.insert
local tableremove = table.remove

local task = task
local taskdefer = task.defer
local taskdelay = task.delay
local taskspawn = task.spawn
local taskwait = task.wait

local sethiddenproperty = sethiddenproperty or function() end

local type = type
local typeof = typeof

local Vector3 = Vector3
local Vector3new = Vector3.new
local Vector3yAxis = Vector3.yAxis
local Vector3zero = Vector3.zero

local CameraCFrame = CFrameidentity

local LimbSize = Vector3new(1, 2, 1)
local TorsoSize = Vector3new(2, 2, 1)

local function BreakJoints(Parent)
for _, Instance in pairs(GetDescendants(Parent)) do
if IsA(Instance, "JointInstance") then
Destroy(Instance)
end
end
end

local function CameraSubject()
CurrentCamera.CameraSubject = RigHumanoid
Wait(PreRender)
CurrentCamera.CFrame = CameraCFrame
end

local function CameraType()
if CurrentCamera.CameraType ~= Track then
CurrentCamera.CameraType = Track
end
end

local function Camera()
local Camera = Workspace.CurrentCamera

if Camera then
CameraCFrame = Camera.CFrame
CurrentCamera = Camera

CameraSubject()
CameraType()

tableinsert(RBXScriptConnections, Connect(GetPropertyChangedSignal(Camera, "CameraSubject"), CameraSubject))
tableinsert(RBXScriptConnections, Connect(GetPropertyChangedSignal(Camera, "CameraType"), CameraType))
end
end

local function FindFirstChildOfClassAndName(Parent, ClassName, Name)
for Index, Instance in pairs(GetChildren(Parent)) do
if IsA(Instance, ClassName) and Instance.Name == Name then
return Instance
end
end
end

local function WaitForChildOfClassAndName(Parent, ...)
local Instance = FindFirstChildOfClassAndName(Parent, ...)

while not Instance and typeof(Parent) == "Instance" do
Instance = FindFirstChildOfClassAndName(Parent, ...)
Wait(Parent.ChildAdded)
end

return Instance
end

local function Invisible(Instance)
if IsA(Instance, "BasePart") or IsA(Instance, "Decal") then
Instance.Transparency = OptionsRigTransparency
elseif IsA(Instance, "ForceField") or IsA(Instance, "Explosion") then
Instance.Visible = false
elseif IsA(Instance, "ParticleEmitter") or IsA(Instance, "Fire") or IsA(Instance, "Sparkles") then
Instance.Enabled = false
end
end

local function DescendantAdded(Instance)
if IsA(Instance, "Attachment") then
local Handle = Instance.Parent

if IsA(Handle, "BasePart") then
local AttachmentsAttachment = Attachments[Instance.Name]

if AttachmentsAttachment then
local MeshId = ""
local TextureId = ""

if IsA(Handle, "MeshPart") then
MeshId = Handle.MeshId
TextureId = Handle.TextureID
else
local SpecialMesh = FindFirstChildOfClass(Handle, "SpecialMesh")

if SpecialMesh then
MeshId = SpecialMesh.MeshId
TextureId = SpecialMesh.TextureId
end
end

for Index, Table in pairs(OptionsAccessories) do
if stringfind(MeshId, Table.MeshId or "") and stringfind(TextureId, Table.TextureId or "") then
local Instance = FindFirstChildOfClassAndName(Rig, "BasePart", Table.Name)

local AlternativeName = Table.AlternativeName
local AlternativeInstance = false

if not Instance and AlternativeName then
Instance = FindFirstChildOfClassAndName(Rig, "BasePart", AlternativeName)
AlternativeInstance = true
end

if Instance and not tablefind(Blacklist, Instance) then
if Table.Blacklist then
tableinsert(Blacklist, Instance)
end
BreakJoints(Handle)

tableinsert(Tables, { Part0 = Handle, Part1 = Instance, CFrame = AlternativeInstance and Table.AllowAlternativeCFrame and Table.AlternativeCFrame or Table.CoordinateFrame, LastPosition = Instance.Position })
return
end
end
end
for Index, Table in pairs(RigAccessories) do
local TableHandle = Table.Handle

if typeof(TableHandle) == "Instance" and Table.MeshId == MeshId and Table.TextureId == TextureId then
BreakJoints(Handle)
tableinsert(Tables, { Part0 = Handle, Part1 = TableHandle, LastPosition = TableHandle.Position })
return
end
end

local Accessory = Handle.Parent

if IsA(Accessory, "Accessory") then
local AccessoryClone = Instancenew("Accessory")
AccessoryClone.Name = Accessory.Name

local HandleClone = Clone(Handle)
Invisible(HandleClone)
BreakJoints(HandleClone)
HandleClone.Parent = AccessoryClone

local Weld = Instancenew("Weld")
Weld.Name = "AccessoryWeld"
Weld.C0 = Instance.CFrame
Weld.C1 = AttachmentsAttachment.CFrame
Weld.Part0 = HandleClone
Weld.Part1 = AttachmentsAttachment.Parent
Weld.Parent = HandleClone

tableinsert(RigAccessories, { Handle = HandleClone, MeshId = MeshId, TextureId = TextureId })
tableinsert(Tables, { Part0 = Handle, Part1 = HandleClone, LastPosition = HandleClone.Position })

AccessoryClone.Parent = Rig
end
end
end
elseif IsA(Instance, "BasePart") then
Instance.CanQuery = false
tableinsert(BaseParts, Instance)
end
end

local function ApplyDescriptionRig()
local Description = GetAppliedDescription(Humanoid)
Description.HatAccessory = ""
Description.BackAccessory = ""
Description.FaceAccessory = ""
Description.HairAccessory = ""
Description.NeckAccessory = ""
Description.FrontAccessory = ""
Description.WaistAccessory = ""
Description.ShouldersAccessory = ""
ApplyDescription(RigHumanoid, Description)

for Index, Instance in pairs(GetDescendants(Rig)) do
Invisible(Instance)
end
end

local function SetCharacter()
taskwait()
LocalPlayer.Character = Rig
end

local Tools = { }

local function CharacterAdded()
local Character = LocalPlayer.Character


if Character and Character ~= Rig then
if OptionsFlingToolFling then
for Index, Backpack in pairs(GetChildren(LocalPlayer)) do
if IsA(Backpack, "Backpack") then
for Index, Instance in pairs(GetChildren(Backpack)) do
if IsA(Instance, "Tool") then
Tools[Instance] = FindFirstChildOfClassAndName(Instance, "BasePart", "Handle")	
Instance.Parent = Character
end
end
end
end
end

for i,v in next, Character:GetDescendants() do
if v:IsA("BasePart") then 
game:GetService("RunService").Heartbeat:connect(function()
pcall(function()
v.CanCollide = false
v.Massless = true
end)
end)
end
end

if OptionsRigSetCharacter then
taskspawn(SetCharacter)
end

tableclear(BaseParts)
tableclear(Blacklist)
tableclear(Tables)

if CurrentCamera then
CameraCFrame = CurrentCamera.CFrame
end

for Index, Instance in pairs(GetDescendants(Character)) do
DescendantAdded(Instance)
end

tableinsert(RBXScriptConnections, Connect(Character.DescendantAdded, DescendantAdded))

Humanoid = WaitForChildOfClassAndName(Character, "Humanoid", "Humanoid")
local HumanoidRootPart = WaitForChildOfClassAndName(Character, "BasePart", "HumanoidRootPart")

if Boolean then
Camera()

if HumanoidRootPart then
RigHumanoidRootPart.CFrame = HumanoidRootPart.CFrame
Boolean = false
end

if OptionsRigSetHumanoidDescription and RigHumanoid and Humanoid then
pcall(ApplyDescriptionRig)
end
end

if HumanoidRootPart then
for Index, Table in pairs(Targets) do
if not HumanoidRootPart then
break
end

if Humanoid then
ChangeState(Humanoid, Physics)
end

local Target = Table.Target

local Timeout = Time + OptionsFlingTimeout
local LastPosition = Target.Position

while Target and HumanoidRootPart do
if Time > Timeout then
break
end

local Position = Target.Position
local LinearVelocity = ( Position - LastPosition ) / DeltaTime

if LinearVelocity.Magnitude > 50 then
break
end

LastPosition = Position

HumanoidRootPart.AssemblyAngularVelocity = OptionsFlingVelocity
HumanoidRootPart.AssemblyLinearVelocity = OptionsFlingVelocity

HumanoidRootPart.CFrame = Target.CFrame * CFramenew(0, 0, 4 * mathsin(Time * 30)) * CFrameAngles(mathrandom(- 360, 360), mathrandom(- 360, 360), mathrandom(- 360, 360)) + ( LinearVelocity * 0.5) 
taskwait()
end

local Highlight = Table.Highlight

if Highlight then
Destroy(Highlight)
end

Targets[Index] = nil
end

if Humanoid then
ChangeState(Humanoid, Running)
end

if RigHumanoidRootPart then
HumanoidRootPart.AssemblyAngularVelocity = Vector3zero
HumanoidRootPart.AssemblyLinearVelocity = Vector3zero
HumanoidRootPart.CFrame = RigHumanoidRootPart.CFrame + Vector3new(mathrandom(- OptionsTeleportXandZoffset, OptionsTeleportXandZoffset), OptionsTeleportYoffset, mathrandom(- OptionsTeleportXandZoffset, OptionsTeleportXandZoffset))
end
end


if Character then
BreakJoints(Character)
end
end
end

local function PostSimulationConnect()
sethiddenproperty(LocalPlayer, "SimulationRadius", 2147483647)

Time = osclock()
DeltaTime = Time - LastTime
LastTime = Time

local Integer = 29 + mathsin(Time)
local Vector3 = Vector3new(0, 0, 0.002 * mathsin(Time * 25))

for Index, Table in pairs(Tables) do
local Part0 = Table.Part0
local Part1 = Table.Part1

if Part0 and # GetJoints(Part0) == 0 and Part0.ReceiveAge == 0 and Part1 then
Part0.AssemblyAngularVelocity = Vector3zero

local Position = Part1.Position
local LinearVelocity = ( ( Table.LastPosition - Position ) / DeltaTime ) * Integer
Table.LastPosition = Position

Part0.AssemblyLinearVelocity = Vector3new(LinearVelocity.X, Integer, LinearVelocity.Z)

Part0.CFrame = Part1.CFrame * ( Table.CFrame or CFrameidentity ) + Vector3
end
end

local Hit = Mouse.Hit
local Holding = IsMouseButtonPressed(UserInputService, MouseButton1)

for Tool, BasePart in pairs(Tools) do
if BasePart.ReceiveAge == 0 and # GetJoints(BasePart) == 0 then
BasePart.CanCollide = false
BasePart.AssemblyAngularVelocity = Vector3new(9e9,9e9,9e9)
BasePart.AssemblyLinearVelocity = Vector3new(9e9,9e9,9e9)

local omgitskorn =  Instance.new("Highlight")  
omgitskorn.Parent = BasePart
omgitskorn.FillTransparency = 0
omgitskorn.FillColor = Color3.fromHSV(255,1,1)
omgitskorn.OutlineColor = Color3.fromHSV(0,0,0)

if Holding then
BasePart.CFrame = Hit  * CFrameAngles(mathrandom(- 360, 360), mathrandom(- 360, 360), mathrandom(- 360, 360))
elseif RigHumanoidRootPart then
BasePart.CFrame = RigHumanoidRootPart.CFrame * CFramenew(0, -5, 0) * CFrameAngles(mathrandom(- 360, 360), mathrandom(- 360, 360), mathrandom(- 360, 360))
end
end
end

if RigHumanoid and Humanoid then
RigHumanoid.Jump = Humanoid.Jump
Move(RigHumanoid, Humanoid.MoveDirection)
end

if not Success then
Success = pcall(SetCore, StarterGui, "ResetButtonCallback", BindableEvent)
else
SetCore(StarterGui, "ResetButtonCallback", BindableEvent)
end
end

local function PreSimulationConnect()
for Index, BasePart in pairs(BaseParts) do
BasePart.CanCollide = false
end
end

local function Fling(Target)
if typeof(Target) == "Instance" then
if IsA(Target, "Humanoid") then
Target = Target.Parent
end
if IsA(Target.Parent, "Accessory") then
Target = FindFirstAncestorOfClass(Target, "Model")
end
if IsA(Target, "Model") then
Target = FindFirstChildOfClassAndName(Target, "BasePart", "HumanoidRootPart")
end
if IsA(Target, "BasePart") then
for Index, Table in pairs(Targets) do
if Table.Target == Target then
return
end
end

local Parent = Target.Parent

local Highlight = nil

if OptionsFlingHighlightTargets then
Highlight = Instancenew("Highlight")
Highlight.Adornee = Parent
Highlight.Parent = Parent
tableinsert(Highlights, Highlight)
end

tableinsert(Targets, {Highlight = Highlight, Target = Target})
end
end
end

local function InputBegan(InputObject)
local UserInputType = InputObject.UserInputType

if UserInputType == MouseButton1 or UserInputType == Touch then
local Target = Mouse.Target

if Target and not Target.Anchored then
local Model = Target.Parent

if IsA(Model, "Model") and FindFirstChildOfClass(Model, "Humanoid") then
local HumanoidRootPart = FindFirstChildOfClassAndName(Model, "BasePart", "HumanoidRootPart")

if HumanoidRootPart then
Fling(HumanoidRootPart)
end
else
Fling(Target)
end
end
end
end

local function gameDescendantAdded(Instance)
if ( OptionsDisableScreenGUIs and IsA(Instance, "ScreenGui") ) or ( OptionsDisableScripts and Instance ~= script and ( IsA(Instance, "LocalScript") or IsA(Instance, "Script") ) ) then
Enableds[Instance] = Instance.Enabled
Instance.Enabled = false

tableinsert(RBXScriptConnections, Connect(GetPropertyChangedSignal(Instance, "Enabled"), function()
Enableds[Instance] = Instance.Enabled
Instance.Enabled = false
end))
end
end

local function Stop()
game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Reanimation"; Text = "Player has reset."; Icon = "rbxthumb://type=Asset&id=12203642851&w=150&h=150"})
replicatesignal(game.Players.LocalPlayer.ConnectDiedSignalBackend)

for Index, RBXScriptConnection in pairs(RBXScriptConnections) do
Disconnect(RBXScriptConnection)
end
for Index, Highlight in pairs(Highlights) do
Destroy(Highlight)
end
for Instance, Boolean in pairs(Enableds) do
Instance.Enabled = Boolean
end

tableclear(Attachments)
tableclear(BaseParts)
tableclear(Enableds)
tableclear(Handles)
tableclear(Highlights)
tableclear(RBXScriptConnections)
tableclear(Tables)
tableclear(Targets)

if Rig then
Destroy(Rig)
end

Destroy(BindableEvent)
SetCore(StarterGui, "ResetButtonCallback", true)
end

local Emperean = {
Stop = Stop,
Start = function(Options)
Options = Options or { }
OptionsAccessories = Options.Accessories or {}
local OptionsRig = Options.Rig
OptionsRigTransparency = OptionsRig.Transparency
OptionsRigR15 = OptionsRig.R15
OptionsRigSetHumanoidDescription = OptionsRig.SetHumanoidDescription
OptionsRigSetCharacter = OptionsRig.SetCharacter
local OptionsTeleport = Options.Teleport or {}
local XandYoffset = OptionsTeleport.XandYoffset
OptionsTeleportXandZoffset = XandYoffset and mathabs(XandYoffset) or 6
OptionsTeleportYoffset = OptionsTeleport.Yoffset or 0
local OptionsDisable = Options.Disable
OptionsDisableScripts = OptionsDisable.Scripts
OptionsDisableScreenGUIs = OptionsDisable.GUIs
local OptionsFling = Options.Fling or {}
OptionsFlingEnabled = OptionsFling.Enabled
OptionsFlingToolFling = OptionsFling.ToolFling
OptionsFlingTimeout = OptionsFling.Timeout or 1.5
OptionsFlingVelocity = OptionsFling.Velocity or Vector3new(0, 4096, 0)
OptionsFlingHighlightTargets = OptionsFling.HighlightTargets

-- Disabled game.DescendantAdded hook to prevent UI issues (chat freezing)

Boolean = true
LastTime = osclock()

Rig = OptionsRigR15 and CreateHumanoidModelFromUserId(Players, 5532894300) or CreateHumanoidModelFromUserId(Players, 5532891747)
Rig.Name = "non"

local Gun = Instance.new("Part", Rig)
Gun.Name = "Gun"
Gun.Transparency = 1
Gun.CanCollide = false

for i,v in next, Rig:GetDescendants() do
if v:IsA("BasePart") then 
game:GetService("RunService").Heartbeat:connect(function()
pcall(function()
v.CanCollide = false
v.CanQuery = false
end)
end)
end
end

RigHumanoid = Rig.Humanoid
RigHumanoidRootPart = Rig.HumanoidRootPart
Rig.Parent = Workspace

for Index, Instance in pairs(GetDescendants(Rig)) do
if IsA(Instance, "Attachment") then
Attachments[Instance.Name] = Instance
else
Invisible(Instance)
end
end

BindableEvent = Instancenew("BindableEvent")
Connect(BindableEvent.Event, Stop)

tableinsert(RBXScriptConnections, Connect(GetPropertyChangedSignal(Workspace, "CurrentCamera"), Camera))

CharacterAdded()
tableinsert(RBXScriptConnections, Connect(GetPropertyChangedSignal(LocalPlayer, "Character"), CharacterAdded))

if OptionsFlingEnabled then
tableinsert(RBXScriptConnections, Connect(UserInputService.InputBegan, InputBegan))
end

tableinsert(RBXScriptConnections, Connect(PreSimulation, PreSimulationConnect))
tableinsert(RBXScriptConnections, Connect(PostSimulation, PostSimulationConnect))

return { 
Rig = Rig,
Options = Options,
Fling = Fling,
},
taskwait()
end,
}

Emperean.Start({
Accessories = {
-- Free Rig
{ Blacklist = true, Name = "Torso", AlternativeName = "UpperTorso", MeshId = "4819720316", TextureId = "4819722776", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 0, -0.25), AlternativeCFrame = CFrameidentity },
{ Blacklist = true, Name = "Right Arm", AlternativeName = "RightLowerArm", MeshId = "3030546036", TextureId = "3033903209", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(-1.57, 0, -1.57), AlternativeCFrame = CFrameidentity },
{ Blacklist = true, Name = "Left Arm", AlternativeName = "LeftLowerArm", MeshId = "3030546036", TextureId = "3360978739", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(-1.57, 0, 1.57), AlternativeCFrame = CFrameidentity },
{ Blacklist = true, Name = "Right Leg", AlternativeName = "RightLowerLeg", MeshId = "3030546036", TextureId = "3033898741", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(-1.57, 0, -1.57), AlternativeCFrame = CFrameidentity },
{ Blacklist = true, Name = "Left Leg", AlternativeName = "LeftLowerLeg", MeshId = "3030546036", TextureId = "3409604993", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(-1.57, 0, 1.57), AlternativeCFrame = CFrameidentity },

-- Cheap Paid Rig
{ Blacklist = true, Name = "Right Arm", AlternativeName = "RightLowerArm", MeshId = "12344206657", TextureId = "12344206675", AllowAlternativeCFrame = false, CoordinateFrame = CFramenew(-0.095, 0, 0) * CFrameAngles(- 2, 0, 0), AlternativeCFrame = CFrameidentity },
{ Blacklist = true, Name = "Left Arm", AlternativeName = "LeftLowerArm", MeshId = "12344207333", TextureId = "12344207341", AllowAlternativeCFrame = false, CoordinateFrame = CFramenew(0.095, 0, 0) * CFrameAngles(- 2, 0, 0), AlternativeCFrame = CFrameidentity },
{ Blacklist = true, Name = "Right Leg", AlternativeName = "RightLowerLeg", MeshId = "11263221350", TextureId = "11263219250", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(1.57, - 1.57, 0), AlternativeCFrame = CFrameidentity },
{ Blacklist = true, Name = "Left Leg", AlternativeName = "LeftLowerLeg", MeshId = "11159370334", TextureId = "11159284657", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(1.57, 1.57, 0), AlternativeCFrame = CFrameidentity },

-- Mesh Rig
{ Blacklist = true, Name = "Torso", AlternativeName = "UpperTorso", MeshId = "127552124837034", TextureId = "131014325980101", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 0, 0), AlternativeCFrame = CFrameidentity },
{ Blacklist = true, Name = "Right Arm", AlternativeName = "RightLowerArm", MeshId = "121304376791439", TextureId = "131014325980101", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 0, 0), AlternativeCFrame = CFrameidentity },
{ Blacklist = true, Name = "Left Arm", AlternativeName = "LeftLowerArm", MeshId = "117287001096396", TextureId = "120169691545791", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 0, 0), AlternativeCFrame = CFrameidentity },    
{ Blacklist = true, Name = "Right Leg", AlternativeName = "RightLowerLeg", MeshId = "121304376791439", TextureId = "131014325980101", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 0, 0), AlternativeCFrame = CFrameidentity },
{ Blacklist = true, Name = "Left Leg", AlternativeName = "LeftLowerLeg", MeshId = "117287001096396", TextureId = "120169691545791", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 0, 0), AlternativeCFrame = CFrameidentity },

-- (OLD) Noob Rig
{ Blacklist = true, Name = "Torso", AlternativeName = "UpperTorso", MeshId = "18640899369", TextureId = "18640899481", AllowAlternativeCFrame = false, CoordinateFrame = CFrameidentity, AlternativeCFrame = CFrameidentity },
{ Blacklist = true, Name = "Right Arm", AlternativeName = "RightLowerArm", MeshId = "18640914129", TextureId = "18640914168", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 0), AlternativeCFrame = CFrameidentity },
{ Blacklist = true, Name = "Left Arm", AlternativeName = "LeftLowerArm", MeshId = "18640914129", TextureId = "18640914168", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 0), AlternativeCFrame = CFrameidentity },    
{ Blacklist = true, Name = "Right Leg", AlternativeName = "RightLowerLeg", MeshId = "18640901641", TextureId = "18640901676", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 0), AlternativeCFrame = CFrameidentity },
{ Blacklist = true, Name = "Left Leg", AlternativeName = "LeftLowerLeg", MeshId = "18640901641", TextureId = "18640901676", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 0), AlternativeCFrame = CFrameidentity },

-- (OLD) Accurate Paid Rig
{ Blacklist = true, Name = "Torso", AlternativeName = "UpperTorso", MeshId = "14241018198", TextureId = "14251599953", AllowAlternativeCFrame = false, CoordinateFrame = CFrameidentity, AlternativeCFrame = CFrameidentity },
{ Blacklist = true, Name = "Right Arm", AlternativeName = "RightLowerArm", MeshId = "17374767929", TextureId = "17374768001", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 1.57), AlternativeCFrame = CFrameidentity },
{ Blacklist = true, Name = "Left Arm", AlternativeName = "LeftLowerArm", MeshId = "17374767929", TextureId = "17374768001", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 1.57), AlternativeCFrame = CFrameidentity },	
{ Blacklist = true, Name = "Right Leg", AlternativeName = "RightLowerLeg", MeshId = "17387586286", TextureId = "17387586304", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 1.57), AlternativeCFrame = CFrameidentity },
{ Blacklist = true, Name = "Left Leg", AlternativeName = "LeftLowerLeg", MeshId = "17387586286", TextureId = "17387586304", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 1.57), AlternativeCFrame = CFrameidentity },

-- (OLD) White arms below
{ Blacklist = true, Name = "Right Arm", AlternativeName = "RightLowerArm", MeshId = "14255522247", TextureId = "14255543546", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 1.57), AlternativeCFrame = CFrameidentity },
{ Blacklist = true, Name = "Left Arm", AlternativeName = "LeftLowerArm", MeshId = "14255522247", TextureId = "14255543546", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 1.57), AlternativeCFrame = CFrameidentity },

-- TEMP
{ Blacklist = false, Name = "Gun", AlternativeName = "Gun", MeshId = "17386451149", TextureId = "17386451217", AllowAlternativeCFrame = false, CoordinateFrame = CFramenew(1.15, -2.15, -1.15)  * CFrameAngles(0, 1.57, -1.57), AlternativeCFrame = CFrameidentity },
{ Blacklist = false, Name = "Gun", AlternativeName = "Gun", MeshId = "17386444997", TextureId = "17386445032", AllowAlternativeCFrame = false, CoordinateFrame = CFramenew(1.15, -7.35, -1.380)  * CFrameAngles(0, 1.57, -1.57), AlternativeCFrame = CFrameidentity },
},
Rig = {
Transparency = 1,
R15 = false,
SetHumanoidDescription = true,
SetCharacter = false
},
Teleport = {
XandZoffset = 0,
Yoffset = -25
},
Disable = {
Scripts = true,
ScreenGUIs = false
},
Fling = {
Enabled = false,
ToolFling = true,
Timeout = 0,
Velocity = Vector3new(0, 0, 0),
HighlightTargets = false
}
})
end

Reanimate()

local script = game:GetObjects("rbxassetid://14964632694")[1]
game:GetService("RunService").RenderStepped:Wait()
local USERNAME,lplr = game:GetService("Players").LocalPlayer.Name,game:GetService("Players").LocalPlayer
local Player = game:GetService("Players"):FindFirstChild(USERNAME)
Mouse = Player:GetMouse()

local function randomstring()
local length = math.random(10,20)
local array = {}
for i = 1,length do
array[i] = string.char(math.random(32,126))
end
return table.concat(array)
end
local Anim,warning,killa = "Idle",false,"mdmg"
local ohgod,Animation_Speed,tiredval,co1,add,k = 0,2,0,0,10,1
local afk,nomain,tiredinterrupted = false,false,false
local ISFLYING,stopeverything,alreadyfixing,attack = false,false,false,false
local WorldModels,DedParts,TOBANISH,vpkill,voidy,banishing = {},{},{},false,false,false
local BAW,cotof = Color3.new(),true
local delays,play,BG,BV = false,true,nil,nil
local GUN,Sheld = nil,false
local ViewPortGui,WorldModel,ViewPortFrame = nil,nil,nil
local Services,weird_classes,PossibleRedoneUSLClassNames = {"SoundService","Chat","MarketplaceService","Players","StarterPlayer","LocalizationService","JointsService","FriendService","InsertService","Lighting","Teams","ReplicatedStorage","TestService","ProximityPromptService"},{"Humanoid","MeshPart","UnionOperation","WedgePart","MeshPart","WorldModel","Mesh","Shirt","Pants","CharacterMesh"},{"Camera", "RemoteEvent", "BindableFunction", "Flag", "Hat", "Hole", "Actor", "Folder", "Team"}
local TiredMsg,Texting1,Texting2,Texting3,Texting4,Texting5,Texting6,Texting7,Texting8,Texting9,Texting10,Texting11,Texting12 = {":>","ok.","Man, I'm starting to get tired fr.","Can i take a nap now?","sleepy...","So, uh... got any coffee?","Wish i was back at home in bed.","if 2x2 = fish, then whats 2/2?","there's prob a skiddy kiddy destroying everything but im too tired to care.","i didnt even know scripts could get tired..."},{"Fix Character","Ｆｉｘ Ｃｈａｒａｃｔｅｒ","Ｆɪx ᴄʜᴀʀᴀᴄᴛᴇʀ","ɹǝʇɔɐɹɐɥƆ xıF","ɿɘƚɔɒɿɒʜƆ xiF","F̸͇̈́i̶͎̾x̸̘̃ ̴̱̅Ć̴̟h̸̼̄a̷̰̐r̶̞͒a̵͉͊c̴̨͊t̸̤͒e̷͉̋r̴͚̊","🅵🅸🆇 🅲🅷🅰🆁🅰🅲🆃🅴🆁","Fᵢₓ Cｈₐᵣₐcｔₑᵣ","ᶠⁱˣ ᶜʰᵃʳᵃᶜᵗᵉʳ","Ŧเא ςђคгคςƈƚєг","Fιx Cԋαɾαƈƚҽɾ","ʄɨӼ ƈɦǟʀǟƈȶɛʀ","fix ¢hคrค¢tēr","FIX ᄃΉΛЯΛᄃƬΣЯ","ƒιχ ¢нαяα¢тєя","£ïx Çhårå¢†êr","₣łӾ ₵Ⱨ₳Ɽ₳₵₮ɆⱤ","千丨乂 匚卄卂尺卂匚ㄒ乇尺","ｷﾉﾒ ᄃんﾑ尺ﾑᄃｲ乇尺","F҉i҉x҉ ҉C҉h҉a҉r҉a҉c҉t҉e҉r҉","F̶i̶x̶ ̶C̶h̶a̶r̶a̶c̶t̶e̶r̶","F̴i̴x̴ ̴C̴h̴a̴r̴a̴c̴t̴e̴r̴","F̷i̷x̷ ̷C̷h̷a̷r̷a̷c̷t̷e̷r̷","F̲i̲x̲ ̲C̲h̲a̲r̲a̲c̲t̲e̲r̲","F̳i̳x̳ ̳C̳h̳a̳r̳a̳c̳t̳e̳r̳","F̾i̾x̾ ̾C̾h̾a̾r̾a̾c̾t̾e̾r̾","F͎i͎x͎ ͎C͎h͎a͎r͎a͎c͎t͎e͎r͎","F͓̽i͓̽x͓̽ ͓̽C͓̽h͓̽a͓̽r͓̽a͓̽c͓̽t͓̽e͓̽r͓̽"},{"Ｓｈｕｔｄｏｗｎ Ｇａｍｅ","Ｓʜᴜᴛᴅᴏᴡɴ ɢᴀᴍᴇ","ǝɯɐＧ uʍopʇnɥS","🅂🄷🅄🅃🄳🄾🅆🄽 🄶🄰🄼🄴","ɘmɒＧ ᴎwobƚuʜＳ","S̵̩̕h̷̫̐u̷͉̐t̷̰͠d̴͎̓o̵̙̓w̵̲̃n̴͚̕ ̵̳͒G̸̟̉ḁ̸̋m̸̳̉e̸͕̿","ˢʰᵘᵗᵈᵒʷⁿ ᴳᵃᵐᵉ","รђยƚ๔๏ฬภ ﻮค๓є","Sԋυƚԃσɯɳ Gαɱҽ","ʂɧųɬɖơῳŋ ɠąɱɛ","ƧΉЦƬDӨЩП GΛMΣ","ѕнυт∂σωη gαмє","§hµ†Ððwñ Gåmê","₴ⱧɄ₮ĐØ₩₦ ₲₳₥Ɇ","丂卄ㄩㄒDㄖ山几 G卂爪乇","丂んひｲりのW刀 ムﾑﾶ乇","S҉h҉u҉t҉d҉o҉w҉n҉ ҉G҉a҉m҉e҉","S̶h̶u̶t̶d̶o̶w̶n̶ ̶G̶a̶m̶e̶","S̴h̴u̴t̴d̴o̴w̴n̴ ̴G̴a̴m̴e̴","S̷h̷u̷t̷d̷o̷w̷n̷ ̷G̷a̷m̷e̷","S̲h̲u̲t̲d̲o̲w̲n̲ ̲G̲a̲m̲e̲","S̳h̳u̳t̳d̳o̳w̳n̳ ̳G̳a̳m̳e̳","S̾h̾u̾t̾d̾o̾w̾n̾ ̾G̾a̾m̾e̾","S͎h͎u͎t͎d͎o͎w͎n͎ ͎G͎a͎m͎e͎","S͓̽h͓̽u͓̽t͓̽d͓̽o͓̽w͓̽n͓̽ ͓̽G͓̽a͓̽m͓̽e͓̽"},{"Horizon LC","Horizon LC","H0r1z0n 1C","Horizon LC","H0rizon LC","Hor1zon LC","Horiz0n LC","HOrizon LC","HOrizon LC","HOrizon LC","hOrIzOn LC","HORizon LC","hORIZon LC","HORizon LC","HoRIzOn LC","H0rIzON LC","HOR1ZON LC","HORizon LC","HORIzon LC","HORIzon LC","HORRIZON LC","HORIzon LC","HORIZon LC","HORIZon LC","HØrizØn LC","ⱧOrizon LC","HORIZon LC","HORIZOn LC","H0RIZON 1C","HORIZOn LC","HORIZOn LC","HORIZON LC","ⱧORIZON L₵","HORIZON LC","horÌz0n LC","HORIZON LC","H0RIZO₦ LC","hORIZON LC","hORIZON LC","hORIZON LC","hOr1Ⱬ0N L3","hoRIZON LC","hoRIZON LC","hOⱤ|Z()N LC","hoRIZON LC","HOяiZon ᄂC","horIZON LC","horIZON LC","horIZON LC","HσRIZOn IC","HÖR1ZÖn LC","horiZON LC","horiZON LC","horiZON LC","horizON LC","hoRiZӨn ιc","horizON LC","horizON LC","HσrRiiZ0N L1C","Hor1zEn LC","horizoN LC","horizoN LC","HoRiZON LC","horizoN LC","horizon LC","horizon LC","hoRIzOñ lC","Ή0riZ[]n Lc","H_r'Zon |3","horizon LC","Horizon LC","H(R-+N LC","Horizon LC","Horizon LC","horizon lc","HoRIZon LC","Horizon lc"},{"Berg","berg","B3rg","b3rg","B_rg","BERG","Be[]g"},{"Endeavors","Endeavors","End3av0rs","EnDeVorS","3ndEv0eZ","Endeavors","Endeavors","endeavors","3nd3av0rs","end3v0rs","Endev()rs"},{"Last Standing","L4st St4nding","LaSt StaNdiNG","LasT standIng","lAst STAndiNG","l4St st4nDING","L@st stANdiNg","|ast $tand'ng"},{"Menace","Menace","Men&ce","Menace","Menace","Menace","Menace","Menace","Menace","Menace","Men@ce","Menace","Menace","Menace","Menace","Menace","Menace","Menace","M3nace","Menace","Menace","Menace","Menace","Menace","Menace","Menace","Menac3","Menace","Menace","Menace","Menace","Menace","Menace","Menace","M3n@c(3","menaC","Menac"},{"iNSaNiTY","InSAnITy","inSaNItY","iNSANitY","InsANIty","iNsanIty","INsANiTY","insAnitY","iNsaNiTy","InsAnItY","iNsAnItY","iNSaNiTY"},{"0100101","0010011","1001101","0111010","0010110","1100100","10111O1","0100001","0101001","0001001","1011101","0111001","1110110","1001110","0100100"},{"Gl|tch","Gl!tch","GL:TcH","Gl1tCH","GlItch","Gl_tCh","Glit(h","G\itch","Gi1t[ch","g\1t(h","GlIt=_","Glitch"},{"Witch","Witch","Witch","Witch","Witch","Witch","Witch","Witch","Witch","Witch","Witch","Witch","W1tch"},{"Immortality King"}
local FONTS,Style,Weight = {Enum.Font.Arcade,Enum.Font.Cartoon,Enum.Font.Code,Enum.Font.SciFi,Enum.Font.Antique,Enum.Font.Arial,Enum.Font.ArialBold,Enum.Font.Fantasy,Enum.Font.Garamond,Enum.Font.Legacy,Enum.Font.GothamSemibold,Enum.Font.Gotham,Enum.Font.GothamBlack,Enum.Font.Highway,Enum.Font.Bodoni,},{Enum.FontStyle.Italic,Enum.FontStyle.Normal},{Enum.FontWeight.Regular,Enum.FontWeight.Bold,Enum.FontWeight.Thin,Enum.FontWeight.Heavy,Enum.FontWeight.Light,Enum.FontWeight.Medium,Enum.FontWeight.SemiBold,Enum.FontWeight.ExtraBold,Enum.FontWeight.ExtraLight}
local scriptStorage = game:GetService("TextChatService"):FindFirstChildOfClass("ChatWindowConfiguration")
local Work = game:GetService("Workspace")
local Terrain = Work:FindFirstChild("Terrain")
local TweenService = game:GetService("TweenService")
local Lightin = game:GetService("Lighting")
local Debris = game:GetService("Debris")

local S,Player_Size,walkspeed,sensitivity,walkspeed2,walkspeed3 = 1,1,16,12,50,14
local shade = Color3.new()
local BallSize = Vector3.new(1*(4 / 3),1*(4 / 3),1*(4 / 3))
local SquareSize = Vector3.new(1,1,1)
function rayCast(Position,Direction,Range,Ignore)
return Work:FindPartOnRay(Ray.new(Position,Direction.unit * (Range or 999.999)),Ignore) 
end 
function Raycast(POSITION, DIRECTION, RANGE, IGNOREDECENDANTS)
return Work:FindPartOnRay(Ray.new(POSITION, DIRECTION.unit * RANGE), IGNOREDECENDANTS)
end
function CastProperRay(StartPos, EndPos, Distance, Ignore)
local DIRECTION = CF(StartPos,EndPos).lookVector
return Raycast(StartPos, DIRECTION, Distance, Ignore)
end
IT = Instance.new
CF = CFrame.new
VT = Vector3.new
RAD = math.rad
C3 = Color3.new
UD2 = UDim2.new
BRICKC = BrickColor.new
ANGLES = CFrame.Angles
EULER = CFrame.fromEulerAnglesXYZ
COS = math.cos
ACOS = math.acos
SIN = math.sin
ASIN = math.asin
ABS = math.abs
MRANDOM = math.random
FLOOR = math.floor
radian = math.rad
random = math.random
Vec3 = Vector3.new
Inst = Instance.new
cFrame = CFrame.new
Euler = CFrame.fromEulerAnglesXYZ
vt = Vector3.new
bc = BrickColor.new
br = BrickColor.random
it = Instance.new
cf = CFrame.new
angles = CFrame.Angles
Cf = CFrame.new
Cos = math.cos
Sin = math.sin
Abs = math.abs
Rad = math.rad
V3 = {N=Vector3.new,FNI=Vector3.FromNormalId,A=Vector3.FromAxis}
M = {C=math.cos,R=math.rad,S=math.sin,P=math.pi,RNG=math.random,MRS=math.randomseed,H=math.huge,RRNG = function(min,max,div) return math.rad(math.random(min,max)/(div or 1)) end}
R3 = {N=Region3.new}
euler=CFrame.fromEulerAnglesXYZ
cn = CFrame.new
rad = math.rad
cos = math.cos
sin = math.sin
function cn2(x,y,z)
return cn(x*S,y*S,z*S)
end
local function weldBetween(a,b)
local weldd = Instance.new("Weld")
weldd.Part0 = a
weldd.Part1 = b
weldd.C0 = CFrame.new()
weldd.C1 = b.CFrame:inverse() * a.CFrame
weldd.Parent = b
return weldd
end
function CreateConnection(TYPE,PARENT,PART0,PART1,C0,C1)
local NEWWELD = Instance.new(TYPE)
NEWWELD.Part0 = PART0
NEWWELD.Part1 = PART1
NEWWELD.C0 = C0
NEWWELD.C1 = C1
NEWWELD.Parent = PARENT
return NEWWELD
end	
local Character = workspace.non
local CloneStuff = script:Clone()
CloneStuff.Parent = Work
local savedchar = Character:Clone()
local Humanoid = Character.Humanoid
GUN = CloneStuff.DarkMegaGunnModel
local LeftArm = Character["Left Arm"]
local RightArm = Character["Right Arm"]
local LeftLeg = Character["Left Leg"]
local RightLeg = Character["Right Leg"]
local Head = Character.Head
local Torso = Character.Torso
local RootPart = Character.HumanoidRootPart
local Effects = CloneStuff.Effects
local LeftEye = CloneStuff.Head.Eyes.LeftEye
local RightEye = CloneStuff.Head.Eyes.RightEye
local Hair = CloneStuff["Amazing-Hair"] Hair.Color = Color3.new()
local Vis = CloneStuff["Visualizer"]
local Vis2 = CloneStuff["Visualizer2"] Vis2.Color = Color3.new()
local Gunneon = GUN.NeonParts
local GunJoint = GUN.Joint.Weld
local GunBase = GUN.Base
local GunAdds = GUN.Baseplate
local Hole = GUN.Hole
local Holetwo = GUN.Hole2
local outerm = Vis.Mesh
local outerm2 = Vis2.Mesh
local Outlines = CloneStuff.Outlines
local OutHead = Outlines["OutlineHead"]
local OutTorso = Outlines["TorsoOutline"]
local OutLA = Outlines["LeftArmOutline"]
local OutLL = Outlines["LeftLegOutline"]
local OutRA = Outlines["RightArmOutline"]
local OutRL = Outlines["RightLegOutline"]
local OutBase = Outlines["Base"]
local OutHair = Outlines["HairOutline"]
local OutHat = Outlines["HatOutline"]
GUN.Joint.Weld.Part0 = RightArm
Vis.Weld.Part0 = HumanoidRootPart
Vis2.Weld.Part0 = HumanoidRootPart

local Weld = Instance.new("Weld")
Weld.Part0 = GUN.Hole
Weld.Part1 = workspace.non["Gun"]
Weld.Parent = workspace.non
Weld.C0 = CFrame.new(6.15, -1.5, 1.15) * CFrame.Angles(1.57, 0, -1.57)

function CreateMesh(MESH,PARENT,MESHTYPE,MESHID,TEXTUREID,SCALE,OFFSET)
local NEWMESH = Instance.new(MESH)
if MESH == "SpecialMesh" then
NEWMESH.MeshType = MESHTYPE
if MESHID ~= "nil" and MESHID ~= "" then
NEWMESH.MeshId = "rbxassetid://"..MESHID
end
if TEXTUREID ~= "nil" and TEXTUREID ~= "" then
NEWMESH.TextureId = "rbxassetid://"..TEXTUREID
end
end
NEWMESH.Offset = OFFSET or Vector3.new()
NEWMESH.Scale = SCALE
NEWMESH.Parent = PARENT
return NEWMESH
end
function CreatePart(IsBase,FORMFACTOR,PARENT,MATERIAL,REFLECTANCE,TRANSPARENCY,BRICKCOLOR,NAME,SIZE,ANCHOR)
if IsBase == true then
NEWPART = Instance.new("Part")
else
NEWPART = Instance.new("SkateboardPlatform")
end
NEWPART.Massless = true
NEWPART.formFactor = FORMFACTOR
NEWPART.Reflectance = REFLECTANCE
NEWPART.Transparency = TRANSPARENCY
NEWPART.CanCollide = false
NEWPART.CanTouch = false
NEWPART.CanQuery = false
NEWPART.Locked = true
NEWPART.Anchored = true
if ANCHOR == false then
NEWPART.Anchored = false
end
NEWPART.Color = BRICKCOLOR
NEWPART.Name = randomstring()
NEWPART.Size = SIZE
NEWPART.Position = Torso.Position
NEWPART.Material = MATERIAL
NEWPART:BreakJoints()
NEWPART.Parent = PARENT
return NEWPART
end
function CreateSound(ID,PARENT,VOLUME,PITCH,DOESLOOP)
local S = Instance.new("Sound")
local NEWSOUND = nil
local timpos = false
coroutine.resume(coroutine.create(function()
NEWSOUND = S:Clone()
NEWSOUND.Parent = PARENT
NEWSOUND.Volume = VOLUME
NEWSOUND.Pitch = PITCH
NEWSOUND.SoundId = "rbxassetid://"..ID
NEWSOUND:play()
if DOESLOOP == true then
NEWSOUND.Looped = true
else
coroutine.resume(coroutine.create(function()
pcall(function()
if warning == false then
repeat Swait() until NEWSOUND.Playing == false
else
repeat task.wait() until NEWSOUND.Playing == false
end
NEWSOUND:Destroy()
end)
end))
end
end))
return NEWSOUND
end
function MakeForm(PART,TYPE)
if TYPE == "Cyl" then
local MSH = Instance.new("CylinderMesh",PART)
elseif TYPE == "Ball" then
local MSH = Instance.new("SpecialMesh",PART)
MSH.MeshType = "Sphere"
elseif TYPE == "Wedge" then
local MSH = Instance.new("SpecialMesh",PART)
MSH.MeshType = "Wedge"
end
end
local RootJoint = RootPart.RootJoint
local Neck = Torso["Neck"]
local RightShoulder = Torso["Right Shoulder"]
local LeftShoulder = Torso["Left Shoulder"]
local RightHip = Torso["Right Hip"]
local LeftHip = Torso["Left Hip"]
local ShieldPart = CreatePart(false,3,RootPart,"ForceField",0,1,LeftEye.Color,"Shieldlol",Vector3.new(4,1,2),false)
ShieldPart.CastShadow = false
ShieldPart.CanCollide = false
ShieldPart.CanTouch = false
ShieldPart.CanQuery = false
local Shield = Instance.new("SpecialMesh",ShieldPart)
Shield.MeshType = "Sphere"
Shield.Scale = Vector3.new(4, 16, 8)
local ShieldWeld = weldBetween(RootPart,ShieldPart)
local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))
local Torsovelocity = (RootPart.Velocity * Vector3.new(1,0,1)).Magnitude 
local rc0 = CFrame.new() * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(180))
local nc0 = CFrame.new(0,1,0) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(180))
local rscp = CFrame.new(-.5,0,0) * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))
local lscp = CFrame.new(.5,0,0) * CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))
LHC0=CF(-1,-1,0,-0,-0,-1,0,1,0,1,0,0)
LHC1=CF(-0.5,1,0,-0,-0,-1,0,1,0,1,0,0)
RHC0=CF(1,-1,0,0,0,1,0,1,0,-1,-0,-0)
RHC1=CF(0.5,1,0,0,0,1,0,1,0,-1,-0,-0)
hc0,lac0,rac0,llc0,rlc0,sine,animspeed = cn2(0,1.5,0),cn2(-1.5,0,0),cn2(1.5,0,0),cn2(-0.5,-2,0),cn2(0.5,-2,0),0,1/4
hoffset,toffset,laoffset,raoffset,lloffset,rloffset,gunoffset = hc0,cn(),lac0,rac0,llc0,rlc0,cn2(-0.365001678,-2.11000013,-0.125)*euler(rad(90),rad(180),0)


eee = Instance.new("Sound",RootPart)
eee.Volume = 10
eee.PlaybackSpeed = 1
eee.Pitch = 1
eee.SoundId = "rbxassetid://1841425036"
eee:Play()
eee.Name = randomstring()
eee.Looped = true
eee.RollOffMode = "LinearSquare"
eee.RollOffMaxDistance = 200
eee.RollOffMinDistance = 10
eee.TimePosition = 1
sick = eee
PlaybackLoudness = eee.PlaybackLoudness
local taunt = Instance.new("StringValue")
taunt.Value = "None"
local TauntRemote = Instance.new("BindableEvent")
TauntRemote.Event:connect(function(Taunt, Audio)
taunt.Value = Taunt
eee.SoundId = "rbxassetid://"..Audio
end)

local NAMEMODE2 = Instance.new("BillboardGui",Effects)
NAMEMODE2.AlwaysOnTop = false
NAMEMODE2.Size = UDim2.new(7,35,3,15)
NAMEMODE2.StudsOffset = Vector3.new(0,1.8,0)
NAMEMODE2.MaxDistance = 10000
NAMEMODE2.Adornee = Head
NAMEMODE2.Name = "Name2"
NAMEMODE2.ResetOnSpawn = false
local NAMEMODE = Instance.new("TextLabel",NAMEMODE2)
NAMEMODE.BackgroundTransparency = 1
NAMEMODE.TextScaled = true
NAMEMODE.BorderSizePixel = 0
NAMEMODE.TextSize = 35
NAMEMODE.TextStrokeTransparency = 0
NAMEMODE.Size = UDim2.new(1,0,0.5,0)
NAMEMODE.Parent = NAMEMODE2
coroutine.resume(coroutine.create(function()
while true do
task.wait()
if not alreadyfixing and NAMEMODE:IsDescendantOf(game) then
NAMEMODE.TextColor3 = LeftEye.Color
--NAMEMODE.Font = FONTS[MRANDOM(12, #FONTS)]
NAMEMODE.Rotation = MRANDOM(-5,5)
NAMEMODE.Position = UDim2.new(math.random(-.4,.4),math.random(-5,5),.05,math.random(-5,5))
if taunt.Value == "None" or taunt.Value == "taunt" or taunt.Value == "taunt2" or taunt.Value == "Fave" or taunt.Value == "Krump" or taunt.Value == "Sit" then
NAMEMODE.Text = Texting3[MRANDOM(1, #Texting3)]
elseif taunt.Value == "GOD" then
NAMEMODE.Text = Texting5[MRANDOM(1, #Texting5)]
elseif taunt.Value == "Superior" then
NAMEMODE.Text = Texting6[MRANDOM(1, #Texting6)]
elseif taunt.Value == "KickGod" then
NAMEMODE.Text = Texting7[MRANDOM(1, #Texting7)]
elseif taunt.Value == "iNSaNiTY" then
NAMEMODE.Text = Texting8[MRANDOM(1, #Texting8)]
elseif taunt.Value == "Err0r" then
NAMEMODE.Text = Texting9[MRANDOM(1, #Texting9)]
elseif taunt.Value == "Glitch" then
NAMEMODE.Text = Texting10[MRANDOM(1, #Texting10)]
elseif taunt.Value == "Fallen" then
NAMEMODE.Text = Texting11[MRANDOM(1, #Texting11)]
elseif taunt.Value == "Berger" then
NAMEMODE.Text = Texting4[MRANDOM(1, #Texting4)]
elseif taunt.Value == "KingMan" then
NAMEMODE.Text = Texting12[MRANDOM(1, #Texting12)]
elseif taunt.Value == "Lost" then
NAMEMODE.Text = "Lost"
elseif taunt.Value == "Toxic" then
NAMEMODE.Text = "Toxic"
end
end
end
end))
local soundfixing = false
local function soundfixer()
soundfixing = true
pcall(function()
eee:Destroy()
end)
eee = Instance.new("Sound",RootPart)
eee.Volume = 10
eee.Pitch = 1
eee.PlaybackSpeed = 1
eee.SoundId = songid.Value
eee:Play()
eee.Name = randomstring()
eee.Looped = true
eee.RollOffMode = "LinearSquare"
eee.RollOffMaxDistance = 200
eee.RollOffMinDistance = 10
eee.TimePosition = SongSync.Value
eee.DescendantAdded:Connect(function(v)
if stopeverything then wait(math.huge) end
if v:IsA("DistortionSoundEffect") then 
return 
end
if v:IsA("SoundEffect") then
v.Enabled = false
v:GetPropertyChangedSignal("Enabled"):Connect(function()
if stopeverything then wait(math.huge) end
if v.Enabled ~= false then
v.Enabled = false
end
end)
end
game:GetService("Debris"):AddItem(v,.01)
end)
soundfixing = false
end

if lplr.Name == USERNAME then
local gui = Instance.new("ScreenGui")
gui.Name = randomstring()
local fixcharbutton = Instance.new("TextButton",gui)
fixcharbutton.TextScaled = true
--fixcharbutton.Font = "Code"
fixcharbutton.Name = randomstring()
fixcharbutton.BorderSizePixel = 0
fixcharbutton.BackgroundTransparency = .5
fixcharbutton.TextStrokeColor3 = shade
fixcharbutton.TextStrokeTransparency = 0
fixcharbutton.BackgroundColor3 = Color3.new(0.227451, 0.227451, 0.227451)
--fixcharbutton.Text = "Fix Character"
fixcharbutton.Size = UDim2.new(.25,0,0,36)
fixcharbutton.AnchorPoint = Vector2.new(1,1)
fixcharbutton.Position = UDim2.new(.5,0,0,0)
coroutine.resume(coroutine.create(function()
while fixcharbutton.Parent ~= nil do
task.wait()
fixcharbutton.FontFace.Style = Style[MRANDOM(1,#Style)]
fixcharbutton.FontFace.Weight = Weight[MRANDOM(1,#Weight)]
fixcharbutton.Font = FONTS[MRANDOM(1, #FONTS)]
fixcharbutton.Text = Texting1[MRANDOM(1, #Texting1)]
end
end))
local exitbutton = Instance.new("TextButton",gui)
exitbutton.TextScaled = true
--exitbutton.Font = "Code"
exitbutton.Name = randomstring()
exitbutton.BorderSizePixel = 0
exitbutton.BackgroundTransparency = .5
exitbutton.TextStrokeColor3 = shade
exitbutton.TextStrokeTransparency = 0
exitbutton.BackgroundColor3 = Color3.new(0.227451, 0.227451, 0.227451)
--exitbutton.Text = "Shutdown Game"
exitbutton.Size = UDim2.new(.25,0,0,36)
exitbutton.AnchorPoint = Vector2.new(0,1)
exitbutton.Position = UDim2.new(.5,0,0,0)
coroutine.resume(coroutine.create(function()
while exitbutton.Parent ~= nil do
task.wait()
exitbutton.FontFace.Style = Style[MRANDOM(1,#Style)]
exitbutton.FontFace.Weight = Weight[MRANDOM(1,#Weight)]
exitbutton.Font = FONTS[MRANDOM(1, #FONTS)]
exitbutton.Text = Texting2[MRANDOM(1, #Texting2)]
end
end))
local LCImage = Instance.new("ImageLabel",gui)
LCImage.AnchorPoint = Vector2.new(0,0.5)
LCImage.BackgroundColor3 = Color3.new(0.227451, 0.227451, 0.227451)
LCImage.BackgroundTransparency = 1
LCImage.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
LCImage.BorderSizePixel = 0
LCImage.LayoutOrder = 9999999999999999999999999999999e9999999999999999999999999999999
LCImage.Name = randomstring()
LCImage.Position = UDim2.new(.75,0,0,0)
LCImage.Size = UDim2.new(0,98,0,87)
LCImage.Image = "http://www.roblox.com/asset/?id=10199833198"
LCImage.Rotation = 0
gui.Parent = Player:FindFirstChildOfClass("PlayerGui")
fixcharbutton.MouseButton1Click:Connect(function()
print("haha")
chatfunc("Cannot fix script.")
end)
exitbutton.MouseButton1Click:Connect(function()
Player:Kick("ciao")
end)
local fixinggui = false
local function fixgui()
fixinggui = true
pcall(function()
gui:Destroy()
end)
gui = Instance.new("ScreenGui")
gui.Name = randomstring()
fixcharbutton = Instance.new("TextButton",gui)
fixcharbutton.TextScaled = true
--fixcharbutton.Font = "Code"
fixcharbutton.Name = randomstring()
fixcharbutton.BorderSizePixel = 0
fixcharbutton.BackgroundTransparency = .5
fixcharbutton.TextStrokeColor3 = shade
fixcharbutton.TextStrokeTransparency = 0
fixcharbutton.BackgroundColor3 = Color3.new(0.227451, 0.227451, 0.227451)
--fixcharbutton.Text = "Fix Character"
fixcharbutton.Size = UDim2.new(.25,0,0,36)
fixcharbutton.AnchorPoint = Vector2.new(1,1)
fixcharbutton.Position = UDim2.new(.5,0,0,0)
coroutine.resume(coroutine.create(function()
while fixcharbutton.Parent ~= nil do
task.wait()
fixcharbutton.FontFace.Style = Style[MRANDOM(1,#Style)]
fixcharbutton.FontFace.Weight = Weight[MRANDOM(1,#Weight)]
fixcharbutton.Font = FONTS[MRANDOM(1, #FONTS)]
fixcharbutton.Text = Texting1[MRANDOM(1, #Texting1)]
end
end))
exitbutton = Instance.new("TextButton",gui)
exitbutton.TextScaled = true
--exitbutton.Font = "Code"
exitbutton.Name = randomstring()
exitbutton.BorderSizePixel = 0
exitbutton.BackgroundTransparency = .5
exitbutton.TextStrokeColor3 = shade
exitbutton.TextStrokeTransparency = 0
exitbutton.BackgroundColor3 = Color3.new(0.227451, 0.227451, 0.227451)
--exitbutton.Text = "Shutdown Game"
exitbutton.Size = UDim2.new(.25,0,0,36)
exitbutton.AnchorPoint = Vector2.new(0,1)
exitbutton.Position = UDim2.new(.5,0,0,0)
coroutine.resume(coroutine.create(function()
while exitbutton.Parent ~= nil do
task.wait()
exitbutton.FontFace.Style = Style[MRANDOM(1,#Style)]
exitbutton.FontFace.Weight = Weight[MRANDOM(1,#Weight)]
exitbutton.Font = FONTS[MRANDOM(1, #FONTS)]
exitbutton.Text = Texting2[MRANDOM(1, #Texting2)]
end
end))
LCImage = Instance.new("ImageLabel",gui)
LCImage.AnchorPoint = Vector2.new(0,0.5)
LCImage.BackgroundColor3 = Color3.new(0.227451, 0.227451, 0.227451)
LCImage.BackgroundTransparency = 1
LCImage.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
LCImage.BorderSizePixel = 0
LCImage.LayoutOrder = 9999999999999999999999999999999e9999999999999999999999999999999
LCImage.Name = randomstring()
LCImage.Position = UDim2.new(.75,0,0,0)
LCImage.Size = UDim2.new(0,98,0,87)
LCImage.Rotation = 0
LCImage.Image = "http://www.roblox.com/asset/?id=10199833198"
gui.Parent = Player:FindFirstChildOfClass("PlayerGui")
fixcharbutton.MouseButton1Click:Connect(function()
if not alreadyfixing then
characterfixer()
end
end)
exitbutton.MouseButton1Click:Connect(function()
if lplr.Name == USERNAME then
MainFolder.Anhilate:FireServer()
end
end)
fixinggui = false
end
Player:FindFirstChildOfClass("PlayerGui").DescendantRemoving:Connect(function(v)
if not fixinggui then
if v == gui or v:IsDescendantOf(gui) then
fixgui()
end
end
end)
coroutine.resume(coroutine.create(function()
local noob = 0
repeat noob = noob + game:GetService("RunService").RenderStepped:Wait() until noob >= .1
while true do
if not fixinggui and not alreadyfixing then
fixcharbutton.TextColor3 = Gunneon.Color
exitbutton.TextColor3 = Gunneon.Color
LCImage.ImageColor3 = Gunneon.Color
LCImage.Rotation = LCImage.Rotation + .5
end
task.wait()
end
end))
end

if lplr.Name == USERNAME then
pcall(function()
Work.CurrentCamera.CameraSubject = Torso
Work.CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function()
if not alreadyfixing and Work.CurrentCamera.CameraSubject ~= Torso then
Work.CurrentCamera.CameraSubject = Torso
end
end)
end)
end 

ArtificialHB = Instance.new("BindableEvent", script)
ArtificialHB.Name = "ArtificialHB"

script:WaitForChild("ArtificialHB")

frame = 1/60

tf = 0
allowframeloss = false
tossremainder = false
lastframe = tick()
script.ArtificialHB:Fire()

game:GetService("RunService").Heartbeat:connect(function(s, p)
tf = tf + s
if tf >= frame then
if allowframeloss then
script.ArtificialHB:Fire()
lastframe = tick()
else
for i = 1, math.floor(tf / frame) do
script.ArtificialHB:Fire()
end
lastframe = tick()
end
if tossremainder then
tf = 0
else
tf = tf - frame * math.floor(tf / frame)
end
end
end)

function PositiveAngle(NUMBER)
if NUMBER >= 0 then
NUMBER = 0
end
return NUMBER
end

function NegativeAngle(NUMBER)
if NUMBER <= 0 then
NUMBER = 0
end
return NUMBER
end

function Swait(NUMBER)
if NUMBER == 0 or NUMBER == nil then
ArtificialHB.Event:wait()
else
for i = 1, NUMBER do
ArtificialHB.Event:wait()
end
end
end


swait = Swait


coroutine.resume(coroutine.create(function()
while not stopeverything do
task.wait()
if not alreadyfixing then
BAW = Color3.new(co1,co1,0)
if co1 >= 250 then
cotof = false
elseif co1 <= 4 then
cotof = true
end
if cotof == true then
co1 = co1 + 1*3
elseif cotof == false then
co1 = co1 - 1*3
end
OutHead.Color = Gunneon.Color
OutTorso.Color = Gunneon.Color
OutLA.Color = Gunneon.Color
OutLL.Color = Gunneon.Color
OutRA.Color = Gunneon.Color
OutRL.Color = Gunneon.Color
OutBase.Color = Gunneon.Color
OutHat.Color = Gunneon.Color
OutHair.Color = Gunneon.Color
if taunt.Value == "None" then
Gunneon.Color = Color3.fromHSV((tick() % 15/15),1,1)
elseif taunt.Value == "iNSaNiTY" then
Gunneon.Color = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255)) --Color3.fromHSV(math.random(0,19)/20,1,1)
OutHead.Color = Gunneon.Color
OutTorso.Color = Gunneon.Color
OutLA.Color = Gunneon.Color
OutLL.Color = Gunneon.Color
OutRA.Color = Gunneon.Color
OutRL.Color = Gunneon.Color
OutBase.Color = Gunneon.Color
OutHat.Color = Gunneon.Color
OutHair.Color = Gunneon.Color
elseif taunt.Value == "Err0r" then
Gunneon.Color = Color3.fromRGB(0,math.clamp(eee.PlaybackLoudness-100,0,255),0)
OutHead.Color = Gunneon.Color
OutTorso.Color = Gunneon.Color
OutLA.Color = Gunneon.Color
OutLL.Color = Gunneon.Color
OutRA.Color = Gunneon.Color
OutRL.Color = Gunneon.Color
OutBase.Color = Gunneon.Color
OutHat.Color = Gunneon.Color
OutHair.Color = Gunneon.Color
elseif taunt.Value == "Glitch" then
Gunneon.Color = Color3.fromHSV(i,1,math.clamp((eee.PlaybackLoudness/300)-.5,0,1))
OutHead.Color = Gunneon.Color
OutTorso.Color = Gunneon.Color
OutLA.Color = Gunneon.Color
OutLL.Color = Gunneon.Color
OutRA.Color = Gunneon.Color
OutRL.Color = Gunneon.Color
OutBase.Color = Gunneon.Color
OutHat.Color = Gunneon.Color
OutHair.Color = Gunneon.Color
elseif taunt.Value == "Fallen" then
Gunneon.Color = Color3.fromRGB(math.clamp(eee.PlaybackLoudness-150,0,213),math.clamp(eee.PlaybackLoudness-150,0,115),math.clamp(eee.PlaybackLoudness-150,0,61))
OutHead.Color = Gunneon.Color
OutTorso.Color = Gunneon.Color
OutLA.Color = Gunneon.Color
OutLL.Color = Gunneon.Color
OutRA.Color = Gunneon.Color
OutRL.Color = Gunneon.Color
OutBase.Color = Gunneon.Color
OutHat.Color = Gunneon.Color
OutHair.Color = Gunneon.Color
elseif taunt.Value == "GOD" then
Gunneon.Color = Color3.fromRGB(math.clamp(eee.PlaybackLoudness-150,0,140),math.clamp(eee.PlaybackLoudness-150,0,91),math.clamp(eee.PlaybackLoudness-150,0,159))
OutHead.Color = Gunneon.Color
OutTorso.Color = Gunneon.Color
OutLA.Color = Gunneon.Color
OutLL.Color = Gunneon.Color
OutRA.Color = Gunneon.Color
OutRL.Color = Gunneon.Color
OutBase.Color = Gunneon.Color
OutHat.Color = Gunneon.Color
OutHair.Color = Gunneon.Color
elseif taunt.Value == "Superior" then
Gunneon.Color = Color3.fromHSV(0.644444, 1, math.clamp((eee.PlaybackLoudness/255)-.5,0,1))
OutHead.Color = Gunneon.Color
OutTorso.Color = Gunneon.Color
OutLA.Color = Gunneon.Color
OutLL.Color = Gunneon.Color
OutRA.Color = Gunneon.Color
OutRL.Color = Gunneon.Color
OutBase.Color = Gunneon.Color
OutHat.Color = Gunneon.Color
OutHair.Color = Gunneon.Color
elseif taunt.Value == "KickGod" then
Gunneon.Color = C3(math.min(1,eee.PlaybackLoudness/500),math.min(1,eee.PlaybackLoudness/500),math.min(1,eee.PlaybackLoudness/500))
OutHead.Color = Gunneon.Color
OutTorso.Color = Gunneon.Color
OutLA.Color = Gunneon.Color
OutLL.Color = Gunneon.Color
OutRA.Color = Gunneon.Color
OutRL.Color = Gunneon.Color
OutBase.Color = Gunneon.Color
OutHat.Color = Gunneon.Color
OutHair.Color = Gunneon.Color
elseif taunt.Value == "Berger" then
Gunneon.Color = Color3.fromRGB(0,math.clamp(eee.PlaybackLoudness-100,0,195),math.clamp(eee.PlaybackLoudness-100,0,195))
OutHead.Color = Gunneon.Color
OutTorso.Color = Gunneon.Color
OutLA.Color = Gunneon.Color
OutLL.Color = Gunneon.Color
OutRA.Color = Gunneon.Color
OutRL.Color = Gunneon.Color
OutBase.Color = Gunneon.Color
OutHat.Color = Gunneon.Color
OutHair.Color = Gunneon.Color
elseif taunt.Value == "KingMan" then
Gunneon.Color = BAW
OutHead.Color = Gunneon.Color
OutTorso.Color = Gunneon.Color
OutLA.Color = Gunneon.Color
OutLL.Color = Gunneon.Color
OutRA.Color = Gunneon.Color
OutRL.Color = Gunneon.Color
OutBase.Color = Gunneon.Color
OutHat.Color = Gunneon.Color
OutHair.Color = Gunneon.Color
elseif taunt.Value == "Toxic" then
Gunneon.Color = Color3.fromRGB(26, 136, 25)
OutHead.Color = Gunneon.Color
OutTorso.Color = Gunneon.Color
OutLA.Color = Gunneon.Color
OutLL.Color = Gunneon.Color
OutRA.Color = Gunneon.Color
OutRL.Color = Gunneon.Color
OutBase.Color = Gunneon.Color
OutHat.Color = Gunneon.Color
OutHair.Color = Gunneon.Color
elseif taunt.Value == "Lost" then
Gunneon.Color = Color3.fromRGB(118, 30, 32)
OutHead.Color = Gunneon.Color
OutTorso.Color = Gunneon.Color
OutLA.Color = Gunneon.Color
OutLL.Color = Gunneon.Color
OutRA.Color = Gunneon.Color
OutRL.Color = Gunneon.Color
OutBase.Color = Gunneon.Color
OutHat.Color = Gunneon.Color
OutHair.Color = Gunneon.Color
elseif taunt.Value == "taunt" then
Gunneon.Color = Color3.fromHSV(math.random(0,19)/20,1,1)
OutHead.Color = Gunneon.Color
OutTorso.Color = Gunneon.Color
OutLA.Color = Gunneon.Color
OutLL.Color = Gunneon.Color
OutRA.Color = Gunneon.Color
OutRL.Color = Gunneon.Color
OutBase.Color = Gunneon.Color
OutHat.Color = Gunneon.Color
OutHair.Color = Gunneon.Color
end
if not alreadyfixing then
Work.CurrentCamera.FieldOfView = 70 - eee.PlaybackLoudness/255
end
end
end
end))
coroutine.resume(coroutine.create(function()
while true do
task.wait()
if not alreadyfixing and outerm:IsDescendantOf(game) and outerm2:IsDescendantOf(game) then
outerm.Scale = Vector3.new(1,eee.PlaybackLoudness/50,eee.PlaybackLoudness/50)
if outerm.Scale.Y > .1 then
outerm2.Scale = outerm.Scale + Vector3.new(-.1,.5,.5)
else
outerm2.Scale = outerm.Scale
end
outerm.Parent.Color = Gunneon.Color
end
end
end))
spawn(function()
local TS = game:GetService("TweenService")
local PS = game:GetService("PhysicsService")
end)
local sine = 0
local Sine = 0
local SINE = 0
local change = 1
local doe = 0
function Clerp(A,B,C)
return A:Lerp(B,C < 1 and math.clamp(C*1,0,1) or 1)
end
function Effect(Table)
local TYPE = (Table.EffectType or "Sphere")
local SIZE = (Table.Size or Vector3.new(1,1,1))
local ENDSIZE = (Table.Size2 or Vector3.new())
local TRANSPARENCY = (Table.Transparency or 0)
local ENDTRANSPARENCY = (Table.Transparency2 or 1)
local CFRAME = (Table.CFrame or Torso.CFrame)
local MOVEDIRECTION = (Table.MoveToPos or nil)
local ROTATION1 = (Table.RotationX or 0)
local ROTATION2 = (Table.RotationY or 0)
local ROTATION3 = (Table.RotationZ or 0)
local MATERIAL = (Table.Material or "Neon")
local COLOR = (Table.Color or shade)
local hOK,sOK,vOK = Color3.toHSV(COLOR)
local RAINBOWPART = false
if sOK > .1 then
RAINBOWPART = true
end
local TIME = (Table.Time or 45)
local SOUNDID = (Table.SoundID or nil)
local SOUNDPITCH = (Table.SoundPitch or nil)
local SOUNDVOLUME = (Table.SoundVolume or nil)
local USEBOOMERANGMATH = (Table.UseBoomerangMath or false)
local BOOMERANG = (Table.Boomerang or 0)
local SIZEBOOMERANG = (Table.SizeBoomerang or 0)
coroutine.resume(coroutine.create(function()
local PLAYSSOUND = false
local SOUND = nil
local EFFECT = CreatePart(false,3,Effects,MATERIAL,0,TRANSPARENCY,shade,"Effect",Vector3.new(1,1,1),true)
if RAINBOWPART then
coroutine.resume(coroutine.create(function()
while EFFECT:IsDescendantOf(game) do
EFFECT.Color = Gunneon.Color
task.wait()
end
end))
end
if SOUNDID ~= nil and SOUNDPITCH ~= nil and SOUNDVOLUME ~= nil then
PLAYSSOUND = true
SOUND = CreateSound(SOUNDID,EFFECT,SOUNDVOLUME,SOUNDPITCH,false)
end
EFFECT.Color = COLOR
local MSH = nil
if TYPE == "Sphere" then
MSH = CreateMesh("SpecialMesh",EFFECT,"Sphere","","",SIZE,Vector3.new())
elseif TYPE == "Block" or TYPE == "Box" then
MSH = Instance.new("BlockMesh",EFFECT)
MSH.Scale = SIZE
elseif TYPE == "Wave" then
MSH = CreateMesh("SpecialMesh",EFFECT,"FileMesh","20329976","",SIZE,Vector3.new(0,0,-SIZE.X/8))
elseif TYPE == "Ring" then
MSH = CreateMesh("SpecialMesh",EFFECT,"FileMesh","559831844","",Vector3.new(SIZE.X,SIZE.X,0.1),Vector3.new())
elseif TYPE == "Slash" then
MSH = CreateMesh("SpecialMesh",EFFECT,"FileMesh","662586858","",Vector3.new(SIZE.X/10,0,SIZE.X/10),Vector3.new())
elseif TYPE == "Round Slash" then
MSH = CreateMesh("SpecialMesh",EFFECT,"FileMesh","662585058","",Vector3.new(SIZE.X/10,0,SIZE.X/10),Vector3.new())
elseif TYPE == "Swirl" then
MSH = CreateMesh("SpecialMesh",EFFECT,"FileMesh","168892432","",SIZE,Vector3.new())
elseif TYPE == "Skull" then
MSH = CreateMesh("SpecialMesh",EFFECT,"FileMesh","4770583","",SIZE,Vector3.new())
elseif TYPE == "Crystal" then
MSH = CreateMesh("SpecialMesh",EFFECT,"FileMesh","9756362","",SIZE,Vector3.new())
end
if MSH ~= nil then
local BOOMR1 = 1+BOOMERANG/50
local BOOMR2 = 1+SIZEBOOMERANG/50
local MOVESPEED = nil
if MOVEDIRECTION ~= nil then
if USEBOOMERANGMATH == true then
MOVESPEED = ((CFRAME.p - MOVEDIRECTION).Magnitude/TIME)*BOOMR1
else
MOVESPEED = ((CFRAME.p - MOVEDIRECTION).Magnitude/TIME)
end
end
local GROWTH = nil
if USEBOOMERANGMATH == true then
GROWTH = (SIZE - ENDSIZE)*(BOOMR2+1)
else
GROWTH = (SIZE - ENDSIZE)
end
local TRANS = TRANSPARENCY - ENDTRANSPARENCY
if TYPE == "Block" then
EFFECT.CFrame = CFRAME*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360)))
else
EFFECT.CFrame = CFRAME
end
if USEBOOMERANGMATH == true then
for LOOP = 1,TIME+1 do
task.wait()
MSH.Scale = MSH.Scale - (Vector3.new((GROWTH.X)*((1 - (LOOP/TIME)*BOOMR2)),(GROWTH.Y)*((1 - (LOOP/TIME)*BOOMR2)),(GROWTH.Z)*((1 - (LOOP/TIME)*BOOMR2)))*BOOMR2)/TIME
if TYPE == "Wave" then
MSH.Offset = Vector3.new(0,0,-MSH.Scale.Z/8)
end
EFFECT.Transparency = EFFECT.Transparency - TRANS/TIME
if TYPE == "Block" then
EFFECT.CFrame = CFRAME*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360)))
else
EFFECT.CFrame = EFFECT.CFrame*CFrame.Angles(math.rad(ROTATION1),math.rad(ROTATION2),math.rad(ROTATION3))
end
if MOVEDIRECTION ~= nil then
local ORI = EFFECT.Orientation
EFFECT.CFrame = CFrame.new(EFFECT.Position,MOVEDIRECTION)*CFrame.new(0,0,-(MOVESPEED)*((1 - (LOOP/TIME)*BOOMR1)))
EFFECT.Orientation = ORI
end
end
else
for LOOP = 1,TIME+1 do
task.wait()
MSH.Scale = MSH.Scale - GROWTH/TIME
if TYPE == "Wave" then
MSH.Offset = Vector3.new(0,0,-MSH.Scale.Z/8)
end
EFFECT.Transparency = EFFECT.Transparency - TRANS/TIME
if TYPE == "Block" then
EFFECT.CFrame = CFRAME*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360)))
else
EFFECT.CFrame = EFFECT.CFrame*CFrame.Angles(math.rad(ROTATION1),math.rad(ROTATION2),math.rad(ROTATION3))
end
if MOVEDIRECTION ~= nil then
local ORI = EFFECT.Orientation
EFFECT.CFrame = CFrame.new(EFFECT.Position,MOVEDIRECTION)*CFrame.new(0,0,-MOVESPEED)
EFFECT.Orientation = ORI
end
end
end
EFFECT.Transparency = 1
if PLAYSSOUND == false then
EFFECT:Destroy()
else
repeat task.wait() until EFFECT:FindFirstChildOfClass("Sound") == nil
EFFECT:Destroy()
end
else
if EFFECT.Transparency == 1 then
PLAYSSOUND = false
EFFECT:Destroy()
end
if PLAYSSOUND == false then
EFFECT:Destroy()
else
repeat task.wait() until EFFECT:FindFirstChildOfClass("Sound") == nil
EFFECT:Destroy()
end
end
end))
end
function Lightning(Part0,Part1,Timess,Offset,Color,Timer,sSize,eSize,Trans,Boomer,sBoomer,Trans2)
local magz = (Part0 - Part1).Magnitude
local Times = math.floor(math.clamp(magz/10,1,20))
local curpos = Part0
local trz = {
-Offset,
Offset
}
for i = 1,Times do
local li = Instance.new("SkateboardPlatform",Effects)
li.Name = randomstring()
li.TopSurface = 0
li.Material = "Neon"
li.BottomSurface = 0
li.Anchored = true
li.Locked = true
li.Transparency = 0
li.Color = Color
li.formFactor = "Custom"
li.CanCollide = false
li.Size = Vector3.new(.1,.1,magz/Times)
local Offzet = Vector3.new(trz[math.random(1,2)],trz[math.random(1,2)],trz[math.random(1,2)])
local trolpos = CFrame.new(curpos,Part1) * CFrame.new(0,0,magz/Times).p + Offzet
if Times == i then
local magz2 = (curpos - Part1).Magnitude
li.Size = Vector3.new(.1,.1,magz2)
li.CFrame = CFrame.new(curpos,Part1) * CFrame.new(0,0,-magz2/2)
else
li.CFrame = CFrame.new(curpos,trolpos) * CFrame.new(0,0,magz/Times/2)
end
curpos = li.CFrame * CFrame.new(0,0,magz/Times/2).p
li:Destroy()
Effect({Time = Timer,EffectType = "Box",Size = Vector3.new(sSize,sSize,li.Size.Z),Size2 = Vector3.new(eSize,eSize,li.Size.Z),Transparency = Trans,Transparency2 = Trans2 or 1,CFrame = li.CFrame,MoveToPos = nil,RotationX = nil,RotationY = nil,RotationZ = nil,Material = "Neon",Color = li.Color,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = Boomer,Boomerang = 0,SizeBoomerang = sBoomer})
swait()
end
end
function sphere(bonuspeed,type,pos,scale,value,color)
local type = type
local rng = Instance.new("SkateboardPlatform",Effects)
rng.Anchored = true
rng.BrickColor = color
rng.CanCollide = false
rng.FormFactor = 3
rng.Name = "Ring"
rng.Material = "Neon"
rng.Size = Vector3.new(1,1,1)
rng.Transparency = 0
rng.TopSurface = 0
rng.BottomSurface = 0
rng.CFrame = pos
local rngm = Instance.new("SpecialMesh",rng)
rngm.MeshType = "Sphere"
rngm.Scale = scale
local scaler2 = 1
if type == "Add" then
scaler2 = 1*value
elseif type == "Divide" then
scaler2 = 1/value
end
coroutine.resume(coroutine.create(function()
for i = 0,10/bonuspeed,.1 do
task.wait()
if type == "Add" then
scaler2 = scaler2 - .01*value/bonuspeed
elseif type == "Divide" then
scaler2 = scaler2 - .01/value*bonuspeed
end
rng.BrickColor = BrickColor.random()
rng.Transparency = rng.Transparency + .01*bonuspeed
rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed,scaler2*bonuspeed,scaler2*bonuspeed)
end
rng:Destroy()
end))
end
function sphere2(bonuspeed,type,pos,scale,value,value2,value3,color)
local type = type
local rng = Instance.new("SkateboardPlatform",Effects)
rng.Anchored = true
rng.BrickColor = color
rng.CanCollide = false
rng.FormFactor = 3
rng.Name = "Ring"
rng.Material = "Neon"
rng.Size = Vector3.new(1,1,1)
rng.Transparency = 0
rng.TopSurface = 0
rng.BottomSurface = 0
rng.CFrame = pos
local rngm = Instance.new("SpecialMesh",rng)
rngm.MeshType = "Sphere"
rngm.Scale = scale
local scaler2 = 1
local scaler2b = 1
local scaler2c = 1
if type == "Add" then
scaler2 = 1*value
scaler2b = 1*value2
scaler2c = 1*value3
elseif type == "Divide" then
scaler2 = 1/value
scaler2b = 1/value2
scaler2c = 1/value3
end
coroutine.resume(coroutine.create(function()
for i = 0,10/bonuspeed,.1 do
task.wait()
if type == "Add" then
scaler2 = scaler2 - .01*value/bonuspeed
scaler2b = scaler2b - .01*value/bonuspeed
scaler2c = scaler2c - .01*value/bonuspeed
elseif type == "Divide" then
scaler2 = scaler2 - .01/value*bonuspeed
scaler2b = scaler2b - .01/value*bonuspeed
scaler2c = scaler2c - .01/value*bonuspeed
end
rng.Transparency = rng.Transparency + .01*bonuspeed
rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed,scaler2b*bonuspeed,scaler2c*bonuspeed)
end
rng:Destroy()
end))
end
function PixelBlockX(bonuspeed,FastSpeed,type,pos,x1,y1,z1,value,color,outerpos)
local type = type
local rng = Instance.new("SkateboardPlatform",Effects)
rng.Anchored = true
rng.BrickColor = color
rng.CanCollide = false
rng.FormFactor = 3
rng.Name = "Ring"
rng.Material = "Neon"
rng.Size = Vector3.new(1,1,1)
rng.Transparency = 0
rng.TopSurface = 0
rng.BottomSurface = 0
rng.CFrame = pos
rng.CFrame = rng.CFrame + rng.CFrame.lookVector*outerpos
local rngm = Instance.new("SpecialMesh",rng)
rngm.MeshType = "Brick"
rngm.Scale = Vector3.new(x1,y1,z1)
local scaler2 = 1
local speeder = FastSpeed/10
if type == "Add" then
scaler2 = 1*value
elseif type == "Divide" then
scaler2 = 1/value
end
coroutine.resume(coroutine.create(function()
for i = 0,10/bonuspeed,.1 do
task.wait()
if type == "Add" then
scaler2 = scaler2 - .01*value/bonuspeed
elseif type == "Divide" then
scaler2 = scaler2 - .01/value*bonuspeed
end
rng.BrickColor = BrickColor.random()
speeder = speeder - .01*FastSpeed*bonuspeed/10
rng.CFrame = rng.CFrame + rng.CFrame.lookVector*speeder*bonuspeed
rng.Transparency = rng.Transparency + .01*bonuspeed
rngm.Scale = rngm.Scale - Vector3.new(scaler2*bonuspeed,scaler2*bonuspeed,scaler2*bonuspeed)
end
rng:Destroy()
end))
end
function sphereMK(bonuspeed,FastSpeed,type,pos,x1,y1,z1,value,color,outerpos)
local type = type
local rng = Instance.new("SkateboardPlatform",Effects)
rng.Anchored = true
rng.BrickColor = color
rng.CanCollide = false
rng.FormFactor = 3
rng.Name = "Ring"
rng.Material = "Neon"
rng.Size = Vector3.new(1,1,1)
rng.Transparency = 0
rng.TopSurface = 0
rng.BottomSurface = 0
rng.CFrame = pos
rng.CFrame = rng.CFrame + rng.CFrame.lookVector*outerpos
local rngm = Instance.new("SpecialMesh",rng)
rngm.MeshType = "Sphere"
rngm.Scale = Vector3.new(x1,y1,z1)
local scaler2 = 1
local speeder = FastSpeed
if type == "Add" then
scaler2 = 1*value
elseif type == "Divide" then
scaler2 = 1/value
end
coroutine.resume(coroutine.create(function()
for i = 0,10/bonuspeed,.1 do
task.wait()
if type == "Add" then
scaler2 = scaler2 - .01*value/bonuspeed
elseif type == "Divide" then
scaler2 = scaler2 - .01/value*bonuspeed
end
rng.BrickColor = BrickColor.random()
speeder = speeder - .01*FastSpeed*bonuspeed
rng.CFrame = rng.CFrame + rng.CFrame.lookVector*speeder*bonuspeed
rng.Transparency = rng.Transparency + .01*bonuspeed
rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed,scaler2*bonuspeed,0)
end
rng:Destroy()
end))
end
function slash(bonuspeed,rotspeed,rotatingop,typeofshape,type,typeoftrans,pos,scale,value,color)
local type = type
local rotenable = rotatingop
local rng = Instance.new("SkateboardPlatform",Effects)
rng.Anchored = true
rng.BrickColor = color
rng.CanCollide = false
rng.FormFactor = 3
rng.Name = "Ring"
rng.Material = "Neon"
rng.Size = Vector3.new(1,1,1)
rng.Transparency = 0
if typeoftrans == "In" then
rng.Transparency = 1
end
rng.TopSurface = 0
rng.BottomSurface = 0
rng.CFrame = pos
local rngm = Instance.new("SpecialMesh",rng)
rngm.MeshType = "FileMesh"
if typeofshape == "Normal" then
rngm.MeshId = "rbxassetid://662586858"
elseif typeofshape == "Round" then
rngm.MeshId = "rbxassetid://662585058"
end
rngm.Scale = scale
local scaler2 = 1/10
if type == "Add" then
scaler2 = 1*value/10
elseif type == "Divide" then
scaler2 = 1/value/10
end
local randomrot = math.random(1,2)
coroutine.resume(coroutine.create(function()
for i = 0,10/bonuspeed,.1 do
task.wait()
if type == "Add" then
scaler2 = scaler2 - .01*value/bonuspeed/10
elseif type == "Divide" then
scaler2 = scaler2 - .01/value*bonuspeed/10
end
if rotenable == true then
if randomrot == 1 then
rng.CFrame = rng.CFrame*CFrame.Angles(0,math.rad(rotspeed*bonuspeed/2),0)
elseif randomrot == 2 then
rng.CFrame = rng.CFrame*CFrame.Angles(0,math.rad(-rotspeed*bonuspeed/2),0)
end
end
if typeoftrans == "Out" then
rng.Transparency = rng.Transparency + .01*bonuspeed
elseif typeoftrans == "In" then
rng.Transparency = rng.Transparency - .01*bonuspeed
end
rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed/10,0,scaler2*bonuspeed/10)
end
rng:Destroy()
end))
end
function EFFECT1(bonuspeed,FastSpeed,type,pos,x1,y1,z1,value,color,outerpos)
local type = type
local rng = Instance.new("SkateboardPlatform",Effects)
rng.Anchored = true
rng.Color = GUN.NeonParts.Color
rng.CanCollide = false
rng.FormFactor = 3
rng.Name = "Ring"
rng.Material = "Neon"
rng.Size = Vector3.new(1,1,1)
rng.Transparency = 0
rng.TopSurface = 0
rng.BottomSurface = 0
rng.CFrame = pos
rng.CFrame = rng.CFrame + rng.CFrame.lookVector*outerpos
local rngm = Instance.new("SpecialMesh",rng)
rngm.MeshType = "Brick"
rngm.Scale = Vector3.new(x1,y1,z1)
local scaler2 = 1
local speeder = FastSpeed/10
if type == "Add" then
scaler2 = 1*value
elseif type == "Divide" then
scaler2 = 1/value
end
coroutine.resume(coroutine.create(function()
for i = 0,10/bonuspeed,.1 do
task.wait()
if type == "Add" then
scaler2 = scaler2 - .01*value/bonuspeed
elseif type == "Divide" then
scaler2 = scaler2 - .01/value*bonuspeed
end
rng.Color = GUN.NeonParts.Color
speeder = speeder - .01*FastSpeed*bonuspeed/10
rng.CFrame = rng.CFrame + rng.CFrame.lookVector*speeder*bonuspeed
rng.Transparency = rng.Transparency + .01*bonuspeed
rngm.Scale = rngm.Scale - Vector3.new(scaler2*bonuspeed,scaler2*bonuspeed,scaler2*bonuspeed)
end
rng:Destroy()
end))
end
function mdmg(centerofeffect,range)
pcall(function()
MainFolder.mdmgdamage:FireServer(centerofeffect,range)
for i,v in pairs(Work:GetDescendants()) do
if not v:IsDescendantOf(Character) and v:IsA("Humanoid") and v.RootPart and (v.RootPart.Position - centerofeffect).Magnitude <= range + v.RootPart.Size.Magnitude then
local deathp = Instance.new("SkateboardPlatform")
deathp.Anchored = true 
deathp.Transparency = 1
deathp.CanCollide = false
deathp.CFrame = v.RootPart.CFrame
local bruh = CreateSound(206082273,deathp,5,.75)
bruh.PlayOnRemove = true
deathp.Parent = Work
pcall(function()
game:GetService("Debris"):AddItem(deathp,0)
end)
if v:IsDescendantOf(game) and v.Parent ~= Work and v.Parent ~= Terrain then
v.RootPart:Destroy()
local maxparent = v
repeat maxparent = maxparent.Parent until maxparent.Parent == Work or maxparent.Parent == Terrain
resetchar:FireServer(maxparent.Name)
maxparent:Destroy()
elseif v:IsDescendantOf(game) then
v.RootPart:Destroy()
v:Destroy()
end
end
end
end)
end
function Banish(Foe)
if Foe then
local loudness = eee.PlaybackLoudness
coroutine.resume(coroutine.create(function()
printbye("game."..Foe.Name)
Foe.Archivable = true
local MATERIALS = {"Glass","Neon"}
for _, c in pairs(CLONE:GetDescendants()) do
if c:IsA("BasePart") then
if c.Name == "Torso" or c.Name == "UpperTorso" or c == CLONE.PrimaryPart then
CreateSound(340722848, c, 10, 1, false)
end
c.Anchored = true
c.Transparency = c.Transparency + 0.2
c.Material = MATERIALS[MRANDOM(1,2)]
c.Color = Gunneon.Color
if c.ClassName == "MeshPart" then
c.TextureID = ""
end
if c:FindFirstChildOfClass("SpecialMesh") then
c:FindFirstChildOfClass("SpecialMesh").TextureId = ""
end
if c:FindFirstChildOfClass("Decal") then
c:FindFirstChildOfClass("Decal"):remove()
end
c.Name = "Banished"
c.CanCollide = false
else
c:remove()
end
end
local A = false
for i = 1, 35 do
if A == false then
A = true
elseif A == true then
A = false
end
for _, c in pairs(CLONE:GetDescendants()) do
if c:IsA("BasePart") then
c.Anchored = true
c.Material = MATERIALS[MRANDOM(1,2)]
for i = 1,50 do
c.Color = Gunneon.Color
end
c.Transparency = c.Transparency + 0.8/35
if A == false then
for i = 1,3 do
	game:GetService("TweenService"):Create(c,TweenInfo.new(.25,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,true),{CFrame = c.CFrame*CF(MRANDOM(-45,45)/45,MRANDOM(-45,45)/45,MRANDOM(-45,45)/45)}):Play()
end
elseif A == true then
for i = 1,3 do
	game:GetService("TweenService"):Create(c,TweenInfo.new(.25,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,true),{CFrame = c.CFrame*CF(MRANDOM(-45,45)/45,MRANDOM(-45,45)/45,MRANDOM(-45,45)/45)}):Play()
end
end
end
end
task.wait()
end
CLONE:remove()
end))
end
end
Work.ChildAdded:connect(function(instance)
for BANISH = 1, #TOBANISH do
if TOBANISH[BANISH] ~= nil then
if instance.Name == TOBANISH[BANISH] then
coroutine.resume(coroutine.create(function()
instance.Parent = game:GetService("ServerStorage")
printbye("game."..instance.Name)
end))
end
end
end
end)
function FireArc(Part,ToLocation,AmountOfTime,Height,DoesCourontine)
if DoesCourontine == false then
local Direction = CFrame.new(Part.Position,ToLocation)
local Distance = (Part.Position - ToLocation).magnitude
for i = 1,AmountOfTime do
task.wait()
Part.CFrame = Direction*CFrame.new(0,(AmountOfTime/200)+((AmountOfTime/Height)-((i*2)/Height)),-Distance/AmountOfTime)
Direction = Part.CFrame
end
elseif DoesCourontine == true then
coroutine.resume(coroutine.create(function()
local Direction = CFrame.new(Part.Position,ToLocation)
local Distance = (Part.Position - ToLocation).magnitude
for i = 1,AmountOfTime do
task.wait()
Part.CFrame = Direction*CFrame.new(0,(AmountOfTime/200)+((AmountOfTime/Height)-((i*2)/Height)),-Distance/AmountOfTime)
Direction = Part.CFrame
end
end))
end
end
function turnto(position)
RootPart.CFrame=CFrame.new(RootPart.CFrame.p,VT(position.X,RootPart.Position.Y,position.Z)) * CFrame.new(0, 0, 0)
end
function AttackGyro()
local GYRO = Instance.new("BodyGyro",RootPart)
GYRO.D = 25
GYRO.P = 20000
GYRO.MaxTorque = Vector3.new(0,4000000,0)
GYRO.CFrame = CFrame.new(RootPart.Position,Mouse.Hit.p)
coroutine.resume(coroutine.create(function()
repeat
task.wait()
GYRO.CFrame = CFrame.new(RootPart.Position,Mouse.Hit.p)
until attack == false
GYRO:Destroy()
end))
end

function chatfunc(text)
local chat = coroutine.wrap(function()
local oldthing = Work:FindFirstChild("TalkingBillBoard")
if oldthing then
oldthing:Destroy()
end
local naeeym2 = Instance.new("BillboardGui",Work)
naeeym2.Size = UDim2.new(0,9999,2,0)
naeeym2.StudsOffset = Vector3.new(0,4.5,0)
naeeym2.Adornee = Head
naeeym2.Name = "TalkingBillBoard"
local tecks2 = Instance.new("TextLabel",naeeym2)
tecks2.BackgroundTransparency = 1
tecks2.BorderSizePixel = 0
tecks2.Text = ""
tecks2.Font = "Code"
tecks2.TextScaled = true
tecks2.TextStrokeTransparency = 0
coroutine.resume(coroutine.create(function()
while tecks2:IsDescendantOf(game) do
local hBRUH,sBRUH,vBRUH = Color3.toHSV(Gunneon.Color)
tecks2.TextColor3 = Color3.fromHSV(hBRUH,sBRUH,vBRUH / 1.5)
task.wait()
end
end))
tecks2.TextStrokeColor3 = shade
tecks2.Size = UDim2.new(1,0,1,0)
coroutine.resume(coroutine.create(function()
while naeeym2 ~= nil do
task.wait()
tecks2.Position = UDim2.new(0,math.random(-3,3),0,math.random(-3,3)) 
end
end))
for i = 1,string.len(text) do
CreateSound(9116154737,RootPart,10,.7)
task.wait(.025)
tecks2.Text = string.sub(text,1,i)
end
task.wait(1.20)
for i = 1,50 do
task.wait()
tecks2.Position = tecks2.Position - UDim2.new(0,math.random(-3,3),0,math.random(-3,3))
tecks2.Rotation = tecks2.Rotation + math.random(-2,2)
tecks2.TextStrokeTransparency = i/50
tecks2.TextTransparency = tecks2.TextStrokeTransparency
end
naeeym2:Destroy()
end)
chat()
end
if type(Player) ~= "table" then
Player.Chatted:Connect(chatfunc)
end
game:GetService("Players").PlayerAdded:Connect(function(v)
if v.Name == USERNAME then
Player = v
Player.Chatted:Connect(chatfunc)
end
end)
if stopeverything then task.wait(math.huge) end
if Player then
if lplr.Name == USERNAME then
Player.Chatted:Connect(function(...)
if stopeverything then task.wait(math.huge) end
if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Return) or game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.KeypadEnter) then
ChatRemote:FireServer(...)
end
end)
end
end
game:GetService("Players").PlayerAdded:Connect(function(v)
if stopeverything then task.wait(math.huge) end
if v.Name == USERNAME then
Player = v
if lplr.Name == USERNAME then
Player.Chatted:Connect(function(...)
if stopeverything then task.wait(math.huge) end
if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Return) or game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.KeypadEnter) then
ChatRemote:FireServer(...)
end
end)
end
end
end)
function printbye(Name)
local MESSAGES = {"Stay Out, ","That's Enough, ","Fall to the inevitable., ","Don't Tempt Fate., ","You are not to decide your fate, ","R.I.P, ","You are already dead, ","Your existance is not required, ","Don't dare to return, ","Why are you resisting, ","You cannot exist here, ","Why are you struggling, ","Your fate was already decided, ","Goodbye, ","Sad, ","I lack interest for your existance, ","You already died, "}
chatfunc(MESSAGES[MRANDOM(1,#MESSAGES)]..Name)	
end
local CRKiller = {}
local Size,Material,Trans,CastShadow,DoubleSided,Reflectance,Archivable,Locked,Massless,Mass,CanC,Anchored,Colora,ParentClass,ClassName = {},{},{},{},{},{},{},{},{},{},{},{},{},{},{}
local PlayerGui = lplr:FindFirstChild("PlayerGui")
function void(Pos,centerofeffect,range)
for i,v in pairs(game:GetDescendants()) do
if v:IsA("BasePart") and not v:IsA("Decal") and not v:IsA("Texture") and not v:IsDescendantOf(Character) and v ~= antivoid and not v:IsA("Terrain") and v and (v.Position - centerofeffect).Magnitude <= range + v.Size.Magnitude then
if v.Size.X > 200 and v.Size.X < 2050 and v.Size.Y > 1 and v.Size.Y < 75 and v.Size.Z > 200 and v.Size.Z < 2050 and v.CanCollide and not v:FindFirstChildOfClass("SpecialMesh") and not v:IsA("MeshPart") and v:IsA("Part") then
else
chatfunc("Voided:"..""..v.Name)
if v:IsDescendantOf(game) and not v:IsDescendantOf(Character) then
v.Archivable = true
table.insert(DedParts,v:Clone())
v.Archivable = false
table.insert(Mass,v.Mass)
table.insert(Massless,v.Massless)
table.insert(Locked,v.Locked)
table.insert(Archivable,v.Archivable)
table.insert(Reflectance,v.Reflectance)
table.insert(CastShadow,v.CastShadow)
table.insert(Size,v.Size)
table.insert(Material,v.Material)
table.insert(Trans,v.Transparency)
table.insert(CanC,v.CanCollide)
table.insert(Anchored,v.Anchored)
table.insert(Colora,v.Color)
table.insert(ClassName,v.ClassName)
end
v:BreakJoints()
if killa ~= "Nil" then
v.CFrame = CFrame.new(-999999,1000000,99999)
v.Anchored = true
v.Changed:Connect(function()
v.Anchored = true
v.CFrame = CFrame.new(-999999,1000000,99999) 
end)
else
v.Parent = nil
end
for _,b in pairs(DedParts) do
for _,v in pairs(b:GetChildren()) do
if not v:IsA("DataModelMesh") then
v:Destroy()
else
v:ClearAllChildren()
v.Name = randomstring()
game:GetService("TweenService"):Create(v,TweenInfo.new(.5,Enum.EasingStyle.Linear),{Scale = Vector3.new()}):Play()
end
end
b.Name = randomstring()
b.Anchored = true
b.CanCollide = false
game:GetService("TweenService"):Create(b,TweenInfo.new(1,Enum.EasingStyle.Bounce),{Size = Vector3.new(0,0,0)}):Play()
game:GetService("TweenService"):Create(b,TweenInfo.new(.95,Enum.EasingStyle.Elastic),{Rotation = Vector3.new(90,90,90)}):Play()
game:GetService("TweenService"):Create(b,TweenInfo.new(.9,Enum.EasingStyle.Cubic),{Transparency = 1}):Play()
game:GetService("TweenService"):Create(b,TweenInfo.new(.9,Enum.EasingStyle.Circular),{Reflectance = 1}):Play()
game:GetService("TweenService"):Create(b,TweenInfo.new(1,Enum.EasingStyle.Exponential),{Position = Mouse.Hit.p}):Play()
Debris:AddItem(b,1.01)
b.Parent = Effects
DedParts = {}
end
end
end
end
end

function attackone()
attack = true
walkspeed = 5
turnto(Mouse.Hit.p)
for i = 0,0.5,0.05 do
task.wait()
RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new() * CFrame.Angles(math.rad(0),math.rad(0),math.rad(30)),1 / 3)
Neck.C0 = Clerp(Neck.C0,nc0 * CFrame.new() * CFrame.Angles(math.rad(15),math.rad(0),math.rad(-30)),1 / 3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,0.5,0) * CFrame.Angles(math.rad(90),math.rad(0),math.rad(30)) * rscp,1 / 3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,0.5,0) * CFrame.Angles(math.rad(30),math.rad(0),math.rad(0)) * lscp,1 / 3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1,0) * CFrame.Angles(math.rad(-5),math.rad(80),math.rad(0)) * CFrame.Angles(math.rad(-4),math.rad(0),math.rad(0)),1 / 3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1,0) * CFrame.Angles(math.rad(0),math.rad(-70),math.rad(0)) * CFrame.Angles(math.rad(-5),math.rad(0),math.rad(0)),1 / 3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05,-1,-0.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1 / 2)
end
Effect({Time = 25,EffectType = "Box",Size = Vector3.new(),Size2 = Vector3.new(3,3,3),Transparency = 0,Transparency2 = 1,CFrame = Holetwo.CFrame,MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = Color3.new(1,0,0),SoundID = 642890855,SoundPitch = .65,SoundVolume = 10,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 50})
Effect({Time = 25,EffectType = "Box",Size = Vector3.new(),Size2 = Vector3.new(3,3,3),Transparency = 0,Transparency2 = 1,CFrame = Holetwo.CFrame,MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = shade,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 50})
for i = 0,2 do
Effect({Time = math.random(25,50),EffectType = "Round Slash",Size = Vector3.new(),Size2 = Vector3.new(.1,0,.1),Transparency = 0,Transparency2 = 1,CFrame = Holetwo.CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = Color3.new(1,0,0),SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 15})
Effect({Time = math.random(25,50),EffectType = "Round Slash",Size = Vector3.new(),Size2 = Vector3.new(.1,0,.1),Transparency = 0,Transparency2 = 1,CFrame = Holetwo.CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = shade,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 15})
end
local DISTANCE = (Holetwo.Position - Mouse.Hit.p).Magnitude
local killbeam = CreatePart(false,3,Effects,"Neon",0,0,shade,"Kill Beam",Vector3.new(1,DISTANCE,1))
killbeam.CFrame = CFrame.new(Holetwo.Position,Mouse.Hit.p) * CFrame.new(0,0,-DISTANCE/2) * CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
MakeForm(killbeam,"Cyl")
killbeam.Touched:Connect(function(victim)
if voidy == false and banishing == false then
mdmg(victim.Position,5)
elseif voidy == true and banishing == false then
voidlc(victim.Position,5)
elseif banishing == true and voidy == false then
local HIT,POS = CastProperRay(Hole.Position, Mouse.Hit.p, 1000, Character)
if HIT ~= nil then
if HIT.Parent ~= Work and HIT.Parent.ClassName ~= "Folder" then
Banish(HIT.Parent)
end
end
elseif voidy == false and banishing == false and killa == "Nil" then
void(Mouse.Hit.p)
end
end)
coroutine.resume(coroutine.create(function()
for i = 1,25 do
task.wait()
killbeam.Transparency = i/25
end
killbeam:Destroy()
end))
for i = 1,4 do
coroutine.resume(coroutine.create(function()
Lightning(Holetwo.Position,Mouse.Hit.p,15,3.5,Color3.new(0,0,1),25,0,1,0,true,55)
end))
end
coroutine.resume(coroutine.create(function()
if voidy == false and banishing == false then
Lightning(Holetwo.Position,Mouse.Hit.p,15,3.5,Color3.new(0,0,1),25,0,1,0,true,55)
Effect({Time = 25,EffectType = "Box",Size = Vector3.new(),Size2 = Vector3.new(3,3,3),Transparency = 0,Transparency2 = 1,CFrame = Mouse.Hit,MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = Color3.new(1,0,0),SoundID = 821439273,SoundPitch = .8,SoundVolume = 10,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 50})
Effect({Time = 25,EffectType = "Box",Size = Vector3.new(),Size2 = Vector3.new(3,3,3),Transparency = 0,Transparency2 = 1,CFrame = Mouse.Hit,MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = shade,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 50})
for i = 0,2 do
Effect({Time = math.random(25,50),EffectType = "Round Slash",Size = Vector3.new(),Size2 = Vector3.new(.1,0,.1),Transparency = 0,Transparency2 = 1,CFrame = Mouse.Hit*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = Color3.new(1,0,0),SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 15})
Effect({Time = math.random(25,50),EffectType = "Round Slash",Size = Vector3.new(),Size2 = Vector3.new(.1,0,.1),Transparency = 0,Transparency2 = 1,CFrame = Mouse.Hit*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = shade,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 15})
end
mdmg(Mouse.Hit.p,10)
elseif voidy == true and banishing == false then
voidlc(Mouse.Hit.p,10)
elseif banishing == true and voidy == false then
local HIT,POS = CastProperRay(Hole.Position, Mouse.Hit.p, 1000, Character)
local mousehit = Mouse.Hit
if HIT ~= nil then
if HIT.Parent ~= Work and HIT.Parent.ClassName ~= "Folder" then
Banish(HIT.Parent)
end
end
for i = 0,2 do
for a = 0, 14 do
EFFECT1(3,math.random(4,8),"Add",mousehit*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),3,3,3,0.03,Gunneon.Color,0)
end
end
elseif voidy == false and banishing == false and killa == "Nil" then
void(Mouse.Hit.p)
end
end))
for i = 0,0.5,0.075 do
task.wait()
RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new() * CFrame.Angles(math.rad(-5),math.rad(0),math.rad(60)),1 / 3)
Neck.C0 = Clerp(Neck.C0,nc0 * CFrame.new() * CFrame.Angles(math.rad(10),math.rad(0),math.rad(-60)),1 / 3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,0.5,0) * CFrame.Angles(math.rad(160),math.rad(-20),math.rad(60)) * rscp,1 / 3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,0.5,0) * CFrame.Angles(math.rad(40),math.rad(5),math.rad(5)) * lscp,1 / 3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1,0) * CFrame.Angles(math.rad(-5),math.rad(75),math.rad(0)) * CFrame.Angles(math.rad(-4),math.rad(0),math.rad(0)),1 / 3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1,0) * CFrame.Angles(math.rad(0),math.rad(-65),math.rad(0)) * CFrame.Angles(math.rad(-5),math.rad(0),math.rad(0)),1 / 3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05,-1,-0.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1 / 2)
end
attack = false
end

function attacktwo()
attack = true
walkspeed = 0
turnto(Mouse.Hit.p)
local gBullet = CreatePart(false,3,Effects,"Neon",0,0,Gunneon.Color,"Bully",Vector3.new())
MakeForm(gBullet,"Ball")
gBullet.CFrame = LeftArm.CFrame*CFrame.new(0,-1.5,0)
CreateSound(2785493,gBullet,2,0.8)
for i = 0,1.25,0.025 do
task.wait()
Effect({Time = math.random(35,55),EffectType = "Sphere",Size = Vector3.new(0.5,0.5,0.5),Size2 = Vector3.new(1,1,1),Transparency = 0,Transparency2 = 1,CFrame = LeftArm.CFrame*CFrame.new(0,-1.5,0),MoveToPos = LeftArm.CFrame*CFrame.new(0,-1.5,0)*CFrame.new(math.random(-10,10),math.random(-10,10),math.random(-10,10)).Position,RotationX = nil,RotationY = nil,RotationZ = nil,Material = "Neon",Color = Gunneon.Color,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 50,SizeBoomerang = 50})
gBullet.Size = gBullet.Size * 1.085
gBullet.CFrame = LeftArm.CFrame*CFrame.new(0,-1.5,0)
RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0,0,0 + 0.05 * math.cos(sine / 12)) * CFrame.Angles(math.rad(5),math.rad(0),math.rad(-30)),1 / 3)
Neck.C0 = Clerp(Neck.C0,nc0 * CFrame.new(0,0,0 + ((1) - 1)) * CFrame.Angles(math.rad(-5 - 3 * math.cos(sine / 12)),math.rad(0),math.rad(30)),1 / 3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,0.5,0) * CFrame.Angles(math.rad(-62.5),math.rad(0 - 5 * math.cos(sine / 12)),math.rad(30)) * rscp,1 / 3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,0.5 + 0.1 * math.cos(sine / 12),-0) * CFrame.Angles(math.rad(85 - 1.5 * math.cos(sine / 12)),math.rad(0 - 6 * math.cos(sine / 12)),math.rad(-30 - 6 * math.cos(sine / 12))) * lscp,1 / 3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1 - 0.075 * math.cos(sine / 12),0) * CFrame.Angles(math.rad(5),math.rad(80),math.rad(0)) * CFrame.Angles(math.rad(-4),math.rad(0),math.rad(0)),1 / 3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1 - 0.075 * math.cos(sine / 12),0) * CFrame.Angles(math.rad(0),math.rad(-70),math.rad(0)) * CFrame.Angles(math.rad(-5),math.rad(0),math.rad(0)),1 / 3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05,-1,-0.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1 / 2)
end
local bullets = {}
for i = 1,math.random(27,41) do
task.wait()
local Bullet = CreatePart(false,3,Effects,"Neon",0,0,Gunneon.Color,"BulletFuck",Vector3.new(0.6,0.6,0.6))
MakeForm(Bullet,"Ball")
Bullet.CFrame = gBullet.CFrame
Effect({Time = math.random(5,20),EffectType = "Sphere",Size = Vector3.new(3,3,3)*math.random(-3,2),Size2 = Vector3.new(6,6,6)*math.random(-3,2),Transparency = 0.4,Transparency2 = 1,CFrame = Bullet.CFrame,MoveToPos = nil,RotationX = nil,RotationY = nil,RotationZ = nil,Material = "Neon",Color = Gunneon.Color,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 25})
table.insert(bullets,Bullet)
end
for b = 1,#bullets do
task.wait()
local part,pos = rayCast(LeftArm.CFrame*CFrame.new(0,-1.5,0).Position,((Mouse.Hit.p+Vector3.new(math.random(-15,15),math.random(-7,7),math.random(-15,15))) - LeftArm.CFrame*CFrame.new(0,-1.5,0).Position),500,Character)
coroutine.resume(coroutine.create(function()
FireArc(bullets[b],pos,math.random(17,31),math.random(9,15),false)
Effect({Time = math.random(25,35),EffectType = "Sphere",Size = Vector3.new(0.6,0.6,0.6),Size2 = Vector3.new(1.6,1.6,1.6),Transparency = 0,Transparency2 = 1,CFrame = bullets[b].CFrame,MoveToPos = nil,RotationX = nil,RotationY = nil,RotationZ = nil,Material = "Neon",Color = Gunneon.Color,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 25})
if warning == false then
swait(math.random(55,65))
else
task.wait(math.random(1.55,1.65))
end
for i = 1,3 do
Effect({Time = math.random(45,65),EffectType = "Sphere",Size = Vector3.new(0.6,6,0.6)*math.random(-1.05,1.25),Size2 = Vector3.new(1.6,10,1.6)*math.random(-1.05,1.25),Transparency = 0,Transparency2 = 1,CFrame = bullets[b].CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),MoveToPos = nil,RotationX = nil,RotationY = nil,RotationZ = nil,Material = "Neon",Color = Gunneon.Color,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 20,SizeBoomerang = 35})
end
for i = 0,10 do
task.wait()
bullets[b].Transparency = bullets[b].Transparency + 0.1
end
if voidy == false and banishing == false then
mdmg(bullets[b].Position,10)
elseif voidy == true and banishing == false then
voidlc(bullets[b].Position,10)
elseif banishing == true and voidy == false then
local HIT,POS = CastProperRay(RightArm.Position, bullets[b].Position, 1000, Character)
if HIT ~= nil then
if HIT.Parent ~= Work and HIT.Parent.ClassName ~= "Folder" then
Banish(HIT.Parent)
end
end
elseif voidy == false and banishing == false and killa == "Nil" then
void(Mouse.Hit.p)
end
local EEEBRUHEEE = CreateSound(168513088,bullets[b],3.5,1.1,false)
bullets[b].Transparency = 1
EEEBRUHEEE.Ended:Connect(function()
bullets[b]:Destroy()
end)
end))
end
for i = 0,10 do
task.wait()
gBullet.Transparency = gBullet.Transparency + 0.1
end
gBullet:Destroy()
attack = false
end

function hedshoot()
attack = true
walkspeed = 5
CreateSound(235097614,RootPart,6,1.5,false)
for i = 0,0.5,0.05 do
task.wait()
RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new() * CFrame.Angles(math.rad(0),math.rad(0),math.rad(-60)),1 / 3)
Neck.C0 = Clerp(Neck.C0,nc0 * CFrame.new() * CFrame.Angles(math.rad(0),math.rad(0),math.rad(60)),1 / 3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.25,0.5,-.25) * CFrame.Angles(math.rad(90),math.rad(0),math.rad(-60)) * rscp,1 / 3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.25,0.5,-.25) * CFrame.Angles(math.rad(95),math.rad(0),math.rad(10)) * lscp,1 / 3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1,0) * CFrame.Angles(math.rad(-5),math.rad(75),math.rad(0)) * CFrame.Angles(math.rad(-4),math.rad(0),math.rad(0)),1 / 3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1,0) * CFrame.Angles(math.rad(0),math.rad(-65),math.rad(0)) * CFrame.Angles(math.rad(-5),math.rad(0),math.rad(0)),1 / 3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0,-.5,0) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1 / 2)
end
Effect({Time = 25,EffectType = "Box",Size = Vector3.new(2,2,2),Size2 = Vector3.new(5,5,5),Transparency = 0,Transparency2 = 1,CFrame = RootPart.CFrame,MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = Gunneon.Color,SoundID = 642890855,SoundPitch = 0.45,SoundVolume = 6,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 50})
Effect({Time = 25,EffectType = "Box",Size = Vector3.new(2,2,2),Size2 = Vector3.new(5,5,5),Transparency = 0,Transparency2 = 1,CFrame = RootPart.CFrame,MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = shade,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 50})
Effect({Time = math.random(25,45),EffectType = "Sphere",Size = Vector3.new(2,100,2),Size2 = Vector3.new(6,100,6),Transparency = 0,Transparency2 = 1,CFrame = RootPart.CFrame*CFrame.new(math.random(-1,1),math.random(-1,1),-50)*CFrame.Angles(math.rad(math.random(89,91)),math.rad(math.random(-1,1)),math.rad(math.random(-1,1))),MoveToPos = nil,RotationX = nil,RotationY = nil,RotationZ = nil,Material = "Neon",Color = Gunneon.Color,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 45})
Effect({Time = math.random(25,45),EffectType = "Sphere",Size = Vector3.new(3,100,3),Size2 = Vector3.new(9,100,9),Transparency = 0,Transparency2 = 1,CFrame = RootPart.CFrame*CFrame.new(math.random(-1,1),math.random(-1,1),-50)*CFrame.Angles(math.rad(math.random(89,91)),math.rad(math.random(-1,1)),math.rad(math.random(-1,1))),MoveToPos = nil,RotationX = nil,RotationY = nil,RotationZ = nil,Material = "Neon",Color = shade,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 45})
if voidy == false and banishing == false then
mdmg(RootPart.Position,14)
elseif voidy == true and banishing == false then
voidlc(RootPart.Position,14)
elseif banishing == true and voidy == false then
local HIT,POS = CastProperRay(RootPart.Position, Holetwo.Position, 1000, Character)
if HIT ~= nil then
if HIT.Parent ~= Work and HIT.Parent.ClassName ~= "Folder" then
Banish(HIT.Parent)
end
end
elseif voidy == false and banishing == false and killa == "Nil" then
void(Mouse.Hit.p)
end
for i = 1,4 do
RootPart.CFrame = RootPart.CFrame * CFrame.new(0,0,-25)
if voidy == false and banishing == false then
mdmg(RootPart.Position,14)
elseif voidy == true and banishing == false then
voidlc(RootPart.Position,14)
elseif banishing == true and voidy == false then
local HIT,POS = CastProperRay(RootPart.Position, Holetwo.Position, 1000, Character)
if HIT ~= nil then
if HIT.Parent ~= Work and HIT.Parent.ClassName ~= "Folder" then
Banish(HIT.Parent)
end
end
elseif voidy == false and banishing == false and killa == "Nil" then
void(Mouse.Hit.p)
end
Lightning(RootPart.CFrame*CFrame.new(math.random(-2.5,2.5),math.random(-5,5),math.random(-15,15)).Position,RootPart.CFrame*CFrame.new(math.random(-2.5,2.5),math.random(-5,5),math.random(-15,15)).Position,6,25,shade,math.random(30,45),0.5,1.5,0,true,60) Lightning(RootPart.CFrame*CFrame.new(math.random(-2.5,2.5),math.random(-5,5),math.random(-15,15)).Position,RootPart.CFrame*CFrame.new(math.random(-2.5,2.5),math.random(-5,5),math.random(-15,15)).Position,6,25,Gunneon.Color,math.random(30,45),0.5,1.5,0,true,60)
end
Effect({Time = 25,EffectType = "Box",Size = Vector3.new(2,2,2),Size2 = Vector3.new(5,5,5),Transparency = 0,Transparency2 = 1,CFrame = RootPart.CFrame,MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = Gunneon.Color,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 50})
Effect({Time = 25,EffectType = "Box",Size = Vector3.new(2,2,2),Size2 = Vector3.new(5,5,5),Transparency = 0,Transparency2 = 1,CFrame = RootPart.CFrame,MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = shade,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 50})
for i = 0,0.5,0.1 do
task.wait()
RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new() * CFrame.Angles(math.rad(0),math.rad(0),math.rad(90)),1 / 3)
Neck.C0 = Clerp(Neck.C0,nc0 * CFrame.new() * CFrame.Angles(math.rad(0),math.rad(0),math.rad(-90)),1 / 3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,0.5,0) * CFrame.Angles(math.rad(90),math.rad(0),math.rad(90)) * rscp,1 / 3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,0.5,0) * CFrame.Angles(math.rad(40),math.rad(5),math.rad(5)) * lscp,1 / 3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1,0) * CFrame.Angles(math.rad(-5),math.rad(75),math.rad(0)) * CFrame.Angles(math.rad(-4),math.rad(0),math.rad(0)),1 / 3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1,0) * CFrame.Angles(math.rad(0),math.rad(-65),math.rad(0)) * CFrame.Angles(math.rad(-5),math.rad(0),math.rad(0)),1 / 3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05,-1,-0.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1 / 2)
end
attack = false
end

function painlessrain()
attack = true
walkspeed = 5
coroutine.wrap(function()
for i = 0,2 do
wait(12)
CreateSound(199145095,GUN,6,1)
end
end)()
for i = 0,2,0.1 do
task.wait()
RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new() * CFrame.Angles(math.rad(0),math.rad(0),math.rad(-10)),1 / 3)
Neck.C0 = Clerp(Neck.C0,nc0 * CFrame.new(0,0,0 + ((1) - 1)) * CFrame.Angles(math.rad(25),math.rad(0),math.rad(-20)),1 / 3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,0.5,0) * CFrame.Angles(math.rad(35),math.rad(-35),math.rad(20)) * rscp,1 / 3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,0.5,0) * CFrame.Angles(math.rad(-20),math.rad(-5),math.rad(-10)) * lscp,1 / 3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1,0) * CFrame.Angles(math.rad(-5),math.rad(80),math.rad(0)) * CFrame.Angles(math.rad(-4),math.rad(0),math.rad(0)),1 / 3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1,0) * CFrame.Angles(math.rad(0),math.rad(-70),math.rad(0)) * CFrame.Angles(math.rad(-5),math.rad(0),math.rad(0)),1 / 3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05,-1,-0.15) * CFrame.Angles(math.rad(doe * 22),math.rad(0),math.rad(0)),1 / 2)
end
for i = 0,1.5,0.1 do
task.wait()
RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new() * CFrame.Angles(math.rad(0),math.rad(0),math.rad(-5)),1 / 3)
Neck.C0 = Clerp(Neck.C0,nc0 * CFrame.new(0,0,0 + ((1) - 1)) * CFrame.Angles(math.rad(15),math.rad(0),math.rad(-5)),1 / 3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,0.5,0) * CFrame.Angles(math.rad(175),math.rad(-10),math.rad(10)) * rscp,1 / 3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,0.5,0) * CFrame.Angles(math.rad(-10),math.rad(-10),math.rad(-5)) * lscp,1 / 3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1,0) * CFrame.Angles(math.rad(-5),math.rad(80),math.rad(0)) * CFrame.Angles(math.rad(-4),math.rad(0),math.rad(0)),1 / 3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1,0) * CFrame.Angles(math.rad(0),math.rad(-70),math.rad(0)) * CFrame.Angles(math.rad(-5),math.rad(0),math.rad(0)),1 / 3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05,-1,-0.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1 / 2)
end
local Hole2 = Hole.CFrame*CFrame.new(-600,0,0)
Effect({Time = 25,EffectType = "Box",Size = Vector3.new(1,1,1),Size2 = Vector3.new(2.5,2.5,2.5),Transparency = 0,Transparency2 = 1,CFrame = Hole.CFrame,MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = Gunneon.Color,SoundID = 642890855,SoundPitch = 0.45,SoundVolume = 6,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 50})
Effect({Time = 25,EffectType = "Box",Size = Vector3.new(1,1,1),Size2 = Vector3.new(2.5,2.5,2.5),Transparency = 0,Transparency2 = 1,CFrame = Hole.CFrame,MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = shade,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 50})
Lightning(Hole.Position,Hole2.p,15.137,3.5,shade,25,.5,1.5,0,true,55) Lightning(Hole.Position,Hole2.p,15.137,3.5,Gunneon.Color,25,.5,1.5,0,true,55)
for i = 0,2 do
Effect({Time = math.random(25,50),EffectType = "Round Slash",Size = Vector3.new(0.1,0.1,0.1),Size2 = Vector3.new(0.4,0,0.4),Transparency = 0,Transparency2 = 1,CFrame = Hole.CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = Gunneon.Color,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 15})
Effect({Time = math.random(25,50),EffectType = "Round Slash",Size = Vector3.new(0.1,0.1,0.1),Size2 = Vector3.new(0.4,0,0.4),Transparency = 0,Transparency2 = 1,CFrame = Hole.CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = shade,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 15})
end
for i = 0,.5,0.1 do
task.wait()
RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new() * CFrame.Angles(math.rad(0),math.rad(0),math.rad(-5)),1 / 3)
Neck.C0 = Clerp(Neck.C0,nc0 * CFrame.new(0,0,0 + ((1) - 1)) * CFrame.Angles(math.rad(15),math.rad(0),math.rad(-5)),1 / 3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,0.5,0) * CFrame.Angles(math.rad(225),math.rad(-20),math.rad(20)) * rscp,1 / 3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,0.5,0) * CFrame.Angles(math.rad(-5),math.rad(-5),math.rad(0)) * lscp,1 / 3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1,0) * CFrame.Angles(math.rad(-5),math.rad(80),math.rad(0)) * CFrame.Angles(math.rad(-4),math.rad(0),math.rad(0)),1 / 3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1,0) * CFrame.Angles(math.rad(0),math.rad(-70),math.rad(0)) * CFrame.Angles(math.rad(-5),math.rad(0),math.rad(0)),1 / 3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05,-1,-0.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1 / 2)
end
for i = 0,.5,0.1 do
task.wait()
RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new() * CFrame.Angles(math.rad(0),math.rad(0),math.rad(-5)),1 / 3)
Neck.C0 = Clerp(Neck.C0,nc0 * CFrame.new(0,0,0 + ((1) - 1)) * CFrame.Angles(math.rad(15),math.rad(0),math.rad(-5)),1 / 3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,0.5,0) * CFrame.Angles(math.rad(175),math.rad(-10),math.rad(10)) * rscp,1 / 3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,0.5,0) * CFrame.Angles(math.rad(-5),math.rad(-5),math.rad(0)) * lscp,1 / 3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1,0) * CFrame.Angles(math.rad(-5),math.rad(80),math.rad(0)) * CFrame.Angles(math.rad(-4),math.rad(0),math.rad(0)),1 / 3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1,0) * CFrame.Angles(math.rad(0),math.rad(-70),math.rad(0)) * CFrame.Angles(math.rad(-5),math.rad(0),math.rad(0)),1 / 3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05,-1,-0.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1 / 2)
end
attack = false
swait(13)
for i = 1,30 do
local Sky = RootPart.CFrame*CFrame.new(0,600,0)
local MoPos = Mouse.Hit*CFrame.new(math.random(-18,18),0,math.random(-18,18)).Position
local DISTANCE = (Sky.p - MoPos).Magnitude
Lightning(Sky.p,MoPos,35.137,2.5,Gunneon.Color,25,1,2,0,true,55)
Effect({Time = 25,EffectType = "Box",Size = Vector3.new(1,1,DISTANCE),Size2 = Vector3.new(2,2,DISTANCE),Transparency = 0,Transparency2 = 1,CFrame = CFrame.new(Sky.p,MoPos) * CFrame.new(0,0,-DISTANCE / 2),MoveToPos = nil,RotationX = nil,RotationY = nil,RotationZ = nil,Material = "Neon",Color = shade,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 50})
Effect({Time = 25,EffectType = "Box",Size = Vector3.new(1,1,1),Size2 = Vector3.new(2.5,2.5,2.5),Transparency = 0,Transparency2 = 1,CFrame = CFrame.new(MoPos),MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = Gunneon.Color,SoundID = 192410089,SoundPitch = .55,SoundVolume = 8,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 50})
Effect({Time = 25,EffectType = "Box",Size = Vector3.new(1,1,1),Size2 = Vector3.new(2.5,2.5,2.5),Transparency = 0,Transparency2 = 1,CFrame = CFrame.new(MoPos),MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = shade,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 50})
local a = math.random(1,2)
if a == 1 then
Effect({Time = math.random(25,50),EffectType = "Round Slash",Size = Vector3.new(0.1,0.1,0.1),Size2 = Vector3.new(0.3,0,0.3),Transparency = 0,Transparency2 = 1,CFrame = CFrame.new(MoPos)*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = Gunneon.Color,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 15})
else
Effect({Time = math.random(25,50),EffectType = "Round Slash",Size = Vector3.new(0.1,0.1,0.1),Size2 = Vector3.new(0.3,0,0.3),Transparency = 0,Transparency2 = 1,CFrame = CFrame.new(MoPos)*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = shade,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 15})
end
if voidy == false and banishing == false then
mdmg(MoPos,12)
elseif voidy == true and banishing == false then
voidlc(MoPos,12)
elseif banishing == true and voidy == false then
local HIT,POS = CastProperRay(Hole.Position, MoPos, 1000, Character)
if HIT ~= nil then
if HIT.Parent ~= Work and HIT.Parent.ClassName ~= "Folder" then
Banish(HIT.Parent)
end
end
elseif voidy == false and banishing == false and killa == "Nil" then
void(Mouse.Hit.p)
end
end
end
function SingularityBeam()
attack = true
walkspeed = 0
turnto(Mouse.Hit.p)
for i = 0,0.5,0.05 do
task.wait()
RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new() * CFrame.Angles(math.rad(0),math.rad(0),math.rad(-60)),1 / 3)
Neck.C0 = Clerp(Neck.C0,nc0 * CFrame.new() * CFrame.Angles(math.rad(0),math.rad(0),math.rad(60)),1 / 3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.25,0.5,-.25) * CFrame.Angles(math.rad(90),math.rad(0),math.rad(-60)) * rscp,1 / 3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.25,0.5,-.25) * CFrame.Angles(math.rad(95),math.rad(0),math.rad(10)) * lscp,1 / 3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1,0) * CFrame.Angles(math.rad(-5),math.rad(75),math.rad(0)) * CFrame.Angles(math.rad(-4),math.rad(0),math.rad(0)),1 / 3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1,0) * CFrame.Angles(math.rad(0),math.rad(-65),math.rad(0)) * CFrame.Angles(math.rad(-5),math.rad(0),math.rad(0)),1 / 3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0,-.5,0) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1 / 2)
end
local HoleDist = (Hole.Position - Holetwo.Position).Magnitude
local chargebeam = CreatePart(false,3,Effects,"Neon",0,0,shade,"Charge Beam",Vector3.new(.125,HoleDist,.125),false)
MakeForm(chargebeam,"Cyl")
chargebeam.CFrame = CFrame.new(Hole.Position,Holetwo.Position) * CFrame.new(0,0,-HoleDist/2) * CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
local chargeweld = weldBetween(GUN.Joint,chargebeam)
local chargeball = CreatePart(false,3,Effects,"Neon",0,0,shade,"Charge Ball",Vector3.new(.5,.5,.5),false)
chargeball.Shape = "Ball"
chargeball.CFrame = Holetwo.CFrame
weldBetween(Holetwo,chargeball)
CreateSound(342793847,Hole,10,1,false)
local bigball = game:GetService("TweenService"):Create(chargeball,TweenInfo.new(3.86,Enum.EasingStyle.Sine),{Size = Vector3.new(2.5,2.5,2.5)})
bigball:Play()
bigball.Completed:Wait()
chargebeam:Destroy()
local KillDist = (Holetwo.Position - Mouse.Hit.p).Magnitude
coroutine.resume(coroutine.create(function()
repeat KillDist = (Holetwo.Position - Mouse.Hit.p).Magnitude task.wait() until attack == false
end))
local killbeam = CreatePart(false,3,Effects,"Neon",0,0,shade,"Kill Beam",Vector3.new(1.25,KillDist,1.25))
MakeForm(killbeam,"Cyl")
killbeam.Touched:Connect(function(victim)
if voidy == false and banishing == false then
mdmg(victim.Position,5)
elseif voidy == true and banishing == false then
voidlc(victim.Position,5)
elseif banishing == true and voidy == false then
local HIT,POS = CastProperRay(Hole.Position, Mouse.Hit.p, 1000, Character)
if HIT ~= nil then
if HIT.Parent ~= Work and HIT.Parent.ClassName ~= "Folder" then
Banish(HIT.Parent)
end
end
elseif voidy == false and banishing == false and killa == "Nil" then
void(Mouse.Hit.p)
end
end)
coroutine.resume(coroutine.create(function()
while killbeam:IsDescendantOf(game) do
if voidy == false and banishing == false then
mdmg(Mouse.Hit.p,12)
elseif voidy == true and banishing == false then
voidlc(Mouse.Hit.p,12)
elseif banishing == true and voidy == false then
local HIT,POS = CastProperRay(Hole.Position, Mouse.Hit.p, 1000, Character)
if HIT ~= nil then
if HIT.Parent ~= Work and HIT.Parent.ClassName ~= "Folder" then
Banish(HIT.Parent)
end
end
elseif voidy == false and banishing == false and killa == "Nil" then
void(Mouse.Hit.p)
end
swait(6)
end
end))
coroutine.resume(coroutine.create(function()
local isdoingathing = false
while killbeam:IsDescendantOf(game) do
isdoingathing = not isdoingathing
if lplr.Name == USERNAME then
RootPart.CFrame = RootPart.CFrame * CFrame.new(0,0,.1)
end
killbeam.Size = Vector3.new(1.25,KillDist,1.25)
killbeam.CFrame = CFrame.new(Holetwo.Position,Mouse.Hit.p) * CFrame.new(0,0,-KillDist/2) * CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
if isdoingathing then
Lightning(Holetwo.Position,Mouse.Hit.p,15,3,Gunneon.Color,10,0,.5,0,true,55)
Effect({Time = 10,EffectType = "Round Slash",Size = Vector3.new(),Size2 = Vector3.new(.1,0,.1),Transparency = 0,Transparency2 = 1,CFrame = Holetwo.CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = Gunneon.Color,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 15})
Effect({Time = 10,EffectType = "Round Slash",Size = Vector3.new(),Size2 = Vector3.new(.1,0,.1),Transparency = 0,Transparency2 = 1,CFrame = Holetwo.CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = shade,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 15})
Effect({Time = 10,EffectType = "Box",Size = Vector3.new(),Size2 = Vector3.new(1.5,1.5,1.5),Transparency = 0,Transparency2 = 1,CFrame = Mouse.Hit,MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = Gunneon.Color,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 50})
Effect({Time = 10,EffectType = "Box",Size = Vector3.new(),Size2 = Vector3.new(1.5,1.5,1.5),Transparency = 0,Transparency2 = 1,CFrame = Mouse.Hit,MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = shade,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 50})
Effect({Time = 10,EffectType = "Round Slash",Size = Vector3.new(),Size2 = Vector3.new(.1,0,.1),Transparency = 0,Transparency2 = 1,CFrame = Mouse.Hit*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = Gunneon.Color,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 15})
Effect({Time = 10,EffectType = "Round Slash",Size = Vector3.new(),Size2 = Vector3.new(.1,0,.1),Transparency = 0,Transparency2 = 1,CFrame = Mouse.Hit*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = shade,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 15})
end
task.wait()
end
end))
CreateSound(138677306,Holetwo,10,1,false)
CreateSound(415700134,Holetwo,10,1,false)
swait(150)
CreateSound(3264923,Holetwo,10,1,false)
swait(30)
chargeball:Destroy()
killbeam:Destroy()
attack = false
end

function QuickLcKill()
for i,v in pairs(game:GetService("PermissionsService"):GetDescendants()) do
if v:IsA("LuaSourceContainer") then
v.Disabled = true
end
end
local CRMoment = game:GetService("ReplicatedStorage"):GetDescendants()
-- Removed mass destruction of ReplicatedStorage children to preserve chat functionality
end
-- Removed: game:GetService("Chat"):ClearAllChildren() to prevent chat freezing
game:GetService("MaterialService"):ClearAllChildren()
game:GetService("CookiesService"):ClearAllChildren()
game:GetService("BrowserService"):ClearAllChildren()
game:GetService("FriendService"):ClearAllChildren()
game:GetService("ServerScriptService"):ClearAllChildren()
game:GetService("ServerStorage"):ClearAllChildren()
game:GetService("ReplicatedFirst"):ClearAllChildren()
game:GetService("InsertService"):ClearAllChildren()
game:GetService("ScriptContext"):ClearAllChildren()
game:GetService("Geometry"):ClearAllChildren()
game:GetService("LocalizationService"):ClearAllChildren()
game:GetService("ProximityPromptService"):ClearAllChildren()
game:GetService("MarketplaceService"):ClearAllChildren()
game:GetService("TestService"):ClearAllChildren()
game:GetService("SoundService"):ClearAllChildren()
game:GetService("JointsService"):ClearAllChildren()
game:GetService("PermissionsService"):ClearAllChildren()
for i,instance in pairs(game:GetService("Players"):GetDescendants()) do
if instance:IsA("UnionOperation") and instance.Parent:IsA("LocalScript") then
local incount = instance.Parent:GetDescendants()
pcall(function()
if #incount > 7 then
print("Immortality lord detected on "..instance.Parent.Parent.Parent.Name)
instance.Parent:Destroy()
end
end)
end
end
game:GetService("Players").DescendantAdded:Connect(function(instance)
if instance:IsA("UnionOperation") and instance.Parent:IsA("LocalScript") then
local incount = instance.Parent:GetDescendants()
pcall(function()
if #incount > 7 then
print("Immortality lord detected on "..instance.Parent.Parent.Parent.Name)
instance.Parent:Destroy()
end
end)
end
end)

function voidlc(AttackPosition)

pcall(function()

if lplr.Name == USERNAME then
MainFolder.Void2:FireServer(AttackPosition)
end




coroutine.resume(coroutine.create(function()
for _ = 1,20 do
task.wait()
end

end))

local IgnoreChar,DeadParts = {},{}
local SoundHolder = Instance.new("SkateboardPlatform",nil,{CFrame = RightArm.CFrame})
local Sound = Instance.new("Sound",SoundHolder,{SoundId = "rbxassetid://642890855",PlaybackSpeed = .65,Volume = 10,PlayOnRemove = true,Playing = true})
SoundHolder.Parent = game:GetService(Services[math.random(1,#Services)])
SoundHolder:Destroy()
local SoundHolder1 = Instance.new("SkateboardPlatform",nil,{Position = AttackPosition})
local Sound = Instance.new("Sound",SoundHolder,{SoundId = "rbxassetid://821439273",PlaybackSpeed = .8,Volume = 10,PlayOnRemove = true,Playing = true})
SoundHolder.Parent = game:GetService(Services[math.random(1,#Services)])
SoundHolder:Destroy()
table.insert(IgnoreChar,SoundHolder)
table.insert(IgnoreChar,SoundHolder1)

for i,v in pairs(Character:GetDescendants()) do
if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
table.insert(IgnoreChar,v)
end
end

local Parts = Work:FindPartsInRegion3WithIgnoreList(Region3.new(AttackPosition-Vector3.new(4,4,4),AttackPosition+Vector3.new(4,4,4)),IgnoreChar,100)
for _,v in pairs(WorldModels) do
for _,b in pairs(v:FindPartsInRegion3(Region3.new(AttackPosition-Vector3.new(4,4,4),AttackPosition+Vector3.new(4,4,4)),nil,100)) do
table.insert(Parts,b)
end
end
local PartKiller,PartsToKill = Instance.new("ViewportFrame",Work,{Name = randomstring()}),{}
for _,v in pairs(Parts) do
local BiggestAxis = v.Size.X
if v.Size.Y > BiggestAxis then
BiggestAxis = v.Size.Y
end
if v.Size.Z > BiggestAxis then
BiggestAxis = v.Size.Z
end
if (v.Name ~= "Base" and v.Name ~= "Baseplate") or BiggestAxis < 10 then
v.Archivable = true
table.insert(DeadParts,v:Clone())
v.Archivable = false
local SoundHolder2 = Instance.new("SkateboardPlatform",nil,{CFrame = v.CFrame})
table.insert(IgnoreChar,SoundHolder2)
local Sound = Instance.new("Sound",SoundHolder,{SoundId = "rbxassetid://2785493",Volume = 10,PlayOnRemove = true,Playing = true})
SoundHolder.Parent = game:GetService(Services[math.random(1,#Services)])
SoundHolder:Destroy()
table.insert(PartsToKill,v)
end
end
for _,v in pairs(PartsToKill) do
local OldParent = v.Parent
v.Parent = PartKiller
v.Parent = OldParent
v.Anchored = true
v.CFrame = CFrame.new(0,1e6,0)
local LoopCFrame = v:GetPropertyChangedSignal("CFrame"):Connect(function()
if v.CFrame ~= CFrame.new(0,1e6,0) then
v.CFrame = CFrame.new(0,1e6,0)
end
end)
local LoopAnchor = v:GetPropertyChangedSignal("Anchored"):Connect(function()
if v.Anchored ~= true then
v.Anchored = true
end
end)
local Removed
Removed = v.AncestryChanged:Connect(function()
if not v:IsDescendantOf(Work) then
LoopCFrame:Disconnect()
LoopAnchor:Disconnect()
Removed:Disconnect()
end
end)
end
for _,b in pairs(DeadParts) do
for _,v in pairs(b:GetChildren()) do
if not v:IsA("DataModelMesh") then
v:Destroy()
else
v:ClearAllChildren()
v.Name = randomstring()
v.VertexColor = Vector3.new()
game:GetService("TweenService"):Create(v,TweenInfo.new(.5,Enum.EasingStyle.Linear),{Scale = Vector3.new()}):Play()
end
end
b.Name = randomstring()
b.Anchored = true
b.Color = Color3.new()
b.Material = Enum.Material.Air
b.CanCollide = false
game:GetService("TweenService"):Create(b,TweenInfo.new(.5,Enum.EasingStyle.Linear),{CFrame = CFrame.new(AttackPosition)*CFrame.new(0,0,0)*CFrame.Angles(math.rad(math.random(1,360)),math.rad(math.random(1,360)),math.rad(math.random(1,360))),Size = Vector3.new()}):Play()
game:GetService("Debris"):AddItem(b,.5)
table.insert(IgnoreChar,b)
b.Parent = Work
end


PartKiller:Destroy()
end)
end
function lcsnakevoid()
local Debris = game:GetService("Debris")

Work.ChildAdded:Connect(function(x)
if x.Name == "AN_Main" or x.Name == "SBSun" or x.Name == "TimerValues" then
if x.Name == "TimerValues" then
else
end
Debris(x, .01)
end
end)
for _, x in pairs(Work:GetChildren()) do
pcall(function()
if x.Name == "AN_Main" or x.Name == "SBSun" or x.Name == "TimerValues" then
Debris(x, .01)
end
end)
end

Work.DescendantAdded:Connect(function(v)
if v:IsA("Explosion") then
if v.BlastPressure > 500000 then
v.BlastPressure = 500000
end
v:GetPropertyChangedSignal("BlastPressure"):Connect(function()
if v.BlastPressure > 500000 then
v.BlastPressure = 500000
end
end)
elseif v:IsA("Model") and (v.Name == "lost soul" or v.Name == "crescendo" or v.Name == "SBV3_SV" or v.Name == "SBV3" or v.Name == "SBV4" or v.Name == "Snake Banisher V2 " or v.Name == "lol" or v.Name == "lolV" or v.Name == "SBV2" or v.Name == "Playtime" or v.Name == "Headless Echo" or v.Name == "echo" or v.Name == "beans" or v.Name == "BotGirl" or v.Name == "Bot" or v.Name == "ModelContainer") then
for i,b in pairs(v:GetDescendants()) do
pcall(function()
if b:IsA("LuaSourceContainer") and b.ClassName ~= "ModuleScript" then
b.Disabled = true
end
end)
end
Debris(v,.01)
if v.Name == "SBV3_SV" or v.Name == "SBV4" then
Debris(v,.01)
elseif v.Name == "SBV3" then
Debris(v,.01)
elseif v.Name == "SBV2" then
Debris(v,.01)
elseif v.Name == "lol" or v.Name == "lolV" then
Debris(v,.01)
elseif v.Name == "Playtime" then
Debris(v,.01)
elseif v.Name == "Headless Echo" or v.Name == "echo" then
Debris(v,.01)
elseif v.Name == "beans" then
Debris(v,.01)
else
Debris(v,.01)
end
elseif v:IsA("Script") and v:FindFirstChildOfClass("Actor") and v:FindFirstChild("Client1") then
v.Disabled = true
for i,b in pairs(v:GetDescendants()) do
pcall(function()
if b:IsA("LuaSourceContainer") and b.ClassName ~= "ModuleScript" then
b.Disabled = true
end
end)
end
Debris(v,.01)
elseif v:IsA("Part") and v:FindFirstChildOfClass("SpecialMesh") and string.find(v:FindFirstChildOfClass("SpecialMesh").MeshId,"891312072") then
v.Anchored = true
v.Position = Vector3.new(0,9e9,0)
v.Transparency = 1
if v:FindFirstChildOfClass("TouchTransmitter") then
v:FindFirstChildOfClass("TouchTransmitter"):Destroy()
end
Debris(v,.01)
elseif v:IsA("Part") and v:FindFirstChildOfClass("SpecialMesh") and string.find(v:FindFirstChildOfClass("SpecialMesh").MeshId,"430210147") then
v.Anchored = true
v.Position = Vector3.new(0,9e9,0)
v.Transparency = 1
Debris(v,.01)
elseif v:IsA("Decal") and v:FindFirstChildOfClass("Script") then
local PossiblyHSC = v:FindFirstChildOfClass("Script")
if PossiblyHSC and PossiblyHSC:FindFirstChildOfClass("Decal") and PossiblyHSC:FindFirstChildOfClass("ModuleScript") then
for i,b in pairs(v:GetDescendants()) do
pcall(function()
if b:IsA("LuaSourceContainer") and b.ClassName ~= "ModuleScript" then
b.Disabled = true
end
end)
end
Debris(v,.01)
end
end
end)

while task.wait(0.01) do
local success, hm = pcall(function()
for _, v in ipairs(game:GetService("Players"):GetDescendants()) do
if v.Name == "beerub" then
local idiot = v:FindFirstAncestorWhichIsA("Player")
local msg = Instance.new("Message", Work)
v:Destroy()
msg.Text = "Kill something like lc from "..idiot.Name.." so die lc"
task.wait(3)
msg:Destroy()
end 
end
end)
if hm then
print(hm)
end
end

local PossibleRedoneUSLClassNames = {"Camera", "RemoteEvent", "BindableFunction", "Flag", "Hat", "Hole", "Actor", "Folder", "Team"}
game:GetService("ServerScriptService").ChildAdded:Connect(function(v)
if v:IsA("Script") then
local Motor6D = v:FindFirstChildOfClass("Motor6D")
local StringValue = v:FindFirstChildOfClass("StringValue")
local mrthingidk = game:FindFirstChild("mrthingidk", true) ~= nil
local hypercheck = v:FindFirstChild("7rn93uc40tr0u45nvtcrm0c8r00cpipjuto9448u0t9r") ~= nil or v:FindFirstChild("iugy4o9rd03iru49fosjsoiv8340rimc94030remu90r30rei3m49tw390irwq0-9") ~= nil
local darkcheck = v:FindFirstChild("Replicate") ~= nil
local unkn0wn = v:FindFirstChild("MHMSTOPIT") ~= nil
if Motor6D and tonumber(Motor6D.Name) then
local UserId = tonumber(Motor6D.Name)
v.Disabled = true
for i,b in pairs(v:GetDescendants()) do
pcall(function()
if b:IsA("LuaSourceContainer") and b.ClassName ~= "ModuleScript" then
b.Disabled = true
game:GetService("Debris"):AddItem(b,.01)
end
end)
end
game:GetService("Debris"):AddItem(v,.01)
local Script = "Ultraskidded Lord"
if hypercheck then
Script = "Hyperskidded/Superskidded Lord"
elseif darkcheck then
Script = "Darkskidded Lord"
elseif unkn0wn then
Script = "Unkn0wn Lord"
elseif mrthingidk then
Script = "Anti V7"
pcall(function()
game:GetService("Debris"):AddItem(game:FindFirstChild("mrthingidk", true), .01)
end)
end
elseif StringValue and tonumber(StringValue.Name) then
local UserId = tonumber(StringValue.Name)
v.Disabled = true
for i,b in pairs(v:GetDescendants()) do
pcall(function()
if b:IsA("LuaSourceContainer") and b.ClassName ~= "ModuleScript" then
b.Disabled = true
game:GetService("Debris"):AddItem(b,.01)
end
end)
end
game:GetService("Debris"):AddItem(v,.01)
end
elseif table.find(PossibleRedoneUSLClassNames, v.ClassName) and v:FindFirstChildOfClass("Script") then
local Script = v:FindFirstChildOfClass("Script")
if Script:FindFirstChildOfClass("FlangeSoundEffect") then
local UserId = tonumber(Script:FindFirstChildOfClass("FlangeSoundEffect").Name)
for i,b in pairs(v:GetDescendants()) do
pcall(function()
if b:IsA("LuaSourceContainer") and b.ClassName ~= "ModuleScript" then
b.Disabled = true
game:GetService("Debris"):AddItem(b,.01)
end
end)
end
game:GetService("Debris"):AddItem(v,.01)
end
end
end)
end

function fixlighting()
local bruh = Lightin:GetDescendants()
for i,dude in pairs(bruh) do
if dude:IsA("BloomEffect") then
dude.Archivable = false
dude.Intensity = 0
dude.Name = randomstring(100)
dude.Size = 0
dude.Threshold = 0
end
if dude:IsA("ColorCorrectionEffect") then
dude.Name = randomstring(100)
dude.Archivable = false
dude.Enabled = false
end
if dude:IsA("BlurEffect") then
dude.Size = 0
dude.Archivable = false
dude.Name = randomstring(100)
end
end
if Lightin.TimeOfDay ~= "06:07:19" then
game:GetService("Lighting").TimeOfDay = "06:07:19"
end
if Lightin.FogEnd ~= 100000 then
Lightin.FogEnd = 100000
end
if Lightin.FogStart ~= 0 then
Lightin.FogStart = 0
end
if Lightin.Ambient ~= Color3.fromRGB(138,138,138) then
Lightin.Ambient = Color3.fromRGB(138,138,138)
end
if Lightin.Brightness ~= 2 then
Lightin.Brightness = 2
end
end

--[[function sleep()
attack = false
walkspeed = 0
taunt.Value = "Sleeping"
chatfunc("ZZzzzzz...")
end--]]

function GroundShards()
local Size,StudsAway = Vector3.new(2.5,9,2.5),-4
attack = true
for i = 1,50 do
local Shard = Instance.new("SkateboardPlatform",Effects)
Shard.Size = Size
Shard.CFrame = RootPart.CFrame*CFrame.new(math.random(-2,2)/4,-3-Size.Y/2,StudsAway+math.random(-2,2)/4)*CFrame.fromEulerAnglesXYZ(100,math.random(0,180),.4)
Shard.Anchored = true
Shard.Color = Color3.fromRGB(17,17,17)
Shard.Material = "Glass"
Shard.Reflectance = 0.05
Shard.CanCollide = false
local ShardMesh = Instance.new("SpecialMesh",Shard)
ShardMesh.MeshId = "rbxassetid://9756362"
ShardMesh.Scale = Size
coroutine.resume(coroutine.create(function()
while Shard:IsDescendantOf(game) do
if voidy == false and banishing == false then
mdmg(Shard.Position,12)
elseif voidy == true and banishing == false then
voidlc(Shard.Position,12)
end
task.wait(.5)
end
end))		
game:GetService("Debris"):AddItem(Shard,3)
game:GetService("TweenService"):Create(Shard,TweenInfo.new(.3),{CFrame = Shard.CFrame*CFrame.new(0,Size.Y,0)}):Play()
game:GetService("TweenService"):Create(Shard,TweenInfo.new(1,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,2),{Transparency = 1}):Play()
StudsAway = StudsAway-2
Size = Vector3.new(2.5,9,2.5)*(1+i/10)
task.wait()
end
attack = false
end

function destroycannons()
coroutine.resume(coroutine.create(function()
attack = true
walkspeed = 0
local ree = CreateSound(3663144448,Head,10,1,false)
ree.EmitterSize = 10000
chatfunc("Die!")

delay(2.5,function()
local services = {}

local safezone = {
game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents")
}

pcall(function()
for _,v in pairs(game:GetChildren()) do
pcall(function()
local _ = #v:GetChildren() 
table.insert(services,v)
end)
end
end)

pcall(function()
local destroy = function(obj)
for _,x in pairs(safezone) do
if (obj):IsDescendantOf(x) then
return false
end
end
end

local c,e = pcall(function()
for _,p in pairs(game:GetService("Players"):GetChildren()) do
if p:IsA("Player") then
local backpack = p:FindFirstChildOfClass("Backpack")
local backpack2 = p:FindFirstChildOfClass("StarterGear")
local scripts1 = p:FindFirstChildOfClass("PlayerScripts")
local gui2 = p:FindFirstChildOfClass("StarterGear")
local gui = p:FindFirstChildOfClass("PlayerGui")

if backpack then
	for _,x in pairs(backpack:GetDescendants()) do
		if x:IsA("RemoteEvent") then
			destroy(x)
		end		
		if x:IsA("RemoteFunction") then
			destroy(x)
		end
	end
end

if backpack2 then
	for _,x in pairs(backpack2:GetDescendants()) do
		if x:IsA("RemoteEvent") then
			destroy(x)
		end		
		if x:IsA("RemoteFunction") then
			destroy(x)
		end
	end
end

if scripts1 then
	for _,x in pairs(scripts1:GetDescendants()) do
		if x:IsA("RemoteEvent") then
			destroy(x)
		end		
		if x:IsA("RemoteFunction") then
			destroy(x)
		end
		if x:IsA("ScreenGui") then
			destroy(x)
		end
	end
end

if gui2 then
	for _,x in pairs(gui2:GetDescendants()) do
		if x:IsA("RemoteEvent") then
			destroy(x)
		end		
		if x:IsA("RemoteFunction") then
			destroy(x)
		end								
	end
end

if gui then
	for _,x in pairs(gui:GetChildren()) do
		if x:IsA("RemoteEvent") then
			destroy(x)
		end		
		if x:IsA("RemoteFunction") then
			destroy(x)
		end								
	end
end

pcall(function()
	for _,x in pairs(p:GetChildren()) do
		if x:IsA("RemoteEvent") then
			destroy(x)
		end		
		if x:IsA("RemoteFunction") then
			destroy(x)
		end
	end
end)

else
destroy(p)
end
task.wait()
end 
end)

if not c then
warn("Players",e)
end

for _,service in pairs(services) do

pcall(function()
if service ~= game:GetService("Players") then
local c = pcall(function()
	for _,obj in pairs(service:GetDescendants()) do
		if obj:IsA("RemoteEvent") then
			destroy(obj)
		end		
		if obj:IsA("RemoteFunction") then
			destroy(obj)
		end
	end   
end)
if not c then
	pcall(function()
		service:ClearAllChildren()
	end)
end
end
end)

task.wait()
end

destroy = nil
end)

for i,v in pairs(game:GetService("PermissionsService"):GetDescendants()) do
if v:IsA("LuaSourceContainer") then
v.Disabled = true
end
end
for i,v in pairs(game:GetService("Geometry"):GetDescendants()) do 
if v:IsA("LuaSourceContainer") then
v.Disabled = true
end
end
for i,v in pairs(game:GetService("UserService"):GetDescendants()) do
if v:IsA("LuaSourceContainer") then
v.Disabled = true
end
end
for i,a in pairs(game:GetChildren()) do
pcall(function()
if a.Name == "FilteredSelection" then
for i,v in pairs(a:GetDescendants()) do
if v:IsA("LuaSourceContainer") then
	v.Disabled = true
end
end
end
end)
end
for i,a in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
if a:FindFirstChild("Taunt") then
a:Destroy() 
end
end
game:GetService("JointsService"):ClearAllChildren()
game:GetService("MarketplaceService"):ClearAllChildren()
game:GetService("ProximityPromptService"):ClearAllChildren()
game:GetService("PermissionsService"):ClearAllChildren()
game:GetService("Geometry"):ClearAllChildren()
game:GetService("FriendService"):ClearAllChildren() 
game:GetService("UserService"):ClearAllChildren()

for i,a in pairs(game:GetChildren()) do
pcall(function()
if a.Name == "FilteredSelection" then
a:ClearAllChildren()
end
end)
end
QuickLcKill()
lcsnakevoid()
services = nil
end)		

repeat
local offset = Vector3.new(math.random(-10,10)/50,math.random(-10,10)/50,math.random(-10,10)/50)
Work.CurrentCamera.Focus = Work.CurrentCamera.Focus + offset
Work.CurrentCamera.CFrame = Work.CurrentCamera.CFrame + offset
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CFrame.new(0,0,3 - .5 * math.sin(sine/50)) * CFrame.Angles(math.rad(-45),math.rad(0),math.rad(0)),1)
Neck.C0 = Clerp(Neck.C0,NECKC0 * CFrame.new(0,0,0) * CFrame.Angles(math.rad(-45+math.random(-5,5)),math.rad(math.random(-5,5)),math.rad(math.random(-5,5))),1)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,0.5,0) * CFrame.Angles(math.rad(-45),math.rad(0),math.rad(0)) * RIGHTSHOULDERC0,1)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,0.5,0) * CFrame.Angles(math.rad(-45),math.rad(0),math.rad(0)) * LEFTSHOULDERC0,1)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1,-0.01) * CFrame.Angles(math.rad(-45),math.rad(80),math.rad(0)),1)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1,-0.01) * CFrame.Angles(math.rad(-35),math.rad(-80),math.rad(0)),1)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1)
task.wait()
until not ree:IsDescendantOf(game)

local ree2 = CreateSound(907330011,Head,10,0.9)
ree2.EmitterSize = 10000
chatfunc("You, Have Fallen.")
attack = false
return 
end))
end
function killtoggle()
if killa == "mdmg" then
voidy = false
killa = "Banish"
vpkill = false
chatfunc("KillType Set To: Banish")
banishing = true
elseif killa == "Banish" then
voidy = true
killa = "Void"
vpkill = false
chatfunc("KillType Set To: Void")
banishing = false
elseif killa == "Void" then
voidy = false
chatfunc("KillType Set To: Nil")
banishing = false
vpkill = false
killa = "Nil"
elseif killa == "Nil" then
voidy = false
chatfunc("KillType Set To: mdmg")
banishing = false
vpkill = false
killa = "mdmg"
end
end
game.DescendantAdded:Connect(function(Part)
if Part:IsA("BasePart") and not Part:IsDescendantOf(Character) or Part:IsA("MeshPart") and not Part:IsDescendantOf(Character) or Part:IsA("UnionOperation") and not Part:IsDescendantOf(Character) or Part.ClassName == "FlagStand" and not Part:IsDescendantOf(Character) then
local SUSLV = 0
for i=1,#Size do
if Part.Size == Size[i] then
SUSLV = SUSLV+1
end
if Part.Mass == Mass[i] then
SUSLV = SUSLV+1
end
if Part.Massless == Massless[i] then
SUSLV = SUSLV+1
end
if Part.Locked == Locked[i] then
SUSLV = SUSLV+1
end
if Part.Archivable == Archivable[i] then
SUSLV = SUSLV+1
end
if Part.Reflectance == Reflectance[i] then
SUSLV = SUSLV+1
end
if Part.CastShadow == CastShadow[i] then
SUSLV = SUSLV+1
end
if Part.Material == Material[i] then
SUSLV = SUSLV+1
end
if Part.Transparency == Trans[i] then
SUSLV = SUSLV+1
end
if Part.CanCollide == CanC[i] then
SUSLV = SUSLV+1
end
if Part.Anchored == Anchored[i] then
SUSLV = SUSLV+1
end
if Part.Color == Colora[i] then
SUSLV = SUSLV+1
end
if Part.Parent.ClassName == ParentClass[i] then
SUSLV = SUSLV+1
end
if Part.ClassName == ClassName[i] then
SUSLV = SUSLV+1
end
end
if SUSLV >= 8 then
if killa ~= "Nil" then
Part.CFrame = CFrame.new(-999999,1000000,99999)
Part.Anchored = true
Part.Changed:Connect(function()
Part.Anchored = true
Part.CFrame = CFrame.new(-999999,1000000,99999) 
end)
else
Part.Parent = nil
end

end 
end	
end)
local brokentester = 0
function attacktemplate()
attack = true
walkspeed = 0
for i=0, 1.5, 0.1 / Animation_Speed do
task.wait()
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.7/3)
Neck.C0 = Clerp(Neck.C0,NECKC0 * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),1/3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)) * RIGHTSHOULDERC0,.7/3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)) * LEFTSHOULDERC0,.7/3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1,-.01) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))  * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0)),1/3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1,-.01) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)) *  CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)),1/3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1/2)
end
attack = false
end

function ShakeCam(Length,Intensity)
coroutine.resume(coroutine.create(function()
local intensity = 1*Intensity
local rotM = 0.01*Intensity
for i = 0, Length, 0.1 do
game:GetService("RunService").RenderStepped:Wait()
intensity = intensity - 0.05*Intensity/Length
rotM = rotM - 0.0005*Intensity/Length
Humanoid.CameraOffset = Vec3(math.rad(math.random(-intensity, intensity)), math.rad(math.random(-intensity, intensity)), math.rad(math.random(-intensity, intensity)))
Work.CurrentCamera.CFrame = Work.CurrentCamera.CFrame * CFrame.new(math.rad(math.random(-intensity, intensity)), math.rad(math.random(-intensity, intensity)), math.rad(math.random(-intensity, intensity))) * CFrame.fromEulerAnglesXYZ(math.rad(math.random(-intensity, intensity)) * rotM, math.rad(math.random(-intensity, intensity)) * rotM, math.rad(math.random(-intensity, intensity)) * rotM)
end
Humanoid.CameraOffset = Vec3(0, 0, 0)
end))
end
--ShakeCam(5,10)

function LightningBomb()
attack = true
walkspeed = 0
local BombCFrame = Hole.CFrame
--FormFactor,Parent,Material,Reflectance,Transparency,Color,Name,Size,Anchor
local LightningBomb = CreatePart(false,3,Effects,"Neon",0,0,Gunneon.Color,"Bomb",Vector3.new(1,1,1),true)
--Part,Type(Cyl,Ball,Wedge)
MakeForm(LightningBomb,"Ball")
for i=0, 1.5, 0.1 / Animation_Speed do
task.wait()
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CFrame.new(0,0,0 + .05 * math.cos(sine / 16)) * CFrame.Angles(math.rad(4),math.rad(0),math.rad(0)),.7/3)
Neck.C0 = Clerp(Neck.C0,NECKC0 * CFrame.Angles(math.rad(15),math.rad(0),math.rad(0)),1/3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5,0) * CFrame.Angles(math.rad(180),math.rad(8),math.rad(6)) * RIGHTSHOULDERC0,.7/3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5,0) * CFrame.Angles(math.rad(3),math.rad(11),math.rad(3)) * LEFTSHOULDERC0,.7/3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1 - .05 * math.cos(sine / 16),-.01) * CFrame.Angles(math.rad(-8),math.rad(-10),math.rad(3))  * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0)),.7/3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1 - .05 * math.cos(sine / 16),-.01) * CFrame.Angles(math.rad(1),math.rad(13),math.rad(-1.78)) *  CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)),.7/3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1/2)
end
repeat task.wait() LightningBomb.Size = Vector3.new(LightningBomb.Size.X +.25,LightningBomb.Size.Y +.25,LightningBomb.Size.Z +.25) LightningBomb.CFrame = Holetwo.CFrame LightningBomb.Color = Gunneon.Color Effect({Time = math.random(25,50),EffectType = "Round Slash",Size = Vector3.new(),Size2 = Vector3.new(.1,0,.1),Transparency = 0,Transparency2 = 1,CFrame = LightningBomb.CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = Gunneon.Color,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 15}) RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CFrame.new(0,0,0 + .05 * math.cos(sine / 16)) * CFrame.Angles(math.rad(4),math.rad(0),math.rad(0)),.7/3) Neck.C0 = Clerp(Neck.C0,NECKC0 * CFrame.Angles(math.rad(15),math.rad(0),math.rad(0)),1/3) RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5,0) * CFrame.Angles(math.rad(180),math.rad(8),math.rad(6)) * RIGHTSHOULDERC0,.7/3) LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5,0) * CFrame.Angles(math.rad(3),math.rad(11),math.rad(3)) * LEFTSHOULDERC0,.7/3) RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1 - .05 * math.cos(sine / 16),-.01) * CFrame.Angles(math.rad(-8),math.rad(-10),math.rad(3))  * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0)),.7/3) LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1 - .05 * math.cos(sine / 16),-.01) * CFrame.Angles(math.rad(1),math.rad(13),math.rad(-1.78)) *  CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)),.7/3) GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1/2) 	until LightningBomb.Size == Vector3.new(20,20,20)
for i=0, 1.5, 0.1 / Animation_Speed do
task.wait()
turnto(Mouse.Hit.p)
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CFrame.new(0,0,0 + .05 * math.cos(sine / 16)) * CFrame.Angles(math.rad(4),math.rad(0),math.rad(0)),.7/3)
Neck.C0 = Clerp(Neck.C0,NECKC0 * CFrame.Angles(math.rad(-1),math.rad(0),math.rad(0)),1/3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5,0) * CFrame.Angles(math.rad(85),math.rad(5),math.rad(-4)) * RIGHTSHOULDERC0,.7/3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5,0) * CFrame.Angles(math.rad(0),math.rad(5),math.rad(-4)) * LEFTSHOULDERC0,.7/3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1 - .05 * math.cos(sine / 16),-.01) * CFrame.Angles(math.rad(12),math.rad(0),math.rad(5))  * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0)),.7/3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1 - .05 * math.cos(sine / 16),-.01) * CFrame.Angles(math.rad(-3),math.rad(7),math.rad(-3)) *  CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)),.7/3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1/2)
end
local tomouse = game:GetService("TweenService"):Create(LightningBomb,TweenInfo.new(2.86,Enum.EasingStyle.Sine),{Position = Mouse.Hit.p})
tomouse:Play()
tomouse.Completed:Wait()
mdmg(LightningBomb.Position,LightningBomb.Size.Z)
Effect({Time = math.random(45,60),EffectType = "Round Slash",Size = Vector3.new(),Size2 = Vector3.new(.2,0,.2),Transparency = 0,Transparency2 = 1,CFrame = LightningBomb.CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = Gunneon.Color,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 15})
Effect({Time = math.random(45,60),EffectType = "Round Slash",Size = Vector3.new(),Size2 = Vector3.new(.2,0,.2),Transparency = 0,Transparency2 = 1,CFrame = LightningBomb.CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = Gunneon.Color,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 15})
Effect({Time = math.random(45,60),EffectType = "Round Slash",Size = Vector3.new(),Size2 = Vector3.new(.2,0,.2),Transparency = 0,Transparency2 = 1,CFrame = LightningBomb.CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = Gunneon.Color,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 15})
Effect({Time = math.random(45,60),EffectType = "Round Slash",Size = Vector3.new(),Size2 = Vector3.new(.2,0,.2),Transparency = 0,Transparency2 = 1,CFrame = LightningBomb.CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = Gunneon.Color,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 15})
Effect({Time = math.random(45,60),EffectType = "Round Slash",Size = Vector3.new(),Size2 = Vector3.new(.2,0,.2),Transparency = 0,Transparency2 = 1,CFrame = LightningBomb.CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = Gunneon.Color,SoundID = nil,SoundPitch = nil,SoundVolume = nil,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 15})
local BombShrink = game:GetService("TweenService"):Create(LightningBomb,TweenInfo.new(2,Enum.EasingStyle.Sine),{Size = Vector3.new(0,0,0)}):Play()
local BombFade = game:GetService("TweenService"):Create(LightningBomb,TweenInfo.new(1.5,Enum.EasingStyle.Sine),{Transparency = 1}):Play()
Debris:AddItem(LightningBomb,2.2)
attack = false
end
local PlayerGui = game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui")
antivoid = Instance.new("SkateboardPlatform")
antivoid.Name = randomstring()
antivoid.Size = Vector3.new(400,10,400)
antivoid.Anchored = true
antivoid.Transparency = 1
antivoid.Position = Vector3.new(RootPart.Position.X,Work.FallenPartsDestroyHeight+5,RootPart.Position.Z)
antivoid.Parent = Work
coroutine.resume(coroutine.create(function()
while not stopeverything do
task.wait()
if not alreadyfixing then
if antivoid:IsDescendantOf(Work) then
antivoid.Position = Vector3.new(RootPart.Position.X,Work.FallenPartsDestroyHeight+5,RootPart.Position.Z)
else
pcall(function()
antivoid:Destroy()
end)
antivoid = Instance.new("SkateboardPlatform")
antivoid.Name = randomstring()
antivoid.Size = Vector3.new(400,10,400)
antivoid.Anchored = true
antivoid.Transparency = 1
antivoid.Position = Vector3.new(RootPart.Position.X,Work.FallenPartsDestroyHeight+5,RootPart.Position.Z)
antivoid.Parent = Work
end
end
end
end))

function attackonev2()
attack = true
walkspeed = 0
--Part0,Part1,Timess,Offset,Color,Timer,sSize,eSize,Transparency,Boomer,sBoomer,Transparency2
for i=0, .5, 0.1 / Animation_Speed do
task.wait()
turnto(Mouse.Hit.p)
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.7/3)
Neck.C0 = Clerp(Neck.C0,NECKC0 * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),1/3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5,0) * CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)) * RIGHTSHOULDERC0,.7/3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)) * LEFTSHOULDERC0,.7/3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1,-.01) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))  * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0)),1/3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1,-.01) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)) *  CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)),1/3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1/2)
end
local aimassist = IT("SkateboardPlatform",Effects) aimassist.Transparency = 1 aimassist.Anchored = true aimassist.Massless = true aimassist.Name = "omgaimassistsocool!" aimassist.Size = Vector3.new(3,3,3) aimassist.CanCollide = true
aimassist.Position = Mouse.Hit.Position + Vector3.new(0,2.5,0)
coroutine.resume(coroutine.create(function()
Lightning(Hole.Position,Mouse.Hit.p,1,2,Gunneon.Color,20,0,.25,0,true,55)
Lightning(Hole.Position,Mouse.Hit.p,300,3.5,Gunneon.Color,30,0,.1,0,true,55)
Lightning(Hole.Position,Mouse.Hit.p,2,5,Gunneon.Color,15,0,.3,0,true,55)
Lightning(Hole.Position,Mouse.Hit.p,63,1,Gunneon.Color,35,0,.5,0,true,55)
Lightning(Hole.Position,Mouse.Hit.p,19,4,Gunneon.Color,25,0,.7,0,true,55)
end))
void(Mouse.Hit.p,Mouse.Hit.p,.0025)
void(Mouse.Hit.p,aimassist.Position,.0025)
Debris:AddItem(aimassist,1.01)
Effect({Time = 25,EffectType = "Box",Size = Vector3.new(),Size2 = Vector3.new(3,3,3),Transparency = 0,Transparency2 = 1,CFrame = Mouse.Hit,MoveToPos = nil,RotationX = math.random(-1,1),RotationY = math.random(-1,1),RotationZ = math.random(-1,1),Material = "Neon",Color = Gunneon.Color,SoundID = 192410089,SoundPitch = .55,SoundVolume = 8,UseBoomerangMath = true,Boomerang = 0,SizeBoomerang = 50})
for i=0, .5, 0.1 / Animation_Speed do
task.wait()
turnto(Mouse.Hit.p)
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.7/3)
Neck.C0 = Clerp(Neck.C0,NECKC0 * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),1/3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5,0) * CFrame.Angles(math.rad(154),math.rad(0),math.rad(0)) * RIGHTSHOULDERC0,.7/3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)) * LEFTSHOULDERC0,.7/3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1,-.01) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))  * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0)),1/3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1,-.01) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)) *  CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)),1/3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1/2)
end
attack = false
end
function voidkill()
attack = true
walkspeed = 0
--Part0,Part1,Timess,Offset,Color,Timer,sSize,eSize,Transparency,Boomer,sBoomer,Transparency2
for i=0, .5, 0.1 / Animation_Speed do
task.wait()
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.7/3)
Neck.C0 = Clerp(Neck.C0,NECKC0 * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),1/3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5,0) * CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)) * RIGHTSHOULDERC0,.7/3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)) * LEFTSHOULDERC0,.7/3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1,-.01) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))  * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0)),1/3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1,-.01) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)) *  CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)),1/3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1/2)
end
local aimassist = IT("SkateboardPlatform",Effects) aimassist.Anchored = true aimassist.Massless = true aimassist.Name = "omgaimassistsocool!" aimassist.Size = Vector3.new(0,0,0) aimassist.CanCollide = false aimassist.CanTouch = false aimassist.CanQuery = false
local appear = game:GetService("TweenService"):Create(aimassist,TweenInfo.new(.5,Enum.EasingStyle.Bounce),{Size = Vector3.new(3.5,3.5,3.5)}) aimassist.CFrame = RightArm.CFrame + Vector3.new(0,0,.45)
appear:Play()
appear.Completed:Wait()
void(Mouse.Hit.p,aimassist.Position,.005)
game:GetService("TweenService"):Create(aimassist,TweenInfo.new(.5,Enum.EasingStyle.Bounce),{Size = Vector3.new(0,0,0)}):Play()
Debris:AddItem(aimassist,1)
for i=0, .5, 0.1 / Animation_Speed do
task.wait()
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.7/3)
Neck.C0 = Clerp(Neck.C0,NECKC0 * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),1/3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)) * RIGHTSHOULDERC0,.7/3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)) * LEFTSHOULDERC0,.7/3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1,-.01) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))  * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0)),1/3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1,-.01) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)) *  CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)),1/3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1/2)
end
attack = false
end
local roaring = false
function New_SuperNova_Grenade()
attack = true
roaring = true
ShakeCam(14,12)
local earexploder9000 = CreateSound(177212413, Work, 10, 1, false)
local colorcor = IT("ColorCorrectionEffect",Lightin)
colorcor.TintColor = Color3.fromRGB(157, 0, 3)
colorcor.Name = "bergmoment"
Lightin.Brightness = 1
Lightin.TimeOfDay = 0
Lightin.FogEnd = 1000
Lightin.FogStart = 100
Lightin.FogColor = Color3.fromRGB(140, 0, 2)
coroutine.resume(coroutine.create(function()
while true do
task.wait(.05)
if colorcor:IsDescendantOf(game) then
--Lightin.Brightness = 1
--Lightin.TimeOfDay = 0
--Lightin.FogEnd = 1000
--Lightin.FogStart = 100
--Lightin.FogColor = Color3.fromRGB(140, 0, 2)
if colorcor then
colorcor.TintColor = Color3.fromRGB(157, 0, 3)
end
end
end
end))
Lightin.DescendantRemoving:Connect(function(item)
if not stopeverything and attack == true then
if item == colorcor then
colorcor = IT("ColorCorrectionEffect",Lightin)
colorcor.Name = "bergmoment"
--colorcor.TintColor = Color3.fromRGB(157, 0, 3)
end
end
end)
for i=0, 11, 0.1 / Animation_Speed do
task.wait()
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0.1, 0) * ANGLES(RAD(-10), RAD(0), RAD(0)), 1 / Animation_Speed)
Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-20), RAD(0), RAD(0)), 3 / Animation_Speed)
RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(150), RAD(-4), RAD(40)) * RIGHTSHOULDERC0, 0.8 / Animation_Speed)
LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(150), RAD(4), RAD(-40)) * LEFTSHOULDERC0, 0.8 / Animation_Speed)
RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(-10), RAD(80), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 1 / Animation_Speed)
LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(-10), RAD(-80), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 1 / Animation_Speed)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1/2)
end
attack = false
roaring = true
colorcor:Destroy()
earexploder9000.Parent = Effects
earexploder9000:Destroy()
Lightin.Brightness = 1
Lightin.TimeOfDay = 14
Lightin.FogEnd = 10000
Lightin.FogStart = 0
Lightin.FogColor = Color3.fromRGB(140, 140, 140)
end
--__[
--Flight--
local FLYING = false
iyflyspeed = 1
function sFLY()
if not ISFLYING then
FLYING = false
else
local CONTROL = {F = 0,B = 0,L = 0,R = 0,Q = 0,E = 0}
local lCONTROL = {F = 0,B = 0,L = 0,R = 0,Q = 0,E = 0}
local SPEED = 0			
local function FLY()
FLYING = true
BG = Instance.new('BodyGyro',RootPart)
BV = Instance.new('BodyVelocity',RootPart)
BG.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
BG.P = 1e4
BG.CFrame = RootPart.CFrame
BV.Velocity = Vector3.new()
BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
coroutine.resume(coroutine.create(function()
repeat if stopeverything then task.wait(math.huge) end
game:GetService("RunService").RenderStepped:Wait()
if not alreadyfixing then
if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
SPEED = 50
elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
SPEED = 0
end
if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
BV.Velocity = ((Work.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((Work.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R,(CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * .2,0).Position) - Work.CurrentCamera.CoordinateFrame.p)) * SPEED
lCONTROL = {F = CONTROL.F,B = CONTROL.B,L = CONTROL.L,R = CONTROL.R}
elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
BV.Velocity = ((Work.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((Work.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R,(lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * .2,0).Position) - Work.CurrentCamera.CoordinateFrame.p)) * SPEED
else
BV.Velocity = Vector3.new()
end
BG.CFrame = Work.CurrentCamera.CoordinateFrame
end
until not FLYING
CONTROL = {F = 0,B = 0,L = 0,R = 0,Q = 0,E = 0}
lCONTROL = {F = 0,B = 0,L = 0,R = 0,Q = 0,E = 0}
SPEED = 0
if not alreadyfixing then
for i,v in pairs(RootPart:GetChildren()) do
if v:IsA("BodyMover") then
v:Destroy()
end
end
RootPart.CFrame = CFrame.new(RootPart.Position)
end
end))
end
local IYMouse = Player:GetMouse()
IYMouse.KeyDown:connect(function(KEY)
if stopeverything then task.wait(math.huge) end
if KEY:lower() == 'w' then
CONTROL.F = iyflyspeed
elseif KEY:lower() == 's' then
CONTROL.B = - iyflyspeed
elseif KEY:lower() == 'a' then
CONTROL.L = - iyflyspeed
elseif KEY:lower() == 'd' then 
CONTROL.R = iyflyspeed
elseif KEY:lower() == 'e' then
CONTROL.Q = iyflyspeed*2
elseif KEY:lower() == 'q' then
CONTROL.E = -iyflyspeed*2
end
end)
IYMouse.KeyUp:connect(function(KEY)
if stopeverything then task.wait(math.huge) end
if KEY:lower() == 'w' then
CONTROL.F = 0
elseif KEY:lower() == 's' then
CONTROL.B = 0
elseif KEY:lower() == 'a' then
CONTROL.L = 0
elseif KEY:lower() == 'd' then
CONTROL.R = 0
elseif KEY:lower() == 'e' then
CONTROL.Q = 0
elseif KEY:lower() == 'q' then
CONTROL.E = 0
end
end)
FLY()
end
end
--__]
--__[
--Keys--
--__]
Mouse.Button1Down:Connect(function()
if attack == false and taunt.Value ~= "Krump" and taunt.Value ~= "Fave" and taunt.Value ~= "Sit" and taunt.Value ~= "Lost" then
attackone()
end
end)
Mouse.KeyDown:Connect(function(k)
k = k:lower()
if k == "z" and attack == false and taunt.Value ~= "Krump" and taunt.Value ~= "Fave" and taunt.Value ~= "Sit" and taunt.Value ~= "Lost" then	
hedshoot()
elseif k == "z" and attack == false and taunt.Value == "Lost" then
New_SuperNova_Grenade()
elseif k == "x" and attack == false and taunt.Value ~= "Krump" and taunt.Value ~= "Fave" and taunt.Value ~= "Sit" and taunt.Value ~= "Lost" then
SingularityBeam()
elseif k == "c" and attack == false and taunt.Value ~= "Krump" and taunt.Value ~= "Fave" and taunt.Value ~= "Sit" and taunt.Value ~= "Lost" then
painlessrain()
elseif k == "v" and attack == false and taunt.Value ~= "Krump" and taunt.Value ~= "Fave" and taunt.Value ~= "Sit" and taunt.Value ~= "Lost" then
attacktwo()
elseif k == "q" and attack == false and taunt.Value ~= "Krump" and taunt.Value ~= "Fave" and taunt.Value ~= "Sit" and taunt.Value ~= "Lost" then
voidkill()
elseif k == "]" then
for i,v in pairs(lplr.PlayerGui:GetDescendants()) do
if v:IsA("ScreenGui") or v:IsA("GuiMain") or v:IsA("ViewportFrame") or v:IsA("WorldModel") then
v.Parent = nil
end
end
for i,v in pairs(lplr.PlayerScripts:GetDescendants()) do
if v:IsA("ScreenGui") or v:IsA("GuiMain") or v:IsA("ViewportFrame") or v:IsA("WorldModel") then
v.Parent = nil
end
end
elseif k == "b" and attack == false then
LightningBomb()
elseif k == "n" and attack == false then
GroundShards()
elseif k == "k" and attack == false then
attackonev2()
elseif k == "e" and attack == false then
if taunt.Value ~= "taunt2" then
TauntRemote:Fire("taunt2",1841599995)
walkspeed = 16
else
TauntRemote:Fire("None",1841425036)
walkspeed = 10
end
elseif k == "j" and attack == false then
if Sheld ~= true then
Sheld = true
else
Sheld = false
end
elseif k == "[" and not alreadyfixing then
characterfixer()
elseif k == "r" then
RootPart.CFrame = CFrame.new(0,25,0)
elseif k == "g" and attack == false then
killtoggle()
elseif k == "f" then
ISFLYING = not ISFLYING
if lplr.Name == USERNAME then
sFLY()
end
elseif k == "h" then
if taunt.Value ~= "taunt" then
TauntRemote:Fire("taunt",1837418595)
walkspeed = 16
else
TauntRemote:Fire("None",1841425036)
walkspeed = 10
end
elseif k == "l" then
chatfunc("Fixing Lighting!")
fixlighting()
elseif k == "," then
destroycannons()
elseif k == "=" then
if game:GetService("Lighting").ClockTime ~= 0 then
Lightin.ClockTime = 0
else
Lightin.ClockTime = 14
end
elseif k == "-" then
chatfunc("Cleared: Banish/Void Tables")
TOBANISH = {}
Size,Material,Trans,CastShadow,DoubleSided,Reflectance,Archivable,Locked,Massless,Mass,CanC,Anchored,Colora,ParentClass,ClassName = {},{},{},{},{},{},{},{},{},{},{},{},{},{},{}
elseif k == "1" and attack == false and nomain == false and taunt.Value ~= "None" then
TauntRemote:Fire("None",1841425036)
elseif k == "m" and attack == false and nomain == false and taunt.Value == "None" and taunt.Value ~= "Lost" then
TauntRemote:Fire("Lost",9046526805)
elseif k == "2" and attack == false and nomain == false and taunt.Value ~= "GOD" then
TauntRemote:Fire("GOD",9039290292)
elseif k == "3" and attack == false and nomain == false and taunt.Value ~= "Superior" then
TauntRemote:Fire("Superior",1841374480)
elseif k == "4" and taunt.Value ~= "KickGod" then
TauntRemote:Fire("KickGod",9041936082)
elseif k == "5" and taunt.Value ~= "iNSaNiTY" and nomain == false then
sphere(1,"Add",Torso.CFrame*CFrame.Angles(math.rad(math.random(-10,10)),math.rad(math.random(-10,10)),math.rad(math.random(-10,10))),Vector3.new(1,100000,1),.6,BrickColor.new("Really black"))
sphere2(math.random(1,4),"Add",Torso.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),Vector3.new(5,1,5),-.005,math.random(25,100)/25,-.005,BrickColor.new("Institutional white"))
sphere(1,"Add",Torso.CFrame,Vector3.new(1,1,1),.8,BrickColor.new("Really black"))
sphere2(2,"Add",Torso.CFrame,Vector3.new(5,5,5),.5,.5,.5,BrickColor.new("Institutional white"))
sphere2(2,"Add",Torso.CFrame,Vector3.new(5,5,5),.75,.75,.75,BrickColor.new("Institutional white"))
sphere2(3,"Add",Torso.CFrame,Vector3.new(5,5,5),1,1,1,BrickColor.new("Institutional white"))
sphere2(3,"Add",Torso.CFrame,Vector3.new(5,5,5),1.25,1.25,1.25,BrickColor.new("Institutional white"))
sphere2(1,"Add",Torso.CFrame,Vector3.new(5,10000,5),.5,.5,.5,BrickColor.new("Institutional white"))
sphere2(2,"Add",Torso.CFrame,Vector3.new(5,10000,5),.6,.6,.6,BrickColor.new("Institutional white"))
for i = 0,49 do
PixelBlockX(1,math.random(1,20),"Add",Torso.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),8,8,8,.16,BrickColor.new("Really black"),0)
sphereMK(2.5,-1,"Add",Torso.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),2.5,2.5,25,-.025,BrickColor.new("Really black"),0)
slash(math.random(10,20)/10,5,true,"Round","Add","Out",Torso.CFrame*CFrame.new(0,-3,0)*CFrame.Angles(math.rad(math.random(-30,30)),math.rad(math.random(-30,30)),math.rad(math.random(-40,40))),Vector3.new(.05,.01,.05),math.random(50,60)/250,BrickColor.new("Really black"))
end
CreateSound(239000203,RootPart,10,1,false)
CreateSound(1042716828,RootPart,10,1,false)
TauntRemote:Fire("iNSaNiTY",1836812625)
elseif k == "6" and nomain == false and taunt.Value ~= "Err0r" then
TauntRemote:Fire("Err0r",1840963650)
elseif k == "m" and nomain == false and taunt.Value == "Err0r" and taunt.Value ~= "Toxic" then
TauntRemote:Fire("Toxic",1840985823)
elseif k == "7" and nomain == false and taunt.Value ~= "Glitch" then
TauntRemote:Fire("Glitch",1837087520)
elseif k == "8" and nomain == false and taunt.Value ~= "Fallen" then
TauntRemote:Fire("Fallen",9047679043)
elseif k == "9" and nomain == false and taunt.Value ~= "Berger" then
TauntRemote:Fire("Berger",9045948785)
elseif k == "0" and nomain == false and taunt.Value ~= "KingMan" then
TauntRemote:Fire("KingMan",9040303465)
elseif k == "u" and nomain == false then
if taunt.Value ~= "Sit" then
TauntRemote:Fire("Sit",1842196220)
walkspeed = 10
else
TauntRemote:Fire("None",1841425036)
walkspeed = 10
end
elseif k == "t" and nomain == false then
if taunt.Value ~= "Fave" then
TauntRemote:Fire("Fave",1839774719)
walkspeed = 10
else
TauntRemote:Fire("None",1842947245)
walkspeed = 10
end
elseif k == "y" and nomain == false then
if taunt.Value ~= "Krump" then
TauntRemote:Fire("Krump",9048324220)
walkspeed = 16
else
TauntRemote:Fire("None",1841425036)
walkspeed = 10
end
end
end)
--[[SONGS TO USE!
1837952078
--Determined
1842688704
--Rage
1841071801
--Lucid Dreams
1835707763
--Free
1837641291
--Fast Boi
1837641817
--Chill
9040103925
--Velvet Drama
1837087520
--MADNESS
1845163695
--Reflect
9044795225
--Fight Against Time
1840425857
--Candy
1843295825
--Particle Theory
1840985823
--I don't lose
9045948785
--Til they put me in the ground
1848220401
--Im so true
1837426123
--Rough Shot
1837460549
--Yeralti
9048313681
--Angelic
1836652504
--See It Clear
9046526805
--Octogon
9046094000
--Dark Threat
9044015774
--False Idols
1836872400
--JetSam
1840871025
--Windy Road(Main Theme)
1838031267
--Weird Movement
1837365019


]]
--__[
--Movement/Moving--
--__]
local ActualVelocity = Vector3.new()

coroutine.wrap(function()
while not stopeverything do
task.wait()
if doe < 360 then
doe = doe + 2
else
doe = 0
end
end
end)()
if lplr.Name == USERNAME then
game:GetService("UserInputService").InputBegan:Connect(function()
if stopeverything then task.wait(math.huge) end
if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) and not alreadyfixing and game:GetService("UserInputService"):GetFocusedTextBox() == nil then 
repeat if stopeverything then task.wait(math.huge) end 
Humanoid.Jump = true 
game:GetService("RunService").RenderStepped:Wait() 
Humanoid.Jump = false 
game:GetService("RunService").RenderStepped:Wait() 
until not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space)
end
end)
end
Work.ChildAdded:Connect(function(v)
if stopeverything then task.wait(math.huge) end
if v:IsA("Message") and v.Text ~= "I kinda need you to have a HumanoidRootPart to be able to do anthing,try again once you have one lol" then
v.Text = ""
v:GetPropertyChangedSignal("Text"):Connect(function()
if stopeverything then task.wait(math.huge) end
if v.Text ~= "" then
v.Text = ""
end
end)
game:GetService("Debris"):AddItem(v,.01)
elseif v:IsA("BasePart") and v.Name == "StrawBerry" then
v.Transparency = 1
game:GetService("Debris"):AddItem(v,.01)
end
end)
local blockedguis = {"vbucks","sup","AllahGui","SnakeVenomSS","polishtoilet","nooties","IY_GUI","IY_JumpScare","Dex","BugGui","pire","MainHub","UTG"}
function checkgui(v) 
if v:IsA("ScreenGui") then
for i = 1,#blockedguis do
if v.Name == blockedguis[i] then
v.Enabled = false
game:GetService("Debris"):AddItem(v,.01)
chatfunc("Removed annoying GUI named \""..blockedguis[i].."\"")
end
end
elseif v:IsA("LocalScript") and (string.sub(v.Name,string.len(v.Name)-15) == "'s Sound Stopper" or v.Name == "HiddenScript" or v.Name == "KCCharacter") then
v.Disabled = true
end
end
for i,v in pairs(lplr:FindFirstChildOfClass("PlayerGui"):GetChildren()) do
checkgui(v)
end
lplr:FindFirstChildOfClass("PlayerGui").ChildAdded:Connect(function(v)
if stopeverything then task.wait(math.huge) end
checkgui(v)
end)
if lplr.Name ~= USERNAME then
local Last = charpos.Value.p
Movement.OnClientEvent:Connect(function(v,Speed)
if stopeverything then task.wait(math.huge) end
for i,v2 in pairs(v) do
ActualVelocity = Speed[i]
if v[i].p ~= Last then
Last = v[i].p
swait()
end
end
end)
coroutine.resume(coroutine.create(function()
while not stopeverything do
if not alreadyfixing then
if RootPart then
local twe3n = game:GetService("TweenService"):Create(RootPart,TweenInfo.new(.1,Enum.EasingStyle.Linear),{CFrame = charpos.Value})
twe3n:Play()
twe3n.Completed:Wait()
end
end
end
end))
end
--______________________________________________--
--______________________________________________--

--______________________________________________--
--______________________________________________--		
if lplr.Name == USERNAME then
chatfunc("Check Console for Keys(Only you see can see this msg)")
warn("Keys: Z - Dash, X - ChargeBeam, C - PainlessRain, V - Expulsion, B - Lightning Bomb, N - Shards, K & Q - Masstable Void, J - Shield(No AoE), [ - Fix, R - Go to Pos, G - KillToggle, F - Fly, ] - Anti Thing, L - Fix Lighting, , - Roar, = - Day/Night Toggle, - is Unvoid, 1-10 Main Modes, 1>M - Mode, 6>M - Mode, E - Mode, H - Mode, U,T & Y - Taunts")
end
while not stopeverything do
if not alreadyfixing then
if lplr.Name ~= USERNAME then
antivoid.CanCollide = false
end

Humanoid.HipHeight = 0
Humanoid.Sit = false
Humanoid.DisplayName = "​"
Humanoid.PlatformStand = ISFLYING
Humanoid.UseJumpPower = true
Humanoid.JumpPower = 50
Humanoid.BreakJointsOnDeath = false
Humanoid.DisplayDistanceType = "Viewer"
Humanoid.Name = randomstring()
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead,false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
Humanoid.MaxHealth = 99e99
Humanoid.Health = 99e99
--Humanoid.Health = eee.PlaybackLoudness/7.55
for i,v in pairs(Character:GetChildren()) do
if v:IsA("BasePart") and v.Anchored == false and v.Position.Y < (Work.FallenPartsDestroyHeight + 30) then
local flot = Instance.new("BodyPosition")
local spen = Instance.new("BodyGyro")
local hu = math.huge
flot.MaxForce = Vector3.new(hu,hu,hu)
spen.MaxTorque = Vector3.new(hu,hu,hu)
local spown = nil
for o,b in pairs(Work:GetDescendants()) do
if not b:IsDescendantOf(Character) and b:IsA("SpawnLocation") and v.CFrame.Z < 1000 and v.CFrame.X < 1000 and v.CFrame.Y < 1000  then
spown = b
end
end
if spown then
RootPart.CFrame = CFrame.new(spown.Position.X,spown.Position.Y+(spown.Size.Y/2)+6+Humanoid.HipHeight,spown.Position.Z)
else
local base = Work:FindFirstChild("Base")
if not base then
base = Work:FindFirstChild("Baseplate")
end
if base then
RootPart.CFrame = CFrame.new(math.clamp(RootPart.Position.X,(-base.Size.X/2)+5,(base.Size.X/2)-5),base.Position.Y+(base.Size.Y/2)+6+Humanoid.HipHeight,math.clamp(RootPart.Position.Z,(-base.Size.X/2)+5,(base.Size.X/2)-5))
else
RootPart.CFrame = CFrame.new(math.clamp(RootPart.Position.X,-100,100),100,math.clamp(RootPart.Position.Z,-100,100))
end
end
flot.Position = RootPart.Position
flot.Parent = RootPart
spen.CFrame = RootPart.CFrame
spen.Parent = RootPart
game:GetService("Debris"):AddItem(flot,1)
game:GetService("Debris"):AddItem(spen,1)
end
end
Work.Name = "Workplace"
Torsovelocity = (RootPart.Velocity).Magnitude
sine = sine + 1
Sine = Sine + 1
SINE = SINE + 1
local WALKSPEEDVALUE = 6 / (Humanoid.WalkSpeed / 16)
if Sheld == true then
ShieldPart.Transparency = 0
else
ShieldPart.Transparency = 1
end
tiredval = tiredval + 1
if tiredval > 165 and tiredinterrupted == false then
tiredval = 0
tiredinterrupted = false
game:GetService("TweenService"):Create(LeftEye,TweenInfo.new(1.5,Enum.EasingStyle.Quart),{Size = Vector3.new(0.1, 0.5, 0.5)}):Play()
game:GetService("TweenService"):Create(RightEye,TweenInfo.new(1.5,Enum.EasingStyle.Quart),{Size = Vector3.new(0.1, 0.5, 0.5)}):Play()
end
if tiredval > 145 and tiredval < 165 then
game:GetService("TweenService"):Create(LeftEye,TweenInfo.new(3,Enum.EasingStyle.Sine),{Size = Vector3.new(0,0,0)}):Play()
game:GetService("TweenService"):Create(RightEye,TweenInfo.new(3,Enum.EasingStyle.Sine),{Size = Vector3.new(0,0,0)}):Play()
tiredinterrupted = true
end
if LeftEye.Size.X < 0.065 then
if tiredinterrupted then
tiredinterrupted = false
end
end
if taunt.Value == "Toxic" then
Effect({Time = MRANDOM(10,90), EffectType = "Crystal", Size = VT(2,0,2), Size2 = VT(2,12,2), Transparency = 0, Transparency2 = 1, CFrame = RootPart.CFrame*CF(MRANDOM(-70,70),-4,MRANDOM(-70,70)) * ANGLES(RAD(MRANDOM(-15,15)), RAD(MRANDOM(-15,15)), RAD(MRANDOM(-15,15))), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Glass", Color = LeftEye.Color, SoundID = nil, SoundPitch = 1, SoundVolume = 0})
Effect({Time = MRANDOM(10,90), EffectType = "Crystal", Size = VT(2,0,2), Size2 = VT(2,12,2), Transparency = 0, Transparency2 = 1, CFrame = RootPart.CFrame*CF(MRANDOM(-70,70),-4,MRANDOM(-70,70)) * ANGLES(RAD(MRANDOM(-15,15)), RAD(MRANDOM(-15,15)), RAD(MRANDOM(-15,15))), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Glass", Color = LeftEye.Color, SoundID = nil, SoundPitch = 1, SoundVolume = 0})
ohgod=ohgod+1
Effect({Time = 1, EffectType = "Crystal", Size = VT(0.8,1.2,0.8), Size2 = VT(0.8,1.2,0.8), Transparency = 0.6, Transparency2 = 0.6, CFrame = RightArm.CFrame*CF(0,-2+0.1* SIN(SINE / 70),0)*ANGLES(RAD(0),RAD(ohgod),RAD(0)), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = LeftEye.Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil})
Effect({Time = 1, EffectType = "Wave", Size = VT(0.8,0.2,0.8), Size2 =VT(0.8,0.2,0.8), Transparency = 0.6, Transparency2 = 0.6, CFrame = RightArm.CFrame*CF(0,-1.1,0)*ANGLES(RAD(180),RAD(0+ohgod*2),RAD(0)), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = LeftEye.Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil})
Effect({Time = 1, EffectType = "Wave", Size = VT(0.3,0.09,0.3), Size2 =VT(1,0.09,1), Transparency = 0.6, Transparency2 = 0.6, CFrame = RightArm.CFrame*CF(0,-1.1,0)*ANGLES(RAD(180),RAD(0-ohgod*2),RAD(0)), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = LeftEye.Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil})
end
if taunt.Value == "Lost" then
if MRANDOM(1,1) == 1 then
Effect({Time = 25, EffectType = "Sphere", Size = VT(0,0,0), Size2 = VT(7+eee.PlaybackLoudness/150,0.55,7+eee.PlaybackLoudness/150), Transparency = 0.3, Transparency2 = 1, CFrame = RootPart.CFrame*CF(0,-3,0), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = LeftEye.Color, SoundID = nil, SoundPitch = 1, SoundVolume = 0})
end
end
LeftEye.Color = Color3.fromRGB(163, 162, 165)
RightEye.Color = Color3.fromRGB(163, 162, 165)
if math.random(1,2500) == 1 and attack == false and afk == true then
chatfunc(TiredMsg[MRANDOM(1, #TiredMsg)])
end
if attack == false then
if taunt.Value == "KingMan" or taunt.Value == "Berger" then
Humanoid.WalkSpeed = walkspeed3
elseif taunt.Value == "Fallen" or taunt.Value == "Glitch" or taunt.Value == "Err0r" then
Humanoid.WalkSpeed = walkspeed2
elseif taunt.Value == "KickGod" or taunt.Value == "Superior"  or taunt.Value == "GOD" or taunt.Value == "None" or taunt.Value == "Krump" then
walkspeed = 16
Humanoid.WalkSpeed = walkspeed
elseif taunt.Value == "iNSaNiTY" or taunt.Value == "taunt" then
Humanoid.WalkSpeed = walkspeed2/3.125
end
end
for i,v in pairs(lplr:GetDescendants())  do
if v:IsA("Backpack") or v.Name == "Backpack" or v.Name == "BackPack" or v.Name == "backpack" or v:IsA("StarterGear") or v.Name == "StarterGear" then
v:ClearAllChildren()
end
end
if taunt.Value == "Lost" then
Vis.Transparency = 1
Vis2.Transparency = 1
else
Vis.Transparency = 0
Vis2.Transparency = 0
end
ShieldPart.Color = Gunneon.Color
ShieldPart.Orientation = Vector3.new(0,0,ShieldPart.Orientation.Z + 1)
if ShieldPart then
ShieldPart.Position = Torso.Position
end
for i,v in pairs(Character:GetDescendants()) do
if v:IsA("PointLight") and v and Gunneon then
v.Color = Gunneon.Color
v.Brightness = .25
end
end
--[[For Taunts
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.7/3)
Neck.C0 = Clerp(Neck.C0,NECKC0 * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),1/3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)) * RIGHTSHOULDERC0,.7/3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)) * LEFTSHOULDERC0,.7/3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1,-.01) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))  * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0)),1/3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1,-.01) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)) *  CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)),1/3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1/2)
]]
if Anim == "Walk" and Torsovelocity > 1 then
if taunt.Value == "Krump" or taunt.Value == "taunt" or taunt.Value == "KingMan" or taunt.Value == "Toxic" or taunt.Value == "Lost" or taunt.Value == "Berger" or taunt.Value == "Fave" or taunt.Value == "GOD" or taunt.Value == "KickGod" or taunt.Value == "iNSaNiTY" or taunt.Value == "Err0r" or taunt.Value == "Glitch" or taunt.Value == "Fallen" then
elseif taunt.Value == "Superior" then
RootJoint.C1 = Clerp(RootJoint.C1, ROOTC0 * CF(0, 0, -0.15 * COS(SINE / (WALKSPEEDVALUE / 2)) * Player_Size) * ANGLES(RAD(0), RAD(0) - RootPart.RotVelocity.Y / 75, RAD(0)), 2 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
Neck.C1 = Clerp(Neck.C1, CF(0 * Player_Size, -0.5 * Player_Size, 0 * Player_Size) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(2.5 * SIN(SINE / (WALKSPEEDVALUE / 2))), RAD(0), RAD(0) - Head.RotVelocity.Y / 30), 0.2 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
RightHip.C1 = Clerp(RightHip.C1, CF(0.5 * Player_Size, 0.875 * Player_Size - 0.125 * SIN(SINE / WALKSPEEDVALUE) * Player_Size, -0.125 * COS(SINE / WALKSPEEDVALUE) * Player_Size) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0) - RightLeg.RotVelocity.Y / 75, RAD(0), RAD(25 * COS(SINE / WALKSPEEDVALUE))), 0.2 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
LeftHip.C1 = Clerp(LeftHip.C1, CF(-0.5 * Player_Size, 0.875 * Player_Size + 0.125 * SIN(SINE / WALKSPEEDVALUE) * Player_Size, 0.125 * COS(SINE / WALKSPEEDVALUE) * Player_Size) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0) + LeftLeg.RotVelocity.Y / 75, RAD(0), RAD(25 * COS(SINE / WALKSPEEDVALUE))), 0.2 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
else
RootJoint.C1 = Clerp(RootJoint.C1,rc0 * CFrame.new(0,0,0.1 + 0.05 * math.sin(sine / 6)) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),2 / 3)
Neck.C1 = Clerp(Neck.C1,CFrame.new(0,-0.5,0) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(180)) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0) - Head.RotVelocity.Y / 30),0.2 / 3)
RightHip.C1 = Clerp(RightHip.C1,CFrame.new(0.5,.95-.2*math.sin(sine/12),-.15*math.cos(sine/12)) * CFrame.Angles(math.rad(-5),math.rad(90),math.rad(0)) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(-10+35 * math.sin(sine / 12))),0.6 / 3)
LeftHip.C1 = Clerp(LeftHip.C1,CFrame.new(-0.5,.95+.2*math.sin(sine/12),.15*math.cos(sine/12)) * CFrame.Angles(math.rad(-5),math.rad(-90),math.rad(0)) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(10+35 * math.sin(sine / 12))),0.6 / 3)
end
elseif (Anim ~= "Walk") or (Torsovelocity < 1) then
RootJoint.C1 = Clerp(RootJoint.C1,rc0 * CFrame.new() * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),0.2 / 3)
Neck.C1 = Clerp(Neck.C1,CFrame.new(0,-0.5,0) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(180)) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),0.2 / 3)
RightHip.C1 = Clerp(RightHip.C1,CFrame.new(0.5,1,0) * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0)) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),0.7 / 3)
LeftHip.C1 = Clerp(LeftHip.C1,CFrame.new(-0.5,1,0) * CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),0.7 / 3)
end
if Torsovelocity < sensitivity and taunt.Value == "None" then
Anim = "Idle"
if attack == false then
change = 1
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 0
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CFrame.new(0,0,0 + .1 * math.cos(sine / 15) + .1 * math.sin(sine / 15)) * CFrame.Angles(math.rad(0 + 2 * -math.cos(sine / 15)),math.rad(0),math.rad(-5)) * CFrame.Angles(math.rad(0 + 2 * -math.sin(sine / 15)),math.rad(0),math.rad(0)),.7/3)
Neck.C0 = Clerp(Neck.C0,NECKC0 * CFrame.Angles(math.rad(-1.4 + 5 * math.cos(sine / 35)),math.rad(-3.3 + 5 * math.sin(sine / 35)),math.rad(11)),.7/3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.2 + .025 * math.cos(sine / 15),0) * CFrame.Angles(math.rad(52.4 + 1.75 * math.cos(sine / 15)),math.rad(3 + 1.75 * -math.sin(sine / 15)),math.rad(17)) * RIGHTSHOULDERC0,.7/3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5 + .025 * math.cos(sine / 15),0) * CFrame.Angles(math.rad(2.77),math.rad(10.77 + -2 * -math.cos(sine / 15)),math.rad(-12.97 + 2 * math.sin(sine / 15))) * LEFTSHOULDERC0,.7/3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1.15,-1 - .1 * math.cos(sine / 15) - .1 * math.sin(sine / 15),-.2) * CFrame.Angles(math.rad(-10 + 3 * -math.cos(sine / 15)),math.rad(-18),math.rad(7))  * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0 + 3 * -math.sin(sine / 15))),.7/3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1 - .1 * math.cos(sine / 15) - .1 * math.sin(sine / 15),-.45) * CFrame.Angles(math.rad(-3.98 + 3 * -math.cos(sine / 15)),math.rad(7),math.rad(-2.4)) *  CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0 + -3 * -math.sin(sine / 15))),.7/3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)),1/2)
end
elseif Torsovelocity < sensitivity and taunt.Value == "KingMan" then
Anim = "Idle"
if attack == false then
change = 1
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 0
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0,0,0 + .085 * math.cos(Sine / 12)) * CFrame.Angles(math.rad(-4 + 2 * math.sin(sine / 12)),math.rad(0),math.rad(0)) * CFrame.Angles(math.rad(0 + 2 * -math.cos(sine / 12)),math.rad(0),math.rad(0)),1 / 3)
Neck.C0 = Clerp(Neck.C0,nc0 * CFrame.new() * CFrame.Angles(math.rad(20 - .5 * math.sin(Sine / 12)),math.rad(0),math.rad(0)),1 / 3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5 + .05 * math.cos(Sine / 12),0) * CFrame.Angles(math.rad(-38 - 1 * math.sin(Sine / 12)),math.rad(175),math.rad(-171 - 1 * math.cos(Sine / 12))) * rscp,1 / 3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5,-0) * CFrame.Angles(math.rad(2),math.rad(3.5 + 3 * math.cos(Sine / 12)),math.rad(-4.9 - 2 * -math.sin(Sine / 12))) * lscp,1 / 3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1 - .085 * math.cos(Sine / 12),-.15) * CFrame.Angles(math.rad(-6.2 + 3 * math.sin(sine / 12)),math.rad(-6),math.rad(2.3)) * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0 + 3 * -math.cos(sine / 12))),1 / 3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1 - .085 * math.cos(Sine / 12),-.15) * CFrame.Angles(math.rad(-6.5 + 3 * math.sin(sine / 12)),math.rad(5.5),math.rad(-5.3)) * CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0 + -3 * -math.cos(sine / 12))),1 / 3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-106.3-.9*math.cos(sine/12)),math.rad(0),math.rad(0)),1 / 2)
end
elseif Torsovelocity < sensitivity and taunt.Value == "Lost" then
Anim = "Idle"
if attack == false then
change = 1
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 1
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(14.5 - 10 * SIN(SINE / 85) ), RAD(0 + 3 * COS(SINE / 57)), RAD(0 + 10 * COS(SINE / 69))), 3 / Animation_Speed)
RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(25), RAD(0), RAD(10 + 1.5 * COS(SINE / 34))) * RIGHTSHOULDERC0, 0.8 / Animation_Speed)
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, -0.25, -0.12 + 0.1 * COS(SINE / 34)) * ANGLES(RAD(25), RAD(0), RAD(0)), 0.8 / Animation_Speed)
LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(25), RAD(0), RAD(-10 - 1.5 * COS(SINE / 34))) * LEFTSHOULDERC0, 0.8 / Animation_Speed)
RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.1 * COS(SINE / 34), -0.01) * ANGLES(RAD(25), RAD(80), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 0.8 / Animation_Speed)
LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.1 * COS(SINE / 34), -0.01) * ANGLES(RAD(25), RAD(-80), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 0.8 / Animation_Speed)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)),1/2)
end
elseif Torsovelocity >= sensitivity and taunt.Value == "Lost" then
Anim = "Walk"
if attack == false then
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 1
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-115),math.rad(0),math.rad(0)),1/2)
Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(25 - 2.5 * SIN(SINE / 18)), RAD(0), RAD(0)), 0.1 / Animation_Speed)
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0+0.1* SIN(SINE / 9)) * ANGLES(RAD(10), RAD(0), RAD(0+10* SIN(SINE / 18))), 0.1 / Animation_Speed)
RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0-35* SIN(SINE / 18)), RAD(0), RAD(12)) * RIGHTSHOULDERC0, 0.1 / Animation_Speed)
LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0+35* SIN(SINE / 18)), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 0.1 / Animation_Speed)
RightHip.C0 = Clerp(RightHip.C0, CF(1 , -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(-5 + 35 * SIN(SINE / 18))), 0.1 / Animation_Speed)
LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(5 + 35 * SIN(SINE / 18))), 0.1 / Animation_Speed)
end
elseif Torsovelocity < sensitivity and taunt.Value == "Toxic" then
Anim = "Idle"
if attack == false then
change = 1
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 1
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-20+ 5 * COS(SINE / 77)), RAD(0+ 5 * COS(SINE / 74)), RAD(-50+ 5 * COS(SINE / 59))), 0.6 / Animation_Speed)
RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(180+ 5 * COS(SINE / 68)), RAD(35+ 7.5 * COS(SINE / 83)), RAD(0+ 5 * COS(SINE / 67))) * RIGHTSHOULDERC0, 0.6 / Animation_Speed)
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.1 * COS(SINE / 35)) * ANGLES(RAD(0), RAD(0), RAD(35)), 0.6 / Animation_Speed)
LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.2, 0.5, 0.3) * ANGLES(RAD(-25+ 7.5 * COS(SINE / 55)), RAD(0+ 5 * COS(SINE / 73)), RAD(32+ 7.5 * COS(SINE / 61))) * LEFTSHOULDERC0, 0.6 / Animation_Speed)
RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.1 * COS(SINE / 35), -0.01) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 0.6 / Animation_Speed)
LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.1 * COS(SINE / 35), -0.01) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 0.6 / Animation_Speed)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(90),math.rad(0),math.rad(0)),1/2)
end
elseif Torsovelocity >= sensitivity and taunt.Value == "Toxic" then
Anim = "Walk"
if attack == false then
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 1
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-115),math.rad(0),math.rad(0)),1/2)
Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(10 - 2* SIN(SINE / 3)), RAD(0), RAD(0+10* SIN(SINE / 6))), 0.8 / Animation_Speed)
RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0+0.3* SIN(SINE / 6)) * ANGLES(RAD(0-70* SIN(SINE / 6)), RAD(0), RAD(12)) * RIGHTSHOULDERC0, 0.8 / Animation_Speed)
LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0-0.3* SIN(SINE / 6)) * ANGLES(RAD(0+70* SIN(SINE / 6)), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 0.8 / Animation_Speed)
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.1+0.15* SIN(SINE / 3)) * ANGLES(RAD(15+3 * SIN(SINE / 3)), RAD(0), RAD(0+5 * SIN(SINE / 6))), 0.8 / Animation_Speed)
RightHip.C0 = Clerp(RightHip.C0, CF(1 , -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(-5 + 70 * SIN(SINE / 6))), 0.8 / Animation_Speed)
LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(5 + 70 * SIN(SINE / 6))), 0.8 / Animation_Speed)
end
elseif Torsovelocity >= sensitivity and taunt.Value == "KingMan" then
Anim = "Walk"
if attack == false then
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0*CFrame.new(0,.125*math.sin(Sine/12),0)*CFrame.Angles(math.rad(10-5*math.cos(Sine/12)),math.rad(-10*math.cos(Sine/12)),math.rad(-5*math.cos(Sine/12))),.25)
Neck.C0 = Clerp(Neck.C0,NECKC0*CFrame.Angles(math.rad(10-5*math.cos(Sine/12)),math.rad(10*math.cos(Sine/12)),math.rad(5*math.cos(Sine/12))),.25)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5+.2*math.sin(Sine/12),-.25)*CFrame.Angles(math.rad(165-15*math.cos(Sine/12)),math.rad(-10+5*math.sin(Sine/12)),math.rad(10))*RIGHTSHOULDERC0,.25)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5-.15*math.cos(Sine/12),.5*math.sin(Sine/12))*CFrame.Angles(math.rad(-30*math.sin(Sine/12)),math.rad(5*math.cos(Sine/12)),0)*LEFTSHOULDERC0,.25)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-.9-.2*math.cos(Sine/12),.5*math.sin(Sine/12))*CFrame.Angles(math.rad(-10-40*math.sin(Sine/12)),math.rad(90+5*math.cos(Sine/12)),math.rad(2.5*math.cos(Sine/12))),.25)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-.9+.2*math.cos(Sine/12),-.5*math.sin(Sine/12))*CFrame.Angles(math.rad(-10+40*math.sin(Sine/12)),math.rad(-90+5*math.cos(Sine/12)),math.rad(2.5*math.cos(Sine/12))),.25)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15)*CFrame.Angles(math.rad(-90),0,0),.25)
end
elseif Torsovelocity < sensitivity and taunt.Value == "Berger" then
Anim = "Idle"
if attack == false then
change = 1
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 0
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CFrame.new(0,0,.5 + .3 * math.cos(Sine / 22)) * CFrame.Angles(math.rad(-19 + 2 * math.sin(Sine / 22)),math.rad(0),math.rad(0)),.7/3)
Neck.C0 = Clerp(Neck.C0,NECKC0 * CFrame.Angles(math.rad(-10 + 3 * math.sin(Sine / 22)),math.rad(0),math.rad(0)),.7/3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5,0) * CFrame.Angles(math.rad(59.9 + 2 * math.sin(Sine / 22)),math.rad(11.9 + 2 * math.sin(Sine / 22)),math.rad(-1.3)) * RIGHTSHOULDERC0,.7/3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.2,.5,.15) * CFrame.Angles(math.rad(12.5),math.rad(164),math.rad(-140.7)) * LEFTSHOULDERC0,.7/3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-.5,-.85) * CFrame.Angles(math.rad(-42 - 3 * math.cos(Sine / 22)),math.rad(0),math.rad(0))  * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0)),.7/3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-.35,-1.35,-.15) * CFrame.Angles(math.rad(-55 - 3 * math.cos(Sine / 22)),math.rad(55.81),math.rad(129.01 + 3 * math.sin(Sine / 22))) *  CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)),.7/3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1/2)
end
elseif Torsovelocity >= sensitivity and taunt.Value == "Berger" then
Anim = "Walk"
if attack == false then
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CFrame.new(0,0,.5 + .6 * math.cos(Sine / 19)) * CFrame.Angles(math.rad(45 + 4 * math.sin(Sine / 19)),math.rad(0),math.rad(0)),.7/3)
Neck.C0 = Clerp(Neck.C0,NECKC0 * CFrame.new(0,-.05,0) * CFrame.Angles(math.rad(-45),math.rad(0),math.rad(0)),.7/3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5,-.1) * CFrame.Angles(math.rad(-45),math.rad(0),math.rad(0)) * RIGHTSHOULDERC0,.7/3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5,0) * CFrame.Angles(math.rad(135),math.rad(0),math.rad(0)) * LEFTSHOULDERC0,.7/3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1,-.01) * CFrame.Angles(math.rad(-10),math.rad(80),math.rad(5+5*math.sin(Sine / 19))),1/2)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1,-.01) * CFrame.Angles(math.rad(0),math.rad(-80),math.rad(-5-5*math.sin(Sine / 19))),1/2)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1)
end
elseif Torsovelocity < sensitivity and taunt.Value == "Fallen" then
Anim = "Idle"
if attack == false then
change = 1
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 0
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CFrame.new(0,0,3 + .125 * math.sin(sine / 12)) * CFrame.Angles(math.rad(15),math.rad(0),math.rad(0)),.7/3)
Neck.C0 = Clerp(Neck.C0,NECKC0 * CFrame.Angles(math.rad(8),math.rad(0),math.rad(0)),1/3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(6)) * RIGHTSHOULDERC0,.7/3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.25,-.5,-.25) * CFrame.Angles(math.rad(52),math.rad(19.3),math.rad(36.6)) * LEFTSHOULDERC0,.7/3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1.5,-1,-.01) * CFrame.Angles(math.rad(8.6),math.rad(-30.3),math.rad(-15))  * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0)),1/3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1,-.01) * CFrame.Angles(math.rad(-3.4),math.rad(16.8),math.rad(-11.5)) *  CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)),1/3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(-1.5,-3.05,-.35) * CFrame.Angles(math.rad(15),math.rad(0),math.rad(0)),1/2)
end
elseif Torsovelocity >= sensitivity and taunt.Value == "Fallen" then
Anim = "Walk"
if attack == false then
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 0
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0*CFrame.new(0,math.cos(Sine/25),3-math.sin(Sine/25))*CFrame.Angles(math.rad(5*math.sin(Sine/25)),0,math.rad(70)),.25)
Neck.C0 = Clerp(Neck.C0,NECKC0*CFrame.Angles(0,0,math.rad(-70))*CFrame.Angles(math.rad(5*math.cos(Sine/25)),0,0),.25)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1,.5,-.25)*CFrame.Angles(0,math.rad(-10),math.rad(-90))*RIGHTSHOULDERC0,.25)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5,0)*CFrame.Angles(0,0,math.rad(-20+5*math.sin(Sine/25)))*LEFTSHOULDERC0,.25)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1-.1*math.sin(Sine/25),-.01)*CFrame.Angles(0,math.rad(80),0),.25)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-.5-.25*math.sin(Sine/25),-.51)*CFrame.Angles(math.rad(-10),math.rad(-80),0),.25)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15)*CFrame.Angles(math.rad(-90),0,0),.25)
end
elseif Torsovelocity < sensitivity and taunt.Value == "iNSaNiTY" then
Anim = "Idle"
if attack == false then
change = 1
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 0
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CFrame.new(0,0,3 - .5 * math.sin(sine/40)) * CFrame.Angles(math.rad(10 + 3 * math.sin(sine/40)),math.rad(-8 + 3 * math.sin(sine/40)),math.rad(-1.4)) * CFrame.Angles(math.rad(0 + 2 * -math.cos(sine / 40)),math.rad(0 + 4 * -math.sin(sine / 40)),math.rad(0)),.7/3)
Neck.C0 = Clerp(Neck.C0,NECKC0 * CFrame.Angles(math.rad(19),math.rad(6.3),math.rad(-1.8)),1)
if math.random(1,60) == 1 then
for i = 1,math.random(1,3) do
Neck.C0 = Clerp(Neck.C0,NECKC0 * CFrame.Angles(math.rad(20+math.random(-20,20)),math.rad((10*math.cos(sine/100))+math.random(-20,20)),math.rad(math.random(-20,20))),1)
end
end
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5,0) * CFrame.Angles(math.rad(-59.2-4*math.sin(sine/40)),math.rad(-36.3),math.rad(-18.4)) * RIGHTSHOULDERC0,.7/3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5,0) * CFrame.Angles(math.rad(5.6 - 4*math.sin(sine/40)),math.rad(3 - 4*math.sin(sine/40)),math.rad(-3 - 4*math.sin(sine/40))) * LEFTSHOULDERC0,.7/3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1,-.1) * CFrame.Angles(math.rad(-9.9 + 4*math.sin(sine/40)),math.rad(-8.1 + 4 *math.sin(sine/40)),math.rad(1.4)) * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0)),1/3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-.8,-.51 - .03125 * math.sin(sine/40)) * CFrame.Angles(math.rad(-32 + 4 *math.sin(sine/40)),math.rad(8 + 4 *math.sin(sine/40)),math.rad(1.6)) * CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)),1/3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1/2)
end
elseif Torsovelocity < sensitivity and taunt.Value == "GOD" then
Anim = "Idle"
if attack == false then
change = 1
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 0
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0,0,0 + .05 * math.cos(sine / 16)) * CFrame.Angles(math.rad(4 + .75 * math.cos(sine / 16)),math.rad(0),math.rad(-8)) * CFrame.Angles(math.rad(0 + .75 * -math.sin(sine / 16)),math.rad(0),math.rad(0)),1 / 3)
Neck.C0 = Clerp(Neck.C0,nc0 * CFrame.new() * CFrame.Angles(math.rad(9),math.rad(0),math.rad(0)),1 / 3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5 + .03 * math.cos(sine / 16),0) * CFrame.Angles(math.rad(8.12 + 1 * math.cos(sine / 16)),math.rad(-17 + 1 * math.cos(sine / 16)),math.rad(6.7)) * rscp,1 / 3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5 + .025 * math.cos(sine / 16),-0) * CFrame.Angles(math.rad(0),math.rad(3.5),math.rad(-2)) * lscp,1 / 3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1 - .05 * math.cos(sine / 16),-.1) * CFrame.Angles(math.rad(-2.5 + .75 * math.cos(sine / 16)),math.rad(-4),math.rad(2)) * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0 + .75 * -math.sin(sine / 16))),1 / 3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1 - .05 * math.cos(sine / 16),-.1) * CFrame.Angles(math.rad(-2.5 + .75 * math.cos(sine / 16)),math.rad(4),math.rad(-2)) * CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0 + -.75 * -math.sin(sine / 16))),1 / 3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-.65,-.15) * CFrame.Angles(math.rad(-190.3-.9*math.cos(sine/16)),math.rad(0),math.rad(0)),1 / 2)
end
elseif Torsovelocity < sensitivity and taunt.Value == "Glitch" then
Anim = "Idle"
if attack == false then
change = 1
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 1
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CFrame.new(0,0,0 - .05 * math.cos(sine / 14))* CFrame.new(0,0,0 + .05 * -math.cos(sine / 14)) * CFrame.Angles(math.rad(-4 - 1 * math.sin(sine / 14)),math.rad(0),math.rad(0)) * CFrame.Angles(math.rad(0 + 1 * -math.cos(sine / 14)),math.rad(0),math.rad(0)),.7/3)
Neck.C0 = Clerp(Neck.C0,NECKC0 * CFrame.Angles(math.rad(8 * math.sin(sine / 14)),math.rad(0),math.rad(0)),1/3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5,0) * CFrame.Angles(math.rad(64 - 3 * math.sin(sine / 14)),math.rad(0),math.rad(10)) * RIGHTSHOULDERC0,.7/3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5,0) * CFrame.Angles(math.rad(4.1 - 1.5 * math.cos(sine / 14)),math.rad(3),math.rad(-1.7)) * LEFTSHOULDERC0,.7/3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1 + .05 * math.cos(sine / 14),-.01) * CFrame.Angles(math.rad(-3.3),math.rad(-14.8),math.rad(7)) * CFrame.Angles(math.rad(-12 - 1.5 * math.sin(sine / 14)),math.rad(74 - 1.5 * math.sin(sine / 14)),math.rad(10 - 1.5 * math.sin(sine / 14))),.7/3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1 + .05 * math.cos(sine / 14),-.01) * CFrame.Angles(math.rad(-1.5),math.rad(6.4),math.rad(-4)) *  CFrame.Angles(math.rad(-14 - 1.5 * math.sin(sine / 14)),math.rad(-83 - 1.5 * math.sin(sine / 14)),math.rad(-5.3 + 1.5 * math.sin(sine / 14))),.7/3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1/2)
end
elseif Torsovelocity >= sensitivity and taunt.Value == "Glitch" then
Anim = "Walk"
if attack == false then
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 1
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CFrame.new(0,0,2.5 + .5 * math.cos(sine/9)) * CFrame.Angles(math.rad(20-2.5*math.sin(sine/9)),math.rad(0),math.rad(0)),1/2)
Neck.C0 = Clerp(Neck.C0,NECKC0 * CFrame.new() * CFrame.Angles(math.rad(-10-10*math.sin(sine/9)),math.rad(0),math.rad(0)),1/2)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5+.125*math.sin(sine/9),0) * CFrame.Angles(math.rad(22.9+2.5*math.sin(sine/9)),math.rad(-14),math.rad(11.7)) * RIGHTSHOULDERC0,.7/3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5+.25*math.sin(sine/9),0) * CFrame.Angles(math.rad(110),math.rad(0),math.rad(0)) * LEFTSHOULDERC0,.7/3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1,-.01) * CFrame.Angles(math.rad(-10),math.rad(80),math.rad(5+5*math.sin(sine/9))),1/2)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1,-.01) * CFrame.Angles(math.rad(0),math.rad(-80),math.rad(-5-5*math.sin(sine/9))),1/2)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1/2)
end
elseif Torsovelocity < sensitivity and taunt.Value == "Superior" then
Anim = "Idle"
if attack == false then
change = 1
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 1
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0,0,0 + .05 * math.cos(sine / 14)) * CFrame.Angles(math.rad(6),math.rad(0),math.rad(0)) * CFrame.Angles(math.rad(0 + 2 * math.sin(sine / 14)),math.rad(0),math.rad(0)),1 / 3)
Neck.C0 = Clerp(Neck.C0,nc0 * CFrame.new() * CFrame.Angles(math.rad(2 + .7 * math.sin(sine / 14)),math.rad(0),math.rad(0)) * CFrame.Angles(math.rad(0 + 2 * -math.cos(sine / 14)),math.rad(0),math.rad(0)),1 / 3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5,0) * CFrame.Angles(math.rad(9.6 + 1 * math.cos(sine / 14)),math.rad(175 + 1 * math.cos(sine / 14)),math.rad(172)) * rscp,1 / 3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.1,.2 + .025 * math.sin(sine / 14),-.25) * CFrame.Angles(math.rad(45 + .8 * math.sin(sine / 14)),math.rad(0),math.rad(57 + .8 * math.sin(sine / 14))) * lscp,1 / 3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1 - .05 * math.cos(sine / 14),-.075) * CFrame.Angles(math.rad(11),math.rad(-7.5),math.rad(7)) * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0 + 3 * math.sin(sine / 14))),1 / 3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1 - .05 * math.cos(sine / 14),0) * CFrame.Angles(math.rad(-4),math.rad(21),math.rad(-4.5)) * CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0 + -3 * math.sin(sine / 14))),1 / 3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-106.3-.9*math.cos(sine/12)),math.rad(0),math.rad(0)),1 / 2)
end
elseif Torsovelocity < sensitivity and taunt.Value == "KickGod" then
Anim = "Idle"
if attack == false then
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 1
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1/2)
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.03 + 0.05 * COS(Sine / 12)) * ANGLES(RAD(0), RAD(0), RAD(-35)), 1 / 5)
Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(25 + MRANDOM(-5,5) - 4 * COS(Sine / 12)), RAD(MRANDOM(-5,5)), RAD(15)), 1 / 5)
if math.random(1,5) == 1 then
Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 + MRANDOM(-25,25) - 4 * COS(Sine / 12)), RAD(MRANDOM(-25,25)), RAD(0)), 1.5 / 3)	
end
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5,0)*CFrame.Angles(math.rad(160),0,math.rad(15-5*math.sin(Sine/25)))*RIGHTSHOULDERC0,.25)
LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5 + 0.025 * COS(Sine / 12), 0) * ANGLES(RAD(0), RAD(0 + 7.5 * SIN(Sine / 12)), RAD(-12 - 7.5 * SIN(Sine / 12))) * LEFTSHOULDERC0, 0.15 / 5)
RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(Sine / 12), 0) * ANGLES(RAD(0), RAD(95), RAD(0)) * ANGLES(RAD(-15), RAD(0), RAD(0)), 1 / 5)
LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(Sine / 12), 0) * ANGLES(RAD(0), RAD(-55), RAD(0)) * ANGLES(RAD(-12), RAD(0), RAD(0)), 1 / 5)
end
elseif Torsovelocity < sensitivity and taunt.Value == "Err0r" then
Anim = "Idle"
if attack == false then
change = 1
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 1
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CFrame.new(0 + .75 * math.cos(sine / 16) + math.sin(sine / 16),0,3) * CFrame.new(0 + -.75 * -math.cos(sine / 16) + -math.sin(sine / 16),0,3) * CFrame.Angles(math.rad(0),math.rad(14 * math.cos(sine / 16)),math.rad(0)),.7/3)
Neck.C0 = Clerp(Neck.C0,NECKC0 * CFrame.Angles(math.rad(0),math.rad(26 * math.sin(sine / 16)),math.rad(26 * math.sin(sine / 16))),.7/3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5,0) * CFrame.Angles(math.rad(1.9),math.rad(0),math.rad(-179)) * CFrame.Angles(math.rad(1.9),math.rad(180),math.rad(16 - 10 * math.cos(sine / 16))) * RIGHTSHOULDERC0,.7/3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(-10)) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(10 * math.cos(sine / 16))) * LEFTSHOULDERC0,.7/3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1,-.01) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(10 * math.cos(sine / 16)))  * CFrame.Angles(math.rad(0),math.rad(90),math.rad(-10 * math.cos(sine / 16))),.7/3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1,-.01) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(10 * math.cos(sine / 16))) *  CFrame.Angles(math.rad(0),math.rad(-90),math.rad(-10 * math.cos(sine / 16))),.7/3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1/2)
end
elseif Torsovelocity >= sensitivity and taunt.Value == "Err0r" then
Anim = "Walk"
if attack == false then
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 1
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CFrame.new(0,0,2.5 + .5 * math.sin(sine/15)) * CFrame.Angles(math.rad(40),math.rad(-5*math.sin(sine/30)),math.rad(0)),.7/3)
Neck.C0 = Clerp(Neck.C0,NECKC0 * CFrame.new(0,-.25,0) * CFrame.Angles(math.rad(-40),math.rad(0),math.rad(0)),.7/3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5,0) * CFrame.Angles(math.rad(-45),math.rad(0),math.rad(5 + 2 * math.sin(sine/19))) * RIGHTSHOULDERC0,.7/3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5,0) * CFrame.Angles(math.rad(-45),math.rad(0),math.rad(-5 - 2 * math.sin(sine/19))) * LEFTSHOULDERC0,.7/3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-.5,-.5) * CFrame.Angles(math.rad(-20 + 9 * math.sin(sine/74)),math.rad(80),math.rad(0)) * CFrame.Angles(math.rad(0 + 5 * math.cos(sine/37)),math.rad(0),math.rad(0)),.7/3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1,0) * CFrame.Angles(math.rad(-20 - 9 * math.sin(sine/54)),math.rad(-80),math.rad(0)) * CFrame.Angles(math.rad(0 - 5 * math.cos(sine/41)),math.rad(0),math.rad(0)),.7/3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1/2)
end
elseif Torsovelocity >= sensitivity and taunt.Value == "KickGod" then
Anim = "Walk"
if attack == false then
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 1
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-115),math.rad(0),math.rad(0)),1/2)
RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CFrame.new(0, 0, -0.175 + 0.025 * math.cos(Sine / 3.5) + -math.sin(Sine / 3.5) / 7) * CFrame.Angles(math.rad(9-2.5 * math.cos(Sine / 3.5)), math.rad(0), math.rad(10 * math.cos(Sine / 7))), 0.15)
Neck.C0 = Clerp(Neck.C0, NECKC0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0+math.random(-15,15)), math.rad(0+math.random(-15,15)), math.rad(0+math.random(-15,15))), 0.35 / 3)
RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -0.925 - 0.5 * math.cos(Sine / 7) / 2, 0.5 * math.cos(Sine / 7) / 2) * CFrame.Angles(math.rad(-15 - 35 * math.cos(Sine / 7)) + -math.sin(Sine / 7) / 2.5, math.rad(90 - 2 * math.cos(Sine / 7)), math.rad(0)) * CFrame.Angles(math.rad(0 + 2.5 * math.cos(Sine / 7)), math.rad(0), math.rad(0)), 0.3)
LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -0.925 + 0.5 * math.cos(Sine / 7) / 2, -0.5 * math.cos(Sine / 7) / 2) * CFrame.Angles(math.rad(-15 + 35 * math.cos(Sine / 7)) + math.sin(Sine / 7) / 2.5, math.rad(-90 - 2 * math.cos(Sine / 7)), math.rad(0)) * CFrame.Angles(math.rad(0 - 2.5 * math.cos(Sine / 7)), math.rad(0), math.rad(0)), 0.3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,0.5,0) * CFrame.Angles(math.rad(-60 - 5 * math.cos(Sine / 12)),math.rad(0 - 2.5 * math.cos(Sine / 12)),math.rad(5 + 2.5 * math.cos(Sine / 12))) * RIGHTSHOULDERC0,1 / 3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1, 0.5 + 0.05 * math.sin(Sine / 30), 0.025 * math.cos(Sine / 20)) * CFrame.Angles(math.rad(-70) * math.cos(Sine / 7) , math.rad(-90),	math.rad(-5)), 0.1)
end
elseif Torsovelocity >= sensitivity and taunt.Value == "Fave" then
Anim = "Walk"
if attack == false then
change = 1
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 1
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0,0,0 + 0.05 * math.sin(sine / 12)) * CFrame.Angles(math.rad(3),math.rad(0),math.rad(0)),1 / 3)
Neck.C0 = Clerp(Neck.C0,nc0 * CFrame.new() * CFrame.Angles(math.rad(-6 - .5 * math.sin(sine / 12)),math.rad(0),math.rad(0)),1)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,0.5,0) * CFrame.Angles(math.rad(0.1),math.rad(-2),math.rad(3)) * rscp,1)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.3,0.7 - .1 * math.sin(sine / 12),0) * CFrame.Angles(math.rad(4.1),math.rad(8.56),math.rad(-133)) * CFrame.Angles(math.rad(8.19 - 1 * math.cos(sine / 12)),math.rad(-11.12 - 1 * math.cos(sine / 12)),math.rad(-32.06 - 8 * math.cos(sine / 12))) * lscp,1 / 3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(.58,-2 - 0.05 * math.sin(sine / 12),-.2) * CFrame.Angles(math.rad(5.37),math.rad(-6.9),math.rad(2.9)),1 / 3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-.6,-2 - 0.05 * math.sin(sine / 12),0) * CFrame.Angles(math.rad(-3.9),math.rad(-.42),math.rad(-6)),1 / 3)
RightHip.C1 = Clerp(RightHip.C1,CFrame.new() * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),1)
LeftHip.C1 = Clerp(LeftHip.C1,CFrame.new() * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),1)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0,-1,0) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1)
end
elseif Torsovelocity >= sensitivity and taunt.Value == "iNSaNiTY" then
Anim = "Walk"
if attack == false then
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 1
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CFrame.new(0,0,3 - .5 * math.sin(sine/50)) * CFrame.Angles(math.rad(20),math.rad(0),math.rad(0)),.7/3)
Neck.C0 = Clerp(Neck.C0,NECKC0 * CFrame.Angles(math.rad(5),math.rad(0),math.rad(0)),1)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5,0) * CFrame.Angles(math.rad(-41.6-4*math.sin(sine/50)),math.rad(0),math.rad(0)) * RIGHTSHOULDERC0,.7/3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5,0) * CFrame.Angles(math.rad(20),math.rad(0),math.rad(-10-10*math.sin(sine/50))) * LEFTSHOULDERC0,.7/3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1,-.01) * CFrame.Angles(math.rad(-20),math.rad(80),math.rad(10+10*math.sin(sine/50))),1/3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1,-.01) * CFrame.Angles(math.rad(-10),math.rad(-80),math.rad(-10-10*math.sin(sine/50))),1/3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1/2)
end
elseif Torsovelocity >= sensitivity and taunt.Value == "Superior" then
Anim = "Walk"
if attack == false then
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 1
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1/2)
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.1) * ANGLES(RAD(5), RAD(0), RAD(0)), 0.15 / Animation_Speed)
Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(5 - 8 * SIN(Sine / (WALKSPEEDVALUE / 2))), RAD(0), RAD(0)), 0.15 / Animation_Speed)
RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, -0.03) * ANGLES(RAD(180), RAD(-15), RAD(0))* RIGHTSHOULDERC0, 0.15 / Animation_Speed)
LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-60 * COS(Sine / WALKSPEEDVALUE)), RAD(0), RAD(-5)) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
RightHip.C0 = Clerp(RightHip.C0, CF(1 , -1 - 0.15 * COS(Sine / WALKSPEEDVALUE), -0.2+ 0.2 * COS(Sine / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(-15)), 2 / Animation_Speed)
LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.15 * COS(Sine / WALKSPEEDVALUE), -0.2+ -0.2 * COS(Sine / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(15)), 2 / Animation_Speed)
end
elseif Torsovelocity >= sensitivity and taunt.Value == "GOD" then
Anim = "Walk"
if attack == false then
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 1
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1/2)
RightHip.C0=Clerp(RightHip.C0,CF(1,-0.85,-0.15 - 0.15 * math.cos(Sine / 4))*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(0),math.rad(0 + 5 * math.cos(Sine / 8)),math.rad(0 + 25 * math.cos(Sine / 8))),.1)
LeftHip.C0=Clerp(LeftHip.C0,CF(-1,-0.85,-0.15 + 0.15 * math.cos(Sine / 4))*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(0),math.rad(0 + 5 * math.cos(Sine / 8)),math.rad(0 + 25 * math.cos(Sine / 8))),.1)
RootJoint.C0=Clerp(RootJoint.C0,rc0*CF(0,0,-0.15 - 0.1 * math.cos(Sine / 4))*angles(math.rad(5),math.rad(0),math.rad(0 - 5 * math.cos(Sine / 8))),.1)
Neck.C0=Clerp(Neck.C0,nc0*angles(math.rad(25 - 5 * math.cos(Sine / 0.325)),math.rad(0 - 5 * math.cos(Sine / 0.25)),math.rad(0 + 5 * math.cos(Sine / 8))),.1)
RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(-70 - 5 * math.cos(Sine / 12)), math.rad(0 - 2.5 * math.cos(Sine / 12)), math.rad(5 + 2.5 * math.cos(Sine / 12))) * rscp, 1 / 3)
LeftShoulder.C0=Clerp(LeftShoulder.C0,CF(-1.5,0.5,0)*angles(math.rad(160),math.rad(0),math.rad(25)),.1)
end
elseif Torsovelocity >= sensitivity and taunt.Value == "None" then
Anim = "Walk"
if attack == false then
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 1
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0,0,0 + 0.05 * math.sin(sine / 12)) * CFrame.Angles(math.rad(20),math.rad(0 + 2.5 * math.sin(sine / 12)),math.rad(0 - 2.5 * math.sin(sine / 12))),.7 / 3)
Neck.C0 = Clerp(Neck.C0,nc0 * CFrame.new() * CFrame.Angles(math.rad(-20 - 3 * math.cos(sine / 12)),math.rad(0 - 2.5 * math.cos(sine / 12)),math.rad(0 - 2.5 * math.cos(sine / 12))),.7 / 3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,0.5,0) * CFrame.Angles(math.rad(150),math.rad(0 - 2.5 * math.cos(sine / 12)),math.rad(5 + 2.5 * math.cos(sine / 12))) * rscp,.7 / 3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,0.5,0 - 0.2 * math.sin(sine / 12)) * CFrame.Angles(math.rad(20 - 45 * math.cos(sine / 12)),math.rad(0 - 10 * math.sin(sine / 12)),math.rad(0 + 2.5 * math.sin(sine / 12))) * lscp,.7 / 3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1 ,-1,0) * CFrame.Angles(math.rad(0),math.rad(85),math.rad(0)) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.7 / 3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1,0) * CFrame.Angles(math.rad(0),math.rad(-85),math.rad(0)) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.7 / 3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05,-1,-0.15) * CFrame.Angles(math.rad(-93.75+7.25*math.cos(sine/12)),math.rad(0),math.rad(0)),1 / 2)
end
elseif Torsovelocity >= sensitivity and taunt.Value == "Krump" then
Anim = "Walk"
if attack == false then
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 1
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0,0,0 + 0.0125 * math.sin(sine / 12)) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(1 * math.sin(sine / 12))),1)
Neck.C0 = Clerp(Neck.C0,nc0 * CFrame.new() * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),1)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5,0) * CFrame.Angles(math.rad(-25 * math.sin(sine / 12)),math.rad(0),math.rad(0)) * rscp,1)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5,0) * CFrame.Angles(math.rad(25 * math.sin(sine / 12)),math.rad(0),math.rad(0)) * lscp,1)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(.5 ,-1.7 + 0.0125 * math.sin(sine / 12),-.2 + .2 * math.cos(sine / 12)) * CFrame.Angles(math.rad(24 * math.sin(sine / 12)),math.rad(20),math.rad(0)) * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0)),1)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-.5,-1.7 + 0.0125 * math.sin(sine / 12),-.2 - .2 * math.cos(sine / 12)) * CFrame.Angles(math.rad(-24 * math.sin(sine / 12)),math.rad(-20),math.rad(0)) * CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)),1)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0,-1,0) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1)
end
elseif Torsovelocity < sensitivity and taunt.Value == "Krump" then
Anim = "Idle"
if attack == false then
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 1
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0,0,0 + 0.0125 * math.sin(sine / 12)) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),1)
Neck.C0 = Clerp(Neck.C0,nc0 * CFrame.new() * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),1)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(1)) * rscp,1)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(-1)) * lscp,1)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(.53,-2 - 0.0125 * math.sin(sine / 12),0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(2)),1)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-.53,-2 - 0.0125 * math.sin(sine / 12),0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(-2)),1)
RightHip.C1 = Clerp(RightHip.C1,CFrame.new() * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),1)
LeftHip.C1 = Clerp(LeftHip.C1,CFrame.new() * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),1)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0,-1,0) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1)
end
elseif Torsovelocity < sensitivity and taunt.Value == "Sit" then
Anim = "Idle"
if attack == false then
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 1
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0,0,-1.8 + .05 * math.sin(sine / 12)) * CFrame.Angles(math.rad(8),math.rad(0),math.rad(0)),1/3)
Neck.C0 = Clerp(Neck.C0,nc0 * CFrame.new() * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),1)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.2,.5,-.25) * CFrame.Angles(math.rad(45),math.rad(0),math.rad(-13)) * rscp,1)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.2,.5,-.25) * CFrame.Angles(math.rad(45),math.rad(0),math.rad(13)) * lscp,1)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(.5,-.5 - .05 * math.sin(sine / 12),0) * CFrame.Angles(math.rad(95),math.rad(180),math.rad(0)),1/3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-.5,-.5 - .05 * math.sin(sine / 12),0) * CFrame.Angles(math.rad(95),math.rad(-180),math.rad(0)),1/3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0,-1,0) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1)
end
elseif Torsovelocity < sensitivity and taunt.Value == "Sleeping" then
RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),1)
Neck.C0 = Clerp(Neck.C0,nc0 * CFrame.new() * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),1)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)) * rscp,1)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)) * lscp,1)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(.5,-2,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),1)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-.5,-2,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),1)
RightHip.C1 = Clerp(RightHip.C1,CFrame.new() * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),1)
LeftHip.C1 = Clerp(LeftHip.C1,CFrame.new() * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),1)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0,-1,0) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1)
elseif Torsovelocity < sensitivity and taunt.Value == "Fave" then
Anim = "Idle"
if attack == false then
change = 1
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 1
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0,0,0 + 0.05 * math.sin(sine / 12)) * CFrame.Angles(math.rad(3),math.rad(0),math.rad(0)),1 / 3)
Neck.C0 = Clerp(Neck.C0,nc0 * CFrame.new() * CFrame.Angles(math.rad(-6 - .5 * math.sin(sine / 12)),math.rad(0),math.rad(0)),1)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,0.5,0) * CFrame.Angles(math.rad(0.1),math.rad(-2),math.rad(3)) * rscp,1)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.3,0.7 - .1 * math.sin(sine / 12),0) * CFrame.Angles(math.rad(4.1),math.rad(8.56),math.rad(-133)) * CFrame.Angles(math.rad(8.19 - 1 * math.cos(sine / 12)),math.rad(-11.12 - 1 * math.cos(sine / 12)),math.rad(-32.06 - 8 * math.cos(sine / 12))) * lscp,1 / 3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(.58,-2 - 0.05 * math.sin(sine / 12),-.2) * CFrame.Angles(math.rad(5.37),math.rad(-6.9),math.rad(2.9)),1 / 3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-.6,-2 - 0.05 * math.sin(sine / 12),0) * CFrame.Angles(math.rad(-3.9),math.rad(-.42),math.rad(-6)),1 / 3)
RightHip.C1 = Clerp(RightHip.C1,CFrame.new() * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),1)
LeftHip.C1 = Clerp(LeftHip.C1,CFrame.new() * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),1)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0,-1,0) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1)
end
elseif Torsovelocity < sensitivity and taunt.Value == "taunt" then
Anim = "Idle"
if attack == false then
change = 1
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 1
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CFrame.new(0,0,0 + .01125 * math.cos(sine / 25) + math.sin(sine / 35)) * CFrame.Angles(math.rad(-107 + -1 * math.cos(sine / 25) + math.sin(sine / 35)),math.rad(0),math.rad(0)),.1/3)
Neck.C0 = Clerp(Neck.C0,NECKC0 * CFrame.Angles(math.rad(-18 + 1 * math.cos(sine / 25) + math.sin(sine / 35)),math.rad(0),math.rad(0)),1/3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(.45 + .025 * math.sin(sine / 25),.45,-.5) * CFrame.Angles(math.rad(0),math.rad(-6 + -1 * math.sin(sine / 25)),math.rad(-65 + -1 * math.sin(sine / 25))) * RIGHTSHOULDERC0,1/3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.45 + -.0125 * math.sin(sine / 25),.5,0 + .025 * math.sin(sine / 25)) * CFrame.Angles(math.rad(-96 + -1 * math.sin(sine / 25)),math.rad(13),math.rad(8 + -1 * math.sin(sine / 25))) * LEFTSHOULDERC0,1/3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1.4,-.95) * CFrame.Angles(math.rad(-78),math.rad(0),math.rad(7))  * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0)),1/3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1.15,-.45) * CFrame.Angles(math.rad(-36),math.rad(14),math.rad(0)) *  CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)),1/3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1/2)
end
elseif Torsovelocity >= sensitivity and taunt.Value == "taunt" then
Anim = "Walk"
if attack == false then
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 1
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CFrame.new(0,0,.5 + .6 * math.cos(Sine / 19)) * CFrame.Angles(math.rad(45 + 4 * math.sin(Sine / 19)),math.rad(0),math.rad(0)),.7/3)
Neck.C0 = Clerp(Neck.C0,NECKC0 * CFrame.new(0,-.05,0) * CFrame.Angles(math.rad(-45),math.rad(0),math.rad(0)),.7/3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.5,.5,-.1) * CFrame.Angles(math.rad(-45),math.rad(0),math.rad(0)) * RIGHTSHOULDERC0,.7/3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.5,.5,0) * CFrame.Angles(math.rad(-45),math.rad(0),math.rad(0)) * LEFTSHOULDERC0,.7/3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-1,-.01) * CFrame.Angles(math.rad(-10),math.rad(80),math.rad(5+5*math.sin(Sine / 19))),1/2)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-1,-.01) * CFrame.Angles(math.rad(0),math.rad(-80),math.rad(-5-5*math.sin(Sine / 19))),1/2)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1)
end
elseif Torsovelocity < sensitivity and taunt.Value == "taunt2" or Torsovelocity >= sensitivity and taunt.Value == "taunt2" then
Anim = "Idle"
if attack == false then
change = 1
if GUN and Outlines then
if GunBase then
GunBase.Transparency = 1
end
if GunAdds then
GunAdds.Transparency = 1
end
if Gunneon then
Gunneon.Transparency = 1
end
if OutBase then
OutBase.Transparency = 1
end
end
RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CFrame.new(0,0,-.8 + .025 * math.sin(sine / 16)) * CFrame.Angles(math.rad(-50),math.rad(0),math.rad(0)),1/3)
Neck.C0 = Clerp(Neck.C0,NECKC0 * CFrame.Angles(math.rad(35 - 1 * math.sin(sine / 16)),math.rad(0),math.rad(0)),1/3)
RightShoulder.C0 = Clerp(RightShoulder.C0,CFrame.new(1.35,.35,0) * CFrame.Angles(math.rad(0),math.rad(-15),math.rad(-15)) * RIGHTSHOULDERC0,.7/3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0,CFrame.new(-1.35,.35,0) * CFrame.Angles(math.rad(0),math.rad(15),math.rad(15)) * LEFTSHOULDERC0,.7/3)
RightHip.C0 = Clerp(RightHip.C0,CFrame.new(1,-.6 - .025 * math.sin(sine / 16),-.3) * CFrame.Angles(math.rad(-55),math.rad(0),math.rad(5))  * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0)),1/3)
LeftHip.C0 = Clerp(LeftHip.C0,CFrame.new(-1,-.6 - .025 * math.sin(sine / 16),-.3) * CFrame.Angles(math.rad(-55),math.rad(0),math.rad(-5)) *  CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)),1/3)
GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(.05,-1,-.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0)),1/2)
end
end
end
task.wait()
end
