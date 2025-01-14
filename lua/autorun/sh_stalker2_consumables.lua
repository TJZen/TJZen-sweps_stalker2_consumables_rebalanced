AddCSLuaFile()

--[[
-----------------------------------------------------------------------------------------------------
Subcategories
-----------------------------------------------------------------------------------------------------
]]
-- list.Set("WeaponTreeIcons", "EFT", "logo16/logo_eftmedkit_16.png")
-- list.Set("WeaponTreeIcons", "EFT.Drugs", "logo16/logo_eftdrug_16.png")
-- list.Set("WeaponTreeIcons", "EFT.Stimulants", "logo16/logo_eftstim_16.png")
-- list.Set("WeaponTreeIcons", "EFT.Medkits", "logo16/logo_eftmedkit_16.png")
-- list.Set("WeaponTreeIcons", "EFT.Injury Treatment", "logo16/logo_eftinjury_16.png")

-- list.Set("WeaponTreeThumbnails", "EFT.Drugs", "entities/weapon_eft_augmentin.png")
-- list.Set("WeaponTreeThumbnails", "EFT.Stimulants", "entities/weapon_eft_injectoradrenaline.png")
-- list.Set("WeaponTreeThumbnails", "EFT.Medkits", "entities/weapon_eft_afak.png")
-- list.Set("WeaponTreeThumbnails", "EFT.Injury Treatment", "entities/weapon_eft_surgicalkit.png")

--[[
-----------------------------------------------------------------------------------------------------
Particle Cache
-----------------------------------------------------------------------------------------------------
]]
-- if CLIENT then
   -- game.AddParticles("particles/ep2/antlion_gib_02.pcf")
   
   -- PrecacheParticleSystem("antlion_gib_02_slime")
   -- PrecacheParticleSystem("antlion_gib_02_juice")
-- end

--[[
-----------------------------------------------------------------------------------------------------
Convars
-----------------------------------------------------------------------------------------------------
]]

-- if CLIENT then
	-- CreateClientConVar("cl_eftmeds_quick", "0", true, false)
-- end
-- concommand.Add("use_stalker2_alcohol", function(ply, cmd, args)
    -- if not IsValid(ply) or not ply:IsPlayer() then return end
	-- if ply:GetAmmoCount("vodka") > 0 then
		-- if ply:HasWeapon("weapon_stalker2_vodka") then
			-- ply:SelectWeapon("weapon_stalker2_vodka")
		-- else
			-- ply:Give("weapon_stalker2_vodka")
			-- ply:SelectWeapon("weapon_stalker2_vodka")
		-- end
	-- end
-- end)
--[[
-----------------------------------------------------------------------------------------------------
Ammo Tables
-----------------------------------------------------------------------------------------------------
]]

game.AddAmmoType( {
name = "water",
} )
game.AddAmmoType( {
name = "bread",
} )
game.AddAmmoType( {
name = "vodka",
} )
game.AddAmmoType( {
name = "milk",
} )

--[[
-----------------------------------------------------------------------------------------------------
Sound Tables
-----------------------------------------------------------------------------------------------------
]]

----------------------------------------------------------------------------------------------------- Cloth
sound.Add( {
    name = "Stalker2.ClothGeneric",
    channel = CHAN_STATIC,
    volume = 0.4,
    level = 65,
    pitch = {95, 100},
    sound = {
        "weapons/stalker2/cloth/short/SFX_PlayerClothes_01.mp3",
		"weapons/stalker2/cloth/short/SFX_PlayerClothes_02.mp3",
		"weapons/stalker2/cloth/short/SFX_PlayerClothes_03.mp3",
		"weapons/stalker2/cloth/short/SFX_PlayerClothes_04.mp3",
		"weapons/stalker2/cloth/short/SFX_PlayerClothes_05.mp3",
		"weapons/stalker2/cloth/short/SFX_PlayerClothes_06.mp3",
		"weapons/stalker2/cloth/short/SFX_PlayerClothes_07.mp3",
		"weapons/stalker2/cloth/short/SFX_PlayerClothes_08.mp3",
		"weapons/stalker2/cloth/short/SFX_PlayerClothes_09.mp3",
    }
} )

