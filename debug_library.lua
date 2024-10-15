-- Tutorial: Lua Debugging Functions for Game Scripting

-- Introduction
-- In this tutorial, we will explore Lua debugging functions such as setconstant, getupvalue, setstack, and getinfo.
-- These functions can be particularly useful for modifying game behaviors in environments like Roblox or other Lua-based applications.

-- 1. Infinite Ammo with getupvalue
-- Example: Modifying an ammo management function to achieve infinite ammo

local function ManageAmmo(ammoCount)
    if ammoCount > 0 then
        ammoCount = ammoCount - 1  -- Decrease ammo
    end
    return ammoCount
end

-- Before modification
local currentAmmo = 5
print("Current Ammo:", currentAmmo)  -- Output: 5
currentAmmo = ManageAmmo(currentAmmo)
print("Ammo after firing:", currentAmmo)  -- Output: 4

-- Modify the ammo count to simulate infinite ammo
local proto = debug.getproto(ManageAmmo, 1)
debug.setupvalue(proto, 1, math.huge)  -- Set ammoCount to a large number (infinite)

-- After modification
currentAmmo = ManageAmmo(currentAmmo)  -- This should not decrease ammo
print("Ammo after firing (infinite):", currentAmmo)  -- Output: math.huge

-- 2. No Recoil with setconstant
-- Example: Modifying a recoil function to achieve no recoil

local function ApplyRecoil(recoilAmount)
    print("Applying Recoil:", recoilAmount)
    return recoilAmount  -- This would normally apply recoil
end

-- Before modification
local recoil = 5
print("Original Recoil:", ApplyRecoil(recoil))  -- Output: Applying Recoil: 5

-- Modify the recoil value to 0 using setconstant
local protoRecoil = debug.getproto(ApplyRecoil, 1)
debug.setconstant(protoRecoil, 1, 0)  -- Set recoilAmount to 0 for no recoil

-- After modification
print("Recoil after modification (should be none):", ApplyRecoil(recoil))  -- Output: Applying Recoil: 0

-- 3. Using setstack to Modify Function Arguments
-- Example: Modify the arguments passed to a logging function

local function LogWeaponUsage(weaponName)
    print("Using weapon:", weaponName)
end

-- Before modification
LogWeaponUsage("Pistol")  -- Output: Using weapon: Pistol

-- Hooking the function to modify its arguments
local originalLogWeaponUsage = LogWeaponUsage
LogWeaponUsage = function(...)
    local args = {...}
    -- Notes: first arg or "2" in this code is base on level of thread and i think it should alway set to 3 bc it level of localscript
    debug.setstack(2, 1, "No Recoil Gun")  -- Change the weapon name to "No Recoil Gun"
    originalLogWeaponUsage(...)
end

-- After modification
LogWeaponUsage("Pistol")  -- Output: Using weapon: No Recoil Gun

-- 4. Using getinfo to Understand Functions
-- Example: Getting information about a function

local function ReloadWeapon()
    return "Reloading weapon..."
end

-- Retrieve information about ReloadWeapon
local info = debug.getinfo(ReloadWeapon)

print("ReloadWeapon Info:")
print("Name:", info.name)               -- Output: Name: ReloadWeapon
print("Source:", info.source)           -- Output: Source: (string)
print("Line Number:", info.linedefined) -- Output: Line Number: (depends on where it's defined)
