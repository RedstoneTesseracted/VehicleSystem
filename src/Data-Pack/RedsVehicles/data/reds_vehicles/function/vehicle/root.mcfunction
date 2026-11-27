# This is the root vehicle function that execute vehicle behavior
# It is run BY and AT the vehicle base entity, and is called from
# reds_vehicles:tick once every tick

# Grab this vehicle's definition
# If there is no matching definition, exit early
execute unless function reds_vehicles:vehicle/grab_executor_definition run return fail

# Gather input IF AND ONLY IF a pilot is present
data modify storage reds_vehicles:inputs input set value {}
execute if predicate reds_vehicles:has_passenger run function reds_vehicles:input/gather_input_groups

# Modify scoreboards with input
execute if predicate reds_vehicles:has_passenger run function reds_vehicles:handling/handle_inputs

# title @a actionbar ["Forward Acceleration: ",{"score": {"name": "@s", "objective": "vehicle.accel.forward"}}]

# Apply physics
function reds_vehicles:physics/apply

# Process events
execute if data storage reds_vehicles:definitions current.events[0] run function reds_vehicles:events/process

# Reset seat triggers
execute on passengers if entity @s[type=minecraft:interaction] run tag @s remove vehicle.left_clicked_by_pilot
execute on passengers if entity @s[type=minecraft:interaction] run tag @s remove vehicle.right_clicked_by_pilot
