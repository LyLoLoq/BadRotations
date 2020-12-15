local br = _G["br"]
local rotationName = "Lylo"

local function createToggles()
    RotationModes = {
        [1] = {
            mode = "Auto",
            value = 1,
            overlay = "Automatic Rotation",
            tip = "Swaps between Single and Multiple based on number of targets in range.",
            highlight = 1,
            icon = br.player.spell.tigerPalm
        },
        [2] = {
            mode = "Mult",
            value = 2,
            overlay = "Multiple Target Rotation",
            tip = "Multiple target rotation used.",
            highlight = 0,
            icon = br.player.spell.spinningCraneKick
        },
        [3] = {
            mode = "Sing",
            value = 3,
            overlay = "Single Target Rotation",
            tip = "Single target rotation used.",
            highlight = 0,
            icon = br.player.spell.tigerPalm
        },
        [4] = {
            mode = "Off",
            value = 4,
            overlay = "DPS Rotation Disabled",
            tip = "Disable DPS Rotation",
            highlight = 0,
            icon = br.player.spell.vivify
        }
    }
    CreateButton("Rotation", 1, 0)
end

local function createOptions()
    local optionTable

    local function rotationOptions()
        local section
        ----------------------
        --- TOGGLE OPTIONS ---
        ----------------------
        section = br.ui:createSection(br.ui.window.profile, "Toggle Keys")
        -- Single/Multi Toggle
        br.ui:createDropdownWithout(section, "Rotation Mode", br.dropOptions.Toggle, 4)
        -- Pause Toggle
        br.ui:createDropdown(section, "Pause Mode", br.dropOptions.Toggle, 6)
        br.ui:checkSectionState(section)
    end
    optionTable = {
        {
            [1] = "Rotation Options",
            [2] = rotationOptions
        }
    }
    return optionTable
end

