# This function is the root function for handling pilot input
# It is run BY and AT the vehicle base entity
# It is called from reds_vehicles:vehicle/root
#
# This works by looping over the handling definitions listed in
# reds_vehicles:handling.unprocessed_handlers storage, and using 
# function macros to execute the corresponding behavior

# Copy the handling definitions to a temporary buffer
data modify storage reds_vehicles:handling unprocessed_handlers set from storage reds_vehicles:definitions current.handling

# Loop over the list
execute if data storage reds_vehicles:handling unprocessed_handlers[0] run function reds_vehicles:handling/handle_inputs_loop

# Delete temporary buffer
data remove storage reds_vehicles:handling args
data remove storage reds_vehicles:handling unprocessed_handlers
