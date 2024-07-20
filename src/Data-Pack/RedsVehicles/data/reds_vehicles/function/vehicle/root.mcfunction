# This is the root vehicle function that execute vehicle behavior
# It is run BY and AT the vehicle base entity, and is called from
# reds_vehicles:tick once every tick

# Grab this vehicle's definition
data remove storage reds_vehicles:definitions args
data modify storage reds_vehicles:definitions args.name set from entity @s CustomName
function reds_vehicles:vehicle/grab_definition with storage reds_vehicles:definitions args

# Gather input IF AND ONLY IF a pilot is present
data modify storage reds_vehicles:inputs input set value {}
execute if predicate reds_vehicles:has_passenger run function reds_vehicles:input/gather_input_groups

# Modify scoreboards with input


# Apply physics


# Process events


# Reset seat triggers
execute on passengers run tag @s remove vehicle.left_clicked_by_pilot
execute on passengers run tag @s remove vehicle.right_clicked_by_pilot
