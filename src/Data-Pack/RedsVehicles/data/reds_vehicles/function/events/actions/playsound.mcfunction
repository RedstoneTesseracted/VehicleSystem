# Action for playing a sound
execute store result score vehicle.time vehicle.local run time query gametime
$scoreboard players set vehicle.period vehicle.local $(period)
scoreboard players operation vehicle.time vehicle.local %= vehicle.period vehicle.local
$execute if score vehicle.time vehicle.local matches 0 run playsound $(sound) neutral @a ~ ~ ~ $(volume) $(pitch)

# Reset trigger (if it exists)
execute if data storage reds_vehicles:events unchecked_events[0].trigger run function reds_vehicles:events/reset_trigger_score with storage reds_vehicles:events unchecked_events[0]
