# Action for setting an item display model

# Grant effect to seated all passengers
$execute on passengers if entity @s[tag=vehicle.seat] on passengers run effect give @s $(name) $(duration) $(amplifier) $(hide_particles)

# Reset trigger (if it exists)
execute if data storage reds_vehicles:events unchecked_events[0].trigger run function reds_vehicles:events/reset_trigger_score with storage reds_vehicles:events unchecked_events[0]

