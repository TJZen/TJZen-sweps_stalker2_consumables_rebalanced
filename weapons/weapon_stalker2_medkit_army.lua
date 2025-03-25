if CLIENT then 
    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/hud/vgui_stalker2_medkitarmy" )
	SWEP.BounceWeaponIcon = true 
    SWEP.DrawWeaponInfoBox = true
end

SWEP.PrintName = "Army Medkit"
SWEP.Author = "Craft_Pig"
SWEP.Purpose = 
[[
Heals 90 HP Over 2.8s
Gives 25-26 Armor Over 2s
Provides 25 Temporary Armor For 40s
]]
SWEP.Category = "S.T.A.L.K.E.R. 2"
-- SWEP.Category1 = "EFT"
-- SWEP.Category2 = "Medkits"

SWEP.ViewModelFOV = 65
SWEP.ViewModel = "models/weapons/sweps/stalker2/medkit/v_item_medkit.mdl"
SWEP.WorldModel = "models/weapons/sweps/stalker2/medkit/w_item_medkit.mdl"
SWEP.UseHands = true
SWEP.DrawCrosshair = false 

SWEP.Spawnable = true
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Slot = 5
SWEP.SlotPos = 8

SWEP.SwayScale = 0.15
SWEP.BobScale = 0.75

SWEP.Secondary.Ammo = "none"
SWEP.Primary.Ammo = "medkit_army"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false

local INI_SEF = false
local INI_VIVO = false
local INI_AUX = false
local ID_WEAPON = "weapon_stalker2_medkit_army"
local ID_PRIMARYAMMO = "medkit_army"

function SWEP:Initialize()
    self:SetHoldType("slam")
	
	local FilePathSEF = "lua/SEF/SEF_Functions.lua"
    if file.Exists(FilePathSEF, "GAME") then
        INI_SEF = true
    end
	
	local FilePathVIVO = "lua/autorun/ojsshared.lua"
    if file.Exists(FilePathVIVO, "GAME") then
        INI_VIVO = true
    end
	
	local FilePathAUX = "lua/autorun/auxpower/core/power.lua"
    if file.Exists(FilePathAUX, "GAME") then
        INI_AUX = true
    end
end 

function SWEP:Deploy()
    local owner = self:GetOwner() 
	
	self:SendWeaponAnim(ACT_VM_IDLE)
	
	if owner:GetAmmoCount(self.Primary.Ammo) == 0 then -- Strip Fallback 	
		owner:StripWeapon(ID_WEAPON)
		owner:SelectWeapon(owner:GetPreviousWeapon())
	end
	
	timer.Simple(0.05, function()
        if IsValid(self) and IsValid(self.Owner) then
            local vm = self.Owner:GetViewModel()
            if IsValid(vm) then
                vm:SetSkin(1) 
            end
        end
    end)
	
	---------- Start Consumable ----------
	self.Consuming = 1
	self:InitializeConsumable()
	--------------------------------------
	return true
end

function SWEP:InitializeConsumable()
    local owner = self:GetOwner()
    if not IsValid(owner) or not owner:IsPlayer() then return end

    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	local SequenceDuration = self:SequenceDuration()
	
	timer.Simple(SequenceDuration * 0.3, function() -- Audio.
        if IsValid(owner) and owner:Alive() then
			owner:EmitSound("Stalker2.Healing")
        end
    end)

    timer.Simple(SequenceDuration * 0.4, function() -- Call item effects.
        if IsValid(owner) and owner:Alive() then
			self:Heal(owner)
        end
    end)

    timer.Simple(SequenceDuration, function() -- End of logic, strip weapon.
        if IsValid(owner) and owner:Alive() then
            self.Consuming = 0
			
			if owner:GetAmmoCount(self.Primary.Ammo) == 0 then 	
				owner:StripWeapon(ID_WEAPON)
			end
			if SERVER then owner:SelectWeapon(owner:GetPreviousWeapon()) end
        end
    end)
end

function SWEP:Heal(owner)
	if IsValid(owner) and owner:GetActiveWeapon():GetClass() == ID_WEAPON then
	
		if INI_SEF == true and SERVER then
			owner:ApplyEffect("Healing", 2.8, 1, 0.02)
			owner:ApplyEffect("TempShield", 40, 25)
			owner:ApplyEffect("Energized", 2, 1, 0.07)
		end
		
		if INI_AUX == true then
			AUXPOW:SetPower(owner, math.min(AUXPOW:GetPower(owner) + 0.2, 1));
		end
		
		if INI_VIVO == true then
		end
	end
	owner:RemoveAmmo(1, ID_PRIMARYAMMO) 
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Think()
end

function SWEP:Holster()
	if self.Consuming == 1 then return end
	return true
end

function SWEP:PostDrawViewModel( vm )
    local attachment = vm:GetAttachment(1)
    if attachment then
        self.vmcamera = vm:GetAngles() - attachment.Ang
    else
        self.vmcamera = Angle(0, 0, 0) 
    end
end

function SWEP:CalcView( ply, pos, ang, fov )
	self.vmcamera = self.vmcamera or Angle(0, 0, 0)  
    return pos, ang + self.vmcamera, fov
end

if CLIENT then -- Worldmodel offset
	local WorldModel = ClientsideModel(SWEP.WorldModel)

	WorldModel:SetSkin(1)
	WorldModel:SetNoDraw(true)

	function SWEP:DrawWorldModel()
		local owner = self:GetOwner()

		if (IsValid(owner)) then
			local offsetVec = Vector(3, -2, -1)
			local offsetAng = Angle(-90, -0, -90)
			
			local boneid = owner:LookupBone("ValveBiped.Bip01_R_Hand") -- Right Hand
			if !boneid then return end

			local matrix = owner:GetBoneMatrix(boneid)
			if !matrix then return end

			local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())

			WorldModel:SetPos(newPos)
			WorldModel:SetAngles(newAng)

            WorldModel:SetupBones()
		else
			
			WorldModel:SetPos(self:GetPos())
			WorldModel:SetAngles(self:GetAngles())
			self:DrawModel()
		end

		WorldModel:DrawModel()

	end
end