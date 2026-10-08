Config = {}

-- ============================================================
-- FRAMEWORK & WHITELIST
-- ============================================================

-- Framework utilise pour recuperer le job du joueur (whitelist ci-dessous).
-- Valeurs possibles : 'auto', 'esx', 'qbcore', 'qbox', 'standalone'.
-- 'auto' detecte la resource demarree (es_extended / qbx_core / qb-core) au chargement.
-- En 'standalone' (ou si aucun framework n'est detecte), personne n'est whitelist par job.
Config.Framework = 'auto'

-- Liste des jobs qui ne sont pas impactes par le portique
Config.WhitelistedJobs = {
    'police',
}

-- ============================================================
-- DETECTION
-- ============================================================

-- Distance autour du prop ou le detecteur se declenche
Config.TriggerDistance = 1.6

-- Intervalle de scan (ms)
Config.ScanInterval = 250

-- Liste des props de portique metal detector (noms de modeles GTA)
Config.DetectorProps = {
    'ch_prop_ch_metal_detector_01a'
}

-- ============================================================
-- ALARME & SON
-- ============================================================

-- Cooldown entre deux sonneries pour le meme joueur (ms)
Config.AlarmCooldown = 3500

-- Son de l'alarme (PlaySoundFrontend)
-- Autres exemples : 'TIMER_STOP' + set 'HUD_MINI_GAME_SOUNDSET' ; 'CHECKPOINT_MISSED' + 'HUD_MINI_GAME_SOUNDSET'
Config.Sound = {
    name = '10_SEC_WARNING',
    set = 'HUD_MINI_GAME_SOUNDSET'
}

-- Repeter le son plusieurs fois (delai en ms entre chaque lecture). 1 = une seule fois.
Config.SoundRepeatCount = 2
Config.SoundRepeatDelay = 800

-- Distance (m) : les joueurs dans ce rayon autour du portique entendent l'alarme (diffusion serveur).
Config.SoundHearDistance = 10.0

-- ============================================================
-- ITEMS DETECTES
-- ============================================================

--[[
    Noms ox_inventory : weapon_* , ammo-* .
    Armes exclues : ball, snowball, candycane, golfclub, poolcue, bottle, WEAPON_METALDETECTOR.
]]
Config.DetectedItems = {
    'weapon_advancedrifle',
    'weapon_appistol',
    'weapon_assaultrifle',
    'weapon_assaultrifle_mk2',
    'weapon_assaultshotgun',
    'weapon_assaultsmg',
    'weapon_autoshotgun',
    'weapon_bat',
    'weapon_battleaxe',
    'weapon_bullpuprifle',
    'weapon_bullpuprifle_mk2',
    'weapon_bullpupshotgun',
    'weapon_bzgas',
    'weapon_carbinerifle',
    'weapon_carbinerifle_mk2',
    'weapon_ceramicpistol',
    'weapon_combatmg',
    'weapon_combatmg_mk2',
    'weapon_combatpdw',
    'weapon_combatpistol',
    'weapon_combatshotgun',
    'weapon_compactlauncher',
    'weapon_compactrifle',
    'weapon_crowbar',
    'weapon_dagger',
    'weapon_dbshotgun',
    'weapon_doubleaction',
    'weapon_emplauncher',
    'weapon_fertilizercan',
    'weapon_fireextinguisher',
    'weapon_firework',
    'weapon_flare',
    'weapon_flaregun',
    'weapon_flashlight',
    'weapon_gadgetpistol',
    'weapon_grenade',
    'weapon_grenadelauncher',
    'weapon_gusenberg',
    'weapon_hammer',
    'weapon_hatchet',
    'weapon_hazardcan',
    'weapon_heavypistol',
    'weapon_heavyrifle',
    'weapon_heavyshotgun',
    'weapon_heavysniper',
    'weapon_heavysniper_mk2',
    'weapon_hominglauncher',
    'weapon_knife',
    'weapon_knuckle',
    'weapon_machete',
    'weapon_machinepistol',
    'weapon_marksmanpistol',
    'weapon_marksmanrifle',
    'weapon_marksmanrifle_mk2',
    'weapon_mg',
    'weapon_microsmg',
    'weapon_militaryrifle',
    'weapon_minigun',
    'weapon_minismg',
    'weapon_molotov',
    'weapon_musket',
    'weapon_navyrevolver',
    'weapon_nightstick',
    'weapon_petrolcan',
    'weapon_pipebomb',
    'weapon_pistol',
    'weapon_pistol50',
    'weapon_pistol_mk2',
    'weapon_precisionrifle',
    'weapon_proxmine',
    'weapon_pumpshotgun',
    'weapon_pumpshotgun_mk2',
    'weapon_railgun',
    'weapon_railgunxm3',
    'weapon_raycarbine',
    'weapon_rayminigun',
    'weapon_raypistol',
    'weapon_revolver',
    'weapon_revolver_mk2',
    'weapon_rpg',
    'weapon_sawnoffshotgun',
    'weapon_smg',
    'weapon_smg_mk2',
    'weapon_smokegrenade',
    'weapon_sniperrifle',
    'weapon_snowlauncher',
    'weapon_snspistol',
    'weapon_snspistol_mk2',
    'weapon_specialcarbine',
    'weapon_specialcarbine_mk2',
    'weapon_stickybomb',
    'weapon_stone_hatchet',
    'weapon_stungun',
    'weapon_switchblade',
    'weapon_teargas',
    'weapon_tecpistol',
    'weapon_vintagepistol',
    'weapon_wrench',

    -- Munitions (section Ammo de weapons.json)
    'ammo-22',
    'ammo-38',
    'ammo-44',
    'ammo-45',
    'ammo-50',
    'ammo-9',
    'ammo-emp',
    'ammo-firework',
    'ammo-flare',
    'ammo-grenade',
    'ammo-heavysniper',
    'ammo-laser',
    'ammo-musket',
    'ammo-railgun',
    'ammo-rifle',
    'ammo-rifle2',
    'ammo-rocket',
    'ammo-shotgun',
    'ammo-sniper',
}
