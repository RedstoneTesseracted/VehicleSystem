# This function gathers all input groups requested by this vehicle
# It is run BY and AT the base vehicle entity
#
# This works by looping over the groups listed in the
# reds_vehicles:input.requested_inputs storage, and using function macros 
# to execute the corresponding function

# Copy the requested input groups to a temporary buffer
data modify storage reds_vehicles:inputs requested_inputs set from storage reds_vehicles:definitions current.inputs

# Loop over the list
execute if data storage reds_vehicles:inputs requested_inputs[0] run function reds_vehicles:input/gather_input_loop

# Delete the temporary buffer
data remove storage reds_vehicles:inputs args
data remove storage reds_vehicles:inputs requested_inputs
