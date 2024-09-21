# Action for setting a display entity's transform to an explicit value tag

# Write transform to entity
$execute on passengers if entity $(selector) run data modify entity @s transformation.$(transform) set from storage reds_vehicles:events unapplied_actions[0].arguments.parameter

# Reset trigger (if it exists)
execute if data storage reds_vehicles:events unchecked_events[0].trigger run function reds_vehicles:events/reset_trigger_score with storage reds_vehicles:events unchecked_events[0]
