Settings = {}
Settings.DebugLocation = true --Used for setting certain location for easy teleport
Settings.OpenWithKey = true --Use F5 to open menu

--[[
    TELEPORT MENU LOCALE
    You can change notification messages based on your language
]]--

Locale = {
    ['teleported']  = 'Teleportovani ste do ~b~',
    ['teleported_last']  = 'You have teleported to ~r~Last Location',
    ['teleported_last_empty']  = 'You didn\'t visit any location with this menu.',
    ['teleported_debug']  = 'You have added ~y~Debug Location ~s~coordinates.',
    ['no_waypoint']  = 'Niste oznacili gdje zelite bit teleportovani!',
        ['will_spawn']  = 'Vase vozilo ce se uskoro stvoriti',
}

--[[
    TELEPORT MENU COORDINATES
    Below you have lines of code that you need to change based on your use
    LABEL - label of location that you can find in menu
    OTHER lines are the actual coordinates
]]--

Locations = {
    { label = 'Cayo Perico', x = 5265.77, y = -5427.41, z = 141.05  },
    { label = 'Track Race', x = 1018.91, y = -83.51, z = 81.84  },
    { label = 'Zlatara', x = -633.77, y = -239.26, z = 38.01  },
    { label = 'Krov od Maze Banke',  x = -75.20, y = -818.95, z = 326.18 },
    { label = 'Glavna Banka', x = 225.61, y = 213.24, z = 105.55  },
    { label = 'Nosac Aviona',  x = 3058.85, y = -4720.27, z = 15.26},
    { label = 'Paletto Banka', x = -112.45, y = 6461.30, z = 31.47  },
    { label = 'Aerodrom Los Santos', x = -1037.51, y = -2963.24, z = 13.95 },
    { label = 'Aerodrom Sandy Shores', x = 1718.47, y = 3254.40, z = 41.14},
    { label = 'Mount Chiliad', x = 501.76, y = 5604.28, z = 797.91},
    { label = 'Vinewood Znak', x = 663.41, y = 1217.21, z = 322.94},
    { label = 'Bennys Mehanicar', x = -205.73, y = -1303.71, z = 31.24 },
    { label = 'LS Customs Mehanicar', x = -360.91, y = -129.46, z = 38.70 },
    { label = 'Policijska Stanica', x = 425.1, y = -979.5, z = 30.7  }
}

Weapons = {
    { label = 'AP PISTOLJ', weapon = 'weapon_appistol'  },
    { label = 'PISTOLJ', weapon = 'weapon_pistol'  },
    { label = 'COMBAT PISTOLJ', weapon = 'weapon_combatpistol'  },
    { label = 'PECKA', weapon = 'weapon_pistol50'  },
    { label = 'TAZER', weapon = 'weapon_stungun'  },
    { label = 'REVOLVER', weapon = 'weapon_revolver_mk2'  },
    { label = 'MICRO SMG', weapon = 'weapon_microsmg'  },
    { label = 'SMG', weapon = 'weapon_smg'  },
    { label = 'SMG MK 2', weapon = 'weapon_smg_mk2'  },
    { label = 'ASSAULT SMG', weapon = 'weapon_assaultsmg'  },
    { label = 'COMBAT PDW', weapon = 'weapon_combatpdw'  },
    { label = 'MACHINE PISTOLJ', weapon = 'weapon_machinepistol'  },
    { label = 'MINI SMG', weapon = 'weapon_minismg'  },
    { label = 'PUMPGUN', weapon = 'weapon_pumpshotgun'  },
    { label = 'TESKI PUMPGUN', weapon = 'weapon_heavyshotgun'  },
    { label = 'AK 47', weapon = 'weapon_assaultrifle'  },
    { label = 'AK 47 MK 2', weapon = 'weapon_assaultrifle_mk2'  },
    { label = 'KARABIN', weapon = 'weapon_carbinerifle'  },
    { label = 'SPECIAL KARABIN', weapon = 'weapon_specialcarbine'  },
    { label = 'KRATKI KALAS', weapon = 'weapon_compactrifle'  },
    { label = 'TAKTICNI KARABIN', weapon = 'weapon_tacticalrifle'  },
    { label = 'MG', weapon = 'weapon_combatmg'  },
    { label = 'SNAJPER', weapon = 'weapon_sniperrifle'  },
    { label = 'PADOBRAN', weapon = 'gadget_parachute'  }
}