----------------------------------------------------------------------------------------------------- Vodka
sound.Add( {
    name = "Stalker2.VodkaOn",
    channel = CHAN_BODY,
    volume = 0.5,
    level = 65,
    pitch = {95, 100},
    sound = {
        "weapons/stalker2/vodka/SFX_Vodka_CapOn_01.mp3",
		"weapons/stalker2/vodka/SFX_Vodka_CapOn_02.mp3",
		"weapons/stalker2/vodka/SFX_Vodka_CapOn_03.mp3",
    }
} )
sound.Add( {
    name = "Stalker2.VodkaOff",
    channel = CHAN_BODY,
    volume = 0.5,
    level = 65,
    pitch = {95, 100},
    sound = {
        "weapons/stalker2/vodka/SFX_Vodka_Cap_01.mp3",
		"weapons/stalker2/vodka/SFX_Vodka_Cap_02.mp3",
		"weapons/stalker2/vodka/SFX_Vodka_Cap_03.mp3",
    }
} )
sound.Add( {
    name = "Stalker2.VodkaScrew",
    channel = CHAN_BODY,
    volume = 0.5,
    level = 65,
    pitch = {95, 100},
    sound = {
        "weapons/stalker2/vodka/SFX_Vodka_Screw_01.mp3",
		"weapons/stalker2/vodka/SFX_Vodka_Screw_02.mp3",
		"weapons/stalker2/vodka/SFX_Vodka_Screw_03.mp3",
		"weapons/stalker2/vodka/SFX_Vodka_Screw_04.mp3",
		"weapons/stalker2/vodka/SFX_Vodka_Screw_05.mp3",
		"weapons/stalker2/vodka/SFX_Vodka_Screw_06.mp3",
    }
} )

----------------------------------------------------------------------------------------------------- Drink
sound.Add( {
    name = "Stalker2.Liquid",
    channel = CHAN_BODY,
    volume = 0.5,
    level = 65,
    pitch = {95, 100},
    sound = {
        "weapons/stalker2/drink/SFX_Vodka_Liquid_01.mp3",
		"weapons/stalker2/drink/SFX_Vodka_Liquid_02.mp3",
		"weapons/stalker2/drink/SFX_Vodka_Liquid_03.mp3",
		"weapons/stalker2/drink/SFX_Vodka_Liquid_04.mp3",
		"weapons/stalker2/drink/SFX_Vodka_Liquid_05.mp3",
		"weapons/stalker2/drink/SFX_Vodka_Liquid_06.mp3",
		"weapons/stalker2/drink/SFX_Vodka_Liquid_07.mp3",
		"weapons/stalker2/drink/SFX_Vodka_Liquid_08.mp3",
    }
} )
sound.Add( {
    name = "Stalker2.Drink",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 100},
    sound = {
        "weapons/stalker2/drink/SFX_Consumables_Common_Drink_01.mp3",
		"weapons/stalker2/drink/SFX_Consumables_Common_Drink_02.mp3",
		"weapons/stalker2/drink/SFX_Consumables_Common_Drink_03.mp3",
		"weapons/stalker2/drink/SFX_Consumables_Common_Drink_04.mp3",
		"weapons/stalker2/drink/SFX_Consumables_Common_Drink_05.mp3",
		"weapons/stalker2/drink/SFX_Consumables_Common_Drink_06.mp3",
		"weapons/stalker2/drink/SFX_Consumables_Common_Drink_07.mp3",
		"weapons/stalker2/drink/SFX_Consumables_Common_Drink_08.mp3",
    }
} )

----------------------------------------------------------------------------------------------------- Beer
sound.Add( {
    name = "Stalker2.BeerOpen",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 100},
    sound = {
        "weapons/stalker2/drink/SFX_Consumables_BeerOpen.mp3",
    }
} )
sound.Add( {
    name = "Stalker2.BeerCapOff",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 100},
    sound = {
        "weapons/stalker2/drink/SFX_Consumables_Beer_CapOff.mp3",
    }
} )

----------------------------------------------------------------------------------------------------- Bread
sound.Add( {
    name = "Stalker2.Bread",
    channel = CHAN_WEAPON,
    volume = 0.5,
    level = 65,
    pitch = {95, 100},
    sound = {
        "weapons/stalker2/bread/SFX_Consumables_Bread_Bite_01.mp3",
		"weapons/stalker2/bread/SFX_Consumables_Bread_Bite_02.mp3",
		"weapons/stalker2/bread/SFX_Consumables_Bread_Bite_03.mp3",
		"weapons/stalker2/bread/SFX_Consumables_Bread_Bite_04.mp3",
		"weapons/stalker2/bread/SFX_Consumables_Bread_Bite_05.mp3",
		"weapons/stalker2/bread/SFX_Consumables_Bread_Bite_06.mp3",
    }
} )
----------------------------------------------------------------------------------------------------- Drink
sound.Add( {
    name = "Stalker2.Milk",
    channel = CHAN_WEAPON,
    volume = 1,
    level = 65,
    pitch = {95, 100},
    sound = {
        "weapons/stalker2/milk/SFX_Milk_Knife_1.ogg",
		"weapons/stalker2/milk/SFX_Milk_Knife_2.ogg",
		"weapons/stalker2/milk/SFX_Milk_Knife_3.ogg",
    }
} )