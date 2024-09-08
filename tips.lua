-- // Tips for all my coders (based on my knowledge, this might not be the best, but here it is)

local cloner = cloneref or function(...) -- Use cloneref variable if your executor doesn't support it; otherwise, it will do nothing
    return ...
end

-- Cloning services for better undetectability
local Players = cloner(game:GetService("Players"))
local Client = Players.LocalPlayer

-- [[ Remember to name variables smartly. If you use short names like p, c, b, a = blah blah,
-- you might forget what they represent in a few lines. Name them descriptively for better readability and organization.]]

-- // Function to check if an entity is alive
local function IsAlive(entity)
    return entity and entity.Character and entity.Character:FindFirstChild("Humanoid") and entity.Character.Humanoid.Health > 0
end
-- // Functions make your code way CLEANER and faster

-- // Simple script example
task.spawn(function() -- Create a new thread
    while wait(.1) do -- Use wait(.1) to avoid running the loop too frequently
        local success, err = pcall(function()
            if not IsAlive(Client) then -- Use the IsAlive function to check if the Client is alive
                return -- Exit if the Client is not alive
            end
            -- // If the player is found and alive, execute the intended code
            Client.Character:BreakJoints()
        end)
        
        if not success then
            warn("Error occurred: " .. err) -- Log any errors that occur
        end
    end
end)