Boats = {
    { label = 'DINGHY', value= 'dinghy'  },
    { label = 'DINGHY 2', value= 'dinghy2'  },
    { label = 'DINGHY 3', value= 'dinghy3'  },
    { label = 'DINGHY 4', value= 'dinghy4'  },
    { label = 'JET SKI', value= 'seashark3'  },
    { label = 'JACHTA', value= 'longfin'  }
}

Helicopters = {
    { label = 'CARGOBOB', value= 'cargobob'  },
    { label = 'FROGGER', value= 'frogger'  },
    { label = 'MAVERICK', value= 'maverick'  },
    { label = 'HAVOK', value= 'havok'  },
    { label = 'SWIFT', value= 'swift'  },
    { label = 'SWIFT 2', value= 'swift'  },
    { label = 'SUPERVOLITO', value= 'supervolito'  },
    { label = 'SUPERVOLITO 2', value= 'supervolito2'  },
    { label = 'Volatos', value= 'volatus'  }

}

Motorcycles = {
    { label = 'AKUMA', value= 'akuma'  },
    { label = 'CHOPPER', value= 'bagger'  },
    { label = 'OFF ROAD', value= 'bf400'  },
    { label = '3 TOCKAS', value= 'chimera'  },
    { label = 'DEATHBIKE', value= 'deathbike2'  },
    { label = 'NINJA', value= 'double'  },
    { label = 'SKUTER', value= 'faggio'  },
    { label = 'SKOK', value= 'hakuchou2'  };
    { label = 'QUAD', value= 'blazer5'  }
}

MuscleCars = {
    { label = 'DOMINATOR', value= 'dominator'  },
    { label = 'DOMINATOR NOVI', value= 'dominator§'  },
    { label = 'DUKES', value= 'dukes2'  },
    { label = '3 TOCKAS', value= 'chimera'  },
    { label = 'DEATHBIKE', value= 'deathbike2'  },
    { label = 'BUGATTI STARI', value= 'ztype'  };
    { label = 'BUGATTI STARIJI', value= 'hotknife'  }
}

OtherVehicles = {
    { label = 'MONSTER TRUCK', value= 'monster5'  },
    { label = 'FORMULA', value= 'openwheel2'  }
}

Planes = {
    { label = 'AVION', value= 'cuban800'  };
    { label = 'STUNT', value= 'stunt'  }
}

Suv = {
    { label = 'HUMMER', value= 'patriot'  };
    { label = 'BENTLEY', value= 'huntley'  },
    { label = 'G KLASA', value= 'dubsta2'  }
}

Sedans = {
    { label = 'ROLLS ROYCE', value= 'superd'  };
    { label = 'AUDI', value= 'tailgater2'  },
    { label = 'TEMPCAR', value= 'asterope'  };
    { label = 'SULTAN', value= 'sultan3'  }
}

Sports = {
    { label = 'FERRARI', value= 'bestiagts'  };
    { label = 'PORSCHE STARI', value= 'comet3'  },
    { label = 'PORSCHE', value= 'comet5'  },
    { label = 'CORVETTE', value= 'coquette4'  },
    { label = 'NISSAN', value= 'flashgt'  },
    { label = 'AUDI R8', value= 'ninef2'  },
    { label = 'BENTLEY', value= 'paragon2'  },
    { label = 'AMG', value= 'schlagen'  },
    { label = 'NISSAN', value= 'jester4'  }
}

SuperSports = {
    { label = 'BUGATTI', value= 'adder'  };
    { label = 'LAMBORGHINI', value= 'autarch'  },
    { label = 'PORSCHE', value= 'entity2'  },
    { label = 'AVENTADOR', value= 'reaper'  },
    { label = 'X80 PROTO', value= 'prototipo'  },
    { label = 'FERRARI', value= 'turismor'  },
    { label = 'JET AUTO', value= 'voltic2'  }
}



if Settings.OpenWithKey then
    RegisterCommand('menu', function()
        TriggerServerEvent('tpmenu:TriggerMenu')
    end, false)

    RegisterKeyMapping('menu', 'Glavni meni', 'keyboard', 'm')
end