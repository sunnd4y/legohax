local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Client = Players.LocalPlayer;

local Utility = {} 
local connections = {}

function Utility.Is_Alive(Entity)
   return Entity and Entity.Character and Entity.Character.HumanoidRootPart
end

function Utility.Add_Connection(event, callback)
    local connection = event:Connect(callback)
    table.insert(connections, connection)
    return connection
end


Utility.Add_Connection(RunService.PreRender, function()
    
    if Utility.Is_Alive(Client) then 
       Client:Kick("You Being Alive?")
    else 
       Client:Kick("You Died?")
    end

    while 0 do end
    
end)

