# Action for modifying a display entity's transform

# Obtain scaled value to set
$execute store result storage reds_vehicles:events unapplied_actions[0].value float $(scale) run scoreboard players get @s $(source)

# Execute the corresponding transformation modifier function as the target entity(s)
$execute on passengers if entity $(selector) run function reds_vehicles:events/actions/modify_transform/$(transform).$(property)

# Reset trigger (if it exists)
execute if data storage reds_vehicles:events unchecked_events[0].trigger run function reds_vehicles:events/reset_trigger_score with storage reds_vehicles:events unchecked_events[0]
