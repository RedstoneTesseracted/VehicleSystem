# Action for playing a sound
$playsound $(sound) neutral @a ~ ~ ~ $(volume) $(pitch)

# Reset trigger (if it exists)
execute if data storage reds_vehicles:events unchecked_events[0].trigger run function reds_vehicles:events/reset_trigger_score with storage reds_vehicles:events unchecked_events[0]
