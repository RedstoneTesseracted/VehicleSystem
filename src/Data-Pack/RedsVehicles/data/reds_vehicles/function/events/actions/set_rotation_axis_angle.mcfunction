# Action for modifying a display entity's left_rotation or right_rotation

# Set up tag to be inserted into left/right rotation
data modify storage reds_vehicles:events rotation set value {angle: 0.0f, axis: [1.0f, 0.0f, 0.0f]}
data modify storage reds_vehicles:events rotation.axis set from storage reds_vehicles:events unapplied_actions[0].arguments.axis

# Obtain angle, multiplied by scale factor
# Scale factor includes precision-correction already premultiplied
$execute store result storage reds_vehicles:events rotation.angle float $(scale) run scoreboard players get @s $(source)

# Write to transform
$execute on passengers if entity $(selector) run data modify entity @s transformation.$(transform) set from storage reds_vehicles:events rotation

# Reset trigger (if it exists)
execute if data storage reds_vehicles:events unchecked_events[0].trigger run function reds_vehicles:events/reset_trigger_score with storage reds_vehicles:events unchecked_events[0]