local function runRotation()
    local talent                                        = br.player.talent
    local covenant                                      = br.player.covenant
    local conduit                                       = br.player.conduit

    -- Current: https://github.com/simulationcraft/simc/blob/shadowlands/profiles/Tier26/T26_Monk_Windwalker.simc
    -- 41961f70633085ce324bec771e64f62aa8ddcaa0

    -- Recomended Talents: 3020012
    if not talent.chiBurst then
        Print("You are not using the recomended talent: Chi Burst")
    end
    if not talent.fistOfTheWhiteTiger then
        Print("You are not using the recomended talent: Fist of the White Tiger")
    end
    if not talent.hitCombo then
        Print("You are not using the recomended talent: Hit Combo")
    end
    if not talent.whirlingDragonPunch then
        Print("You are not using the recomended talent: Whirling Dragon Punch")
    end
    -- Recomended Covenant: kyrian
    if not covenant.kyrian then
        Print("You are not using the recomended covenant: kyrian")
    end
    -- Recomended Soulbind: pelagos,combat_meditation/strike_with_clarity:7/focusing_mantra/harm_denial:7/cleansed_vestments/xuens_bond:7/let_go_of_the_past
    if not conduit.combatMeditation.enabled then
        Print("You are not using the recomended conduit: Combat Meditation")
    end
    if not conduit.strikeWithClarity.enabled then
        Print("You are not using the recomended conduit: Strike With Clarity")
    end
    if not conduit.focusingMantra.enabled then
        Print("You are not using the recomended conduit: Focusing Mantra")
    end
    if not conduit.harmDenial.enabled then
        Print("You are not using the recomended conduit: Harm Denial")
    end
    if not conduit.cleansedVestments.enabled then
        Print("You are not using the recomended conduit: Cleansed Vestments")
    end
    if not conduit.xuensBond.enabled then
        Print("You are not using the recomended conduit: Xuen's Bond")
    end
    if not conduit.letGoOfThePast.enabled then
        Print("You are not using the recomended conduit: Let Go of the Past")
    end

    -- Default consumables
    -- potion=potion_of_spectral_agility
    local potion = 171270
    -- flask=spectral_flask_of_power
    local flask = 171276
    -- food=feast_of_gluttonous_hedonism
    local food = 172043
    -- augmentation=veiled
    local augmentation = 181468
    -- temporary_enchant=main_hand:shaded_weightstone/off_hand:shaded_weightstone

    -- actions.precombat=flask
    -- actions.precombat+=/food
    -- actions.precombat+=/augmentation
    -- actions.precombat+=/snapshot_stats
    -- actions.precombat+=/potion
    -- actions.precombat+=/variable,name=xuen_on_use_trinket,op=set,value=0
    -- actions.precombat+=/chi_burst
    -- actions.precombat+=/chi_wave,if=!talent.energizing_elixir.enabled
    
    -- # Executed every time the actor is available.
    -- actions=auto_attack
    -- actions+=/spear_hand_strike,if=target.debuff.casting.react
    -- actions+=/variable,name=hold_xuen,op=set,value=cooldown.invoke_xuen_the_white_tiger.remains>fight_remains|fight_remains<120&fight_remains>cooldown.serenity.remains&cooldown.serenity.remains>10
    -- actions+=/potion,if=(buff.serenity.up|buff.storm_earth_and_fire.up)&pet.xuen_the_white_tiger.active|fight_remains<=60
    -- actions+=/call_action_list,name=serenity,if=buff.serenity.up
    -- actions+=/call_action_list,name=weapons_of_order,if=buff.weapons_of_order.up
    -- actions+=/call_action_list,name=opener,if=time<4&chi<5&!pet.xuen_the_white_tiger.active
    -- actions+=/fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=3&(energy.time_to_max<1|energy.time_to_max<4&cooldown.fists_of_fury.remains<1.5|cooldown.weapons_of_order.remains<2)
    -- actions+=/expel_harm,if=chi.max-chi>=1&(energy.time_to_max<1|cooldown.serenity.remains<2|energy.time_to_max<4&cooldown.fists_of_fury.remains<1.5|cooldown.weapons_of_order.remains<2)
    -- actions+=/tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&chi.max-chi>=2&(energy.time_to_max<1|cooldown.serenity.remains<2|energy.time_to_max<4&cooldown.fists_of_fury.remains<1.5|cooldown.weapons_of_order.remains<2)
    -- actions+=/call_action_list,name=cd_sef,if=!talent.serenity.enabled
    -- actions+=/call_action_list,name=cd_serenity,if=talent.serenity.enabled
    -- actions+=/call_action_list,name=st,if=active_enemies<3
    -- actions+=/call_action_list,name=aoe,if=active_enemies>=3

    -- actions.aoe=whirling_dragon_punch
    -- actions.aoe+=/energizing_elixir,if=chi.max-chi>=2&energy.time_to_max>2|chi.max-chi>=4
    -- actions.aoe+=/spinning_crane_kick,if=(!talent.hit_combo.enabled&conduit.calculated_strikes.enabled|combo_strike)&(buff.dance_of_chiji.up|debuff.bonedust_brew.up)
    -- actions.aoe+=/fists_of_fury,if=energy.time_to_max>execute_time|chi.max-chi<=1
    -- actions.aoe+=/rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=(talent.whirling_dragon_punch.enabled&cooldown.rising_sun_kick.duration>cooldown.whirling_dragon_punch.remains+4)&(cooldown.fists_of_fury.remains>3|chi>=5)
    -- actions.aoe+=/rushing_jade_wind,if=buff.rushing_jade_wind.down
    -- actions.aoe+=/spinning_crane_kick,if=(!talent.hit_combo.enabled&conduit.calculated_strikes.enabled|combo_strike)&((cooldown.bonedust_brew.remains>2&(chi>3|cooldown.fists_of_fury.remains>6)&(chi>=5|cooldown.fists_of_fury.remains>2))|energy.time_to_max<=3)
    -- actions.aoe+=/expel_harm,if=chi.max-chi>=1
    -- actions.aoe+=/fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=3
    -- actions.aoe+=/chi_burst,if=chi.max-chi>=2
    -- actions.aoe+=/crackling_jade_lightning,if=buff.the_emperors_capacitor.stack>19&energy.time_to_max>execute_time-1&cooldown.fists_of_fury.remains>execute_time
    -- actions.aoe+=/tiger_palm,target_if=min:debuff.mark_of_the_crane.remains+(debuff.recently_rushing_tiger_palm.up*20),if=chi.max-chi>=2&(!talent.hit_combo.enabled|combo_strike)
    -- actions.aoe+=/chi_wave,if=combo_strike
    -- actions.aoe+=/flying_serpent_kick,if=buff.bok_proc.down,interrupt=1
    -- actions.aoe+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&(buff.bok_proc.up|talent.hit_combo.enabled&prev_gcd.1.tiger_palm&chi=2&cooldown.fists_of_fury.remains<3|chi.max-chi<=1&prev_gcd.1.spinning_crane_kick&energy.time_to_max<3)

    -- actions.cd_sef=invoke_xuen_the_white_tiger,if=!variable.hold_xuen|fight_remains<25
    -- actions.cd_sef+=/arcane_torrent,if=chi.max-chi>=1
    -- actions.cd_sef+=/touch_of_death,if=buff.storm_earth_and_fire.down&pet.xuen_the_white_tiger.active|fight_remains<10|fight_remains>180
    -- actions.cd_sef+=/weapons_of_order,if=(raid_event.adds.in>45|raid_event.adds.up)&cooldown.rising_sun_kick.remains<execute_time
    -- actions.cd_sef+=/faeline_stomp,if=combo_strike&(raid_event.adds.in>10|raid_event.adds.up)
    -- actions.cd_sef+=/fallen_order,if=raid_event.adds.in>30|raid_event.adds.up
    -- actions.cd_sef+=/bonedust_brew,if=raid_event.adds.in>50|raid_event.adds.up,line_cd=60
    -- actions.cd_sef+=/storm_earth_and_fire,if=cooldown.storm_earth_and_fire.charges=2|fight_remains<20|(raid_event.adds.remains>15|!covenant.kyrian&((raid_event.adds.in>cooldown.storm_earth_and_fire.full_recharge_time|!raid_event.adds.exists)&(cooldown.invoke_xuen_the_white_tiger.remains>cooldown.storm_earth_and_fire.full_recharge_time|variable.hold_xuen))&cooldown.fists_of_fury.remains<=9&chi>=2&cooldown.whirling_dragon_punch.remains<=12)
    -- actions.cd_sef+=/storm_earth_and_fire,if=covenant.kyrian&(buff.weapons_of_order.up|(fight_remains<cooldown.weapons_of_order.remains|cooldown.weapons_of_order.remains>cooldown.storm_earth_and_fire.full_recharge_time)&cooldown.fists_of_fury.remains<=9&chi>=2&cooldown.whirling_dragon_punch.remains<=12)
    -- actions.cd_sef+=/use_item,name=inscrutable_quantum_device
    -- actions.cd_sef+=/use_item,name=dreadfire_vessel
    -- actions.cd_sef+=/touch_of_karma,if=fight_remains>159|pet.xuen_the_white_tiger.active|variable.hold_xuen
    -- actions.cd_sef+=/blood_fury,if=cooldown.invoke_xuen_the_white_tiger.remains>30|variable.hold_xuen|fight_remains<20
    -- actions.cd_sef+=/berserking,if=cooldown.invoke_xuen_the_white_tiger.remains>30|variable.hold_xuen|fight_remains<15
    -- actions.cd_sef+=/lights_judgment
    -- actions.cd_sef+=/fireblood,if=cooldown.invoke_xuen_the_white_tiger.remains>30|variable.hold_xuen|fight_remains<10
    -- actions.cd_sef+=/ancestral_call,if=cooldown.invoke_xuen_the_white_tiger.remains>30|variable.hold_xuen|fight_remains<20
    -- actions.cd_sef+=/bag_of_tricks,if=buff.storm_earth_and_fire.down

    -- actions.cd_serenity=variable,name=serenity_burst,op=set,value=cooldown.serenity.remains<1|pet.xuen_the_white_tiger.active&cooldown.serenity.remains>30|fight_remains<20
    -- actions.cd_serenity+=/invoke_xuen_the_white_tiger,if=!variable.hold_xuen|fight_remains<25
    -- actions.cd_serenity+=/use_item,name=inscrutable_quantum_device
    -- actions.cd_serenity+=/use_item,name=dreadfire_vessel
    -- actions.cd_serenity+=/blood_fury,if=variable.serenity_burst
    -- actions.cd_serenity+=/berserking,if=variable.serenity_burst
    -- actions.cd_serenity+=/arcane_torrent,if=chi.max-chi>=1
    -- actions.cd_serenity+=/lights_judgment
    -- actions.cd_serenity+=/fireblood,if=variable.serenity_burst
    -- actions.cd_serenity+=/ancestral_call,if=variable.serenity_burst
    -- actions.cd_serenity+=/bag_of_tricks,if=variable.serenity_burst
    -- actions.cd_serenity+=/touch_of_death,if=fight_remains>180|pet.xuen_the_white_tiger.active|fight_remains<10
    -- actions.cd_serenity+=/touch_of_karma,if=fight_remains>90|pet.xuen_the_white_tiger.active|fight_remains<10
    -- actions.cd_serenity+=/weapons_of_order,if=cooldown.rising_sun_kick.remains<execute_time
    -- actions.cd_serenity+=/faeline_stomp
    -- actions.cd_serenity+=/fallen_order
    -- actions.cd_serenity+=/bonedust_brew
    -- actions.cd_serenity+=/serenity,if=cooldown.rising_sun_kick.remains<2|fight_remains<15
    -- actions.cd_serenity+=/bag_of_tricks

    -- actions.opener=fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=3
    -- actions.opener+=/expel_harm,if=talent.chi_burst.enabled&chi.max-chi>=3
    -- actions.opener+=/tiger_palm,target_if=min:debuff.mark_of_the_crane.remains+(debuff.recently_rushing_tiger_palm.up*20),if=combo_strike&chi.max-chi>=2
    -- actions.opener+=/chi_wave,if=chi.max-chi=2
    -- actions.opener+=/expel_harm
    -- actions.opener+=/tiger_palm,target_if=min:debuff.mark_of_the_crane.remains+(debuff.recently_rushing_tiger_palm.up*20),if=chi.max-chi>=2

    -- actions.serenity=fists_of_fury,if=buff.serenity.remains<1
    -- actions.serenity+=/use_item,name=inscrutable_quantum_device
    -- actions.serenity+=/use_item,name=dreadfire_vessel
    -- actions.serenity+=/spinning_crane_kick,if=(!talent.hit_combo.enabled&conduit.calculated_strikes.enabled|combo_strike)&(active_enemies>=3|active_enemies>1&!cooldown.rising_sun_kick.up)
    -- actions.serenity+=/rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike
    -- actions.serenity+=/fists_of_fury,if=active_enemies>=3
    -- actions.serenity+=/spinning_crane_kick,if=(!talent.hit_combo.enabled&conduit.calculated_strikes.enabled|combo_strike)&buff.dance_of_chiji.up
    -- actions.serenity+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=(combo_strike|!talent.hit_combo.enabled)&buff.weapons_of_order_ww.up&cooldown.rising_sun_kick.remains>2
    -- actions.serenity+=/fist_of_the_white_tiger,interrupt=1
    -- actions.serenity+=/spinning_crane_kick,if=(!talent.hit_combo.enabled&conduit.calculated_strikes.enabled|combo_strike)&debuff.bonedust_brew.up
    -- actions.serenity+=/fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi<3
    -- actions.serenity+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike|!talent.hit_combo.enabled
    -- actions.serenity+=/spinning_crane_kick

    -- actions.st=whirling_dragon_punch,if=raid_event.adds.in>cooldown.whirling_dragon_punch.duration*0.8|raid_event.adds.up
    -- actions.st+=/energizing_elixir,if=chi.max-chi>=2&energy.time_to_max>3|chi.max-chi>=4&(energy.time_to_max>2|!prev_gcd.1.tiger_palm)
    -- actions.st+=/spinning_crane_kick,if=(!talent.hit_combo.enabled&conduit.calculated_strikes.enabled|combo_strike)&buff.dance_of_chiji.up&(raid_event.adds.in>buff.dance_of_chiji.remains-2|raid_event.adds.up)
    -- actions.st+=/rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=cooldown.serenity.remains>1|!talent.serenity.enabled
    -- actions.st+=/fists_of_fury,if=(raid_event.adds.in>cooldown.fists_of_fury.duration*0.8|raid_event.adds.up)&(energy.time_to_max>execute_time-1|chi.max-chi<=1|buff.storm_earth_and_fire.remains<execute_time+1)|fight_remains<execute_time+1
    -- actions.st+=/crackling_jade_lightning,if=buff.the_emperors_capacitor.stack>19&energy.time_to_max>execute_time-1&cooldown.rising_sun_kick.remains>execute_time|buff.the_emperors_capacitor.stack>14&(cooldown.serenity.remains<5&talent.serenity.enabled|cooldown.weapons_of_order.remains<5&covenant.kyrian|fight_remains<5)
    -- actions.st+=/rushing_jade_wind,if=buff.rushing_jade_wind.down&active_enemies>1
    -- actions.st+=/fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi<3
    -- actions.st+=/expel_harm,if=chi.max-chi>=1
    -- actions.st+=/chi_burst,if=chi.max-chi>=1&active_enemies=1&raid_event.adds.in>20|chi.max-chi>=2&active_enemies>=2
    -- actions.st+=/chi_wave
    -- actions.st+=/tiger_palm,target_if=min:debuff.mark_of_the_crane.remains+(debuff.recently_rushing_tiger_palm.up*20),if=combo_strike&chi.max-chi>=2&buff.storm_earth_and_fire.down
    -- actions.st+=/spinning_crane_kick,if=buff.chi_energy.stack>30-5*active_enemies&buff.storm_earth_and_fire.down&(cooldown.rising_sun_kick.remains>2&cooldown.fists_of_fury.remains>2|cooldown.rising_sun_kick.remains<3&cooldown.fists_of_fury.remains>3&chi>3|cooldown.rising_sun_kick.remains>3&cooldown.fists_of_fury.remains<3&chi>4|chi.max-chi<=1&energy.time_to_max<2)|buff.chi_energy.stack>10&fight_remains<7
    -- actions.st+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&(talent.serenity.enabled&cooldown.serenity.remains<3|cooldown.rising_sun_kick.remains>1&cooldown.fists_of_fury.remains>1|cooldown.rising_sun_kick.remains<3&cooldown.fists_of_fury.remains>3&chi>2|cooldown.rising_sun_kick.remains>3&cooldown.fists_of_fury.remains<3&chi>3|chi>5|buff.bok_proc.up)
    -- actions.st+=/tiger_palm,target_if=min:debuff.mark_of_the_crane.remains+(debuff.recently_rushing_tiger_palm.up*20),if=combo_strike&chi.max-chi>=2
    -- actions.st+=/flying_serpent_kick,interrupt=1
    -- actions.st+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&cooldown.fists_of_fury.remains<3&chi=2&prev_gcd.1.tiger_palm&energy.time_to_50<1
    -- actions.st+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&energy.time_to_max<2&(chi.max-chi<=1|prev_gcd.1.tiger_palm)

    -- actions.weapons_of_order=call_action_list,name=cd_sef,if=!talent.serenity.enabled
    -- actions.weapons_of_order+=/call_action_list,name=cd_serenity,if=talent.serenity.enabled
    -- actions.weapons_of_order+=/energizing_elixir,if=chi.max-chi>=2&energy.time_to_max>3
    -- actions.weapons_of_order+=/rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains
    -- actions.weapons_of_order+=/spinning_crane_kick,if=(!talent.hit_combo.enabled&conduit.calculated_strikes.enabled|combo_strike)&buff.dance_of_chiji.up
    -- actions.weapons_of_order+=/fists_of_fury,if=active_enemies>=2&buff.weapons_of_order_ww.remains<1
    -- actions.weapons_of_order+=/whirling_dragon_punch,if=active_enemies>=2
    -- actions.weapons_of_order+=/spinning_crane_kick,if=(!talent.hit_combo.enabled&conduit.calculated_strikes.enabled|combo_strike)&active_enemies>=3&buff.weapons_of_order_ww.up
    -- actions.weapons_of_order+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&active_enemies<=2
    -- actions.weapons_of_order+=/whirling_dragon_punch
    -- actions.weapons_of_order+=/fists_of_fury,interrupt=1,if=buff.storm_earth_and_fire.up&raid_event.adds.in>cooldown.fists_of_fury.duration*0.6
    -- actions.weapons_of_order+=/spinning_crane_kick,if=buff.chi_energy.stack>30-5*active_enemies
    -- actions.weapons_of_order+=/fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi<3
    -- actions.weapons_of_order+=/expel_harm,if=chi.max-chi>=1
    -- actions.weapons_of_order+=/chi_burst,if=chi.max-chi>=(1+active_enemies>1)
    -- actions.weapons_of_order+=/tiger_palm,target_if=min:debuff.mark_of_the_crane.remains+(debuff.recently_rushing_tiger_palm.up*20),if=(!talent.hit_combo.enabled|combo_strike)&chi.max-chi>=2
    -- actions.weapons_of_order+=/chi_wave
    -- actions.weapons_of_order+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=chi>=3|buff.weapons_of_order_ww.up
    -- actions.weapons_of_order+=/flying_serpent_kick,interrupt=1
end

local id = 269
if br.rotations[id] == nil then
    br.rotations[id] = {}
end
-- tinsert(br.rotations[id],{
--     name = rotationName,
--     toggles = createToggles,
--     options = createOptions,
--     run = runRotation,
-- })
