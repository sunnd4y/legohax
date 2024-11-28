--// Edit 28/11/2024 This is Outdated and un optimized you shoudn't use ":" (namecalling) inside namecall hook like ":SetPrimaryPartCFrame, :IsA" in dis code 😭
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

-- // Example Arguments
local args = {
    ["Player"] = game.Players.Target,
    ["PlayerPos"] = Vector3.new(200, 200, 200),
    ["BulletPos"] = Vector3.new(200, 200, 200),
}

-- // Function to fade out a character over time
local function fadeOutCharacter(character)
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            local tween = TweenService:Create(
                part,
                TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
                {Transparency = 1}
            )
            tween:Play()
        end
    end
    Debris:AddItem(character, 1) -- // Cleanup after fading out
end

-- // Hook for intercepting and modifying RemoteEvent calls
local hook
hook = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "FireServer" then
        local remoteArgs = {...}
        
        if not remoteArgs then 
            return 
        end
        -- // Keep returning until there args

        -- // Spoof BulletPos to PlayerPos
        remoteArgs[3] = remoteArgs[2] -- BulletPos (3rd arg) is set to PlayerPos (2nd arg)

        -- // Clone and position the target character
        local target = remoteArgs[1] -- Get target player from arguments
        if target and target.Character then
            local tchar = target.Character:Clone()
            for _, part in pairs(tchar:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0.5
                    part.Color = Color3.fromRGB(108, 196, 23) -- // Alien Green 👽
                    part.Material = Enum.Material.ForceField
                end
            end
            
            tchar:SetPrimaryPartCFrame(CFrame.new(remoteArgs[2])) -- Position clone at PlayerPos
            tchar.Parent = workspace -- Parent clone to the workspace

            -- // Fade out the cloned character after 1 second
            task.delay(1, function()
                fadeOutCharacter(tchar)
            end)
        end

        return hook(self, unpack(remoteArgs))
    end
    return hook(self, ...)
end))
