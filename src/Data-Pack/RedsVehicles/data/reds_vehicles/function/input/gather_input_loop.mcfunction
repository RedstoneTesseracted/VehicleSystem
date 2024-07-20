# This function uses a recursion-based loop to gather all inputs requested by the entity
# It is run BY and AT the base vehicle entity
# It is called from reds_vehicles:input/gather_input_groups

# Pop the first element of the list
data modify storage reds_vehicles:inputs args.group set from storage reds_vehicles:inputs requested_inputs[0]
data remove storage reds_vehicles:inputs requested_inputs[0]

# Gather this group
function reds_vehicles:input/__gather_group with storage reds_vehicles:inputs args

# Run again if groups remain
execute if data storage reds_vehicles:inputs requested_inputs[0] run function reds_vehicles:input/gather_input_loop
