if CLIENT then 
    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/hud/vgui_afak" )
	SWEP.BounceWeaponIcon = true 
    SWEP.DrawWeaponInfoBox = true
end

SWEP.PrintName = "Vodka"
SWEP.Author = "Craft_Pig"
SWEP.Purpose = 
[[
Heals up to 30HP
Cures Bleeding
]]
SWEP.Category = "S.T.A.L.K.E.R. 2"
-- SWEP.Category1 = "EFT"
-- SWEP.Category2 = "Medkits"

SWEP.ViewModelFOV = 70
SWEP.ViewModel = "models/weapons/sweps/stalker2/vodka/v_item_vodka.mdl"
SWEP.WorldModel = "models/weapons/sweps/stalker2/vodka/w_item_vodka.mdl"
SWEP.UseHands = true
SWEP.DrawCrosshair = false 

SWEP.Spawnable = true
SWEP.Slot = 5
SWEP.SlotPos = 7
SWEP.DrawAmmo = true
SWEP.AutoSwitchFrom = false

SWEP.SwayScale = 0.15
SWEP.BobScale = 0.75

SWEP.Primary.Ammo = "vodka"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

local INI_SEF = false
local INI_VIVO = false
local ID_WEAPON = "weapon_stalker2_vodka"
local ID_PRIMARYAMMO = "vodka"

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
	
	self.IniAnim = 0
	self.FrameTimes = 0
	
	if SERVER then
		if self.IniAnim == 0 then self:PrimaryAttack() end
		
		if owner:GetAmmoCount(self.Primary.Ammo) == 0 then 	
				owner:StripWeapon(ID_WEAPON)
				owner:SelectWeapon(owner:GetPreviousWeapon())
		end
	end
	return true
end

function SWEP:Heal(owner)
	local owner = self:GetOwner() 
	if IsValid(owner) and SERVER and owner:GetActiveWeapon():GetClass() == ID_WEAPON then
		if INI_SEF == true then
			owner:ApplyEffect("Tenacity", 3, 50)
		end
		if INI_AUX == true then
			AUXPOW:SetPower(owner, math.min(AUXPOW:GetPower(owner) - 0.6, 1));
		end
	end
	owner:SetNWFloat("SaturationEffectStart", CurTime())
    owner:SetNWFloat("SaturationEffectDuration", 20)
    owner:SetNWFloat("SaturationEffectStrength", 0.6)
	
	owner:EmitSound("Stalker2.Drink")
	owner:SetAnimation(PLAYER_ATTACK1)
	owner:RemoveAmmo(1, ID_PRIMARYAMMO)    
end

function SWEP:PrimaryAttack()
    local owner = self.Owner
	if self.IniAnim == 1 then return end
	
	self.IniAnim = 1
	
	-- self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	
	local vm = owner:GetViewModel()
	vm:SetSequence(vm:LookupSequence("use"))  -- Play the sequence
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end

function SWEP:SecondaryAttack()
	local owner = self:GetOwner() 
end

function SWEP:Think()
	local owner = self.Owner
	local vm = owner:GetViewModel()
	
	if SERVER then
		if vm:LookupSequence("use") then
			self.FrameTimes = self.FrameTimes + 1
			if self.FrameTimes == 100 * 2 then
				self:Heal(owner)
			end
		end
	end
	
	if self.IniAnim == 1 and self.IdleTimer <= CurTime() then
		self:HolsterPrevious(owner)
	end
end

function SWEP:HolsterPrevious(owner)
	local owner = self:GetOwner() 
	if SERVER then
		if owner:GetAmmoCount(self.Primary.Ammo) == 0 then 
			owner:StripWeapon(ID_WEAPON)
			owner:SelectWeapon(owner:GetPreviousWeapon())
		else
			owner:SelectWeapon(owner:GetPreviousWeapon())
		end
	end
end

function SWEP:Holster()
	if self.Owner:GetAmmoCount(self.Primary.Ammo) == 0 then return end
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

if CLIENT then
	    hook.Add("RenderScreenspaceEffects", "Hook_VodkaSaturationBoost", function()
        local ply = LocalPlayer()
        local startTime = ply:GetNWFloat("SaturationEffectStart", 0)
        local duration = ply:GetNWFloat("SaturationEffectDuration", 0)
        local strength = ply:GetNWFloat("SaturationEffectStrength", 0)

        if CurTime() < startTime + duration then
            local elapsed = CurTime() - startTime
            local fadeOut = math.Clamp(1 - (elapsed / duration), 0, 1)
            local saturation = strength * fadeOut

            DrawColorModify({
                ["$pp_colour_contrast"] = 1,
                ["$pp_colour_colour"] = 1 + saturation,
                ["$pp_colour_brightness"] = 0,
                ["$pp_colour_mulr"] = 0 + saturation,
                ["$pp_colour_mulg"] = 0 + saturation,
                ["$pp_colour_mulb"] = 0 + saturation
            })
        end
    end)
	
	local WorldModel = ClientsideModel(SWEP.WorldModel)

	WorldModel:SetSkin(0)
	WorldModel:SetNoDraw(true)

	function SWEP:DrawWorldModel()
		local owner = self:GetOwner()

		if (IsValid(owner)) then
			local offsetVec = Vector(3, -4, 3)
			local offsetAng = Angle(-0, -0, -180)
			
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