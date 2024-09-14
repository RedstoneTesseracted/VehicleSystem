# This function uses a recursion-based loop to process
# ALL vehicle definitions
#
# Definitions are found in the reds_vehicles:definitions storage under the "vehicles" tag
# Results are added to the reds_vehicles:definitions storage under the "processed" tag
#
# This function is called from reds_vehicles:define/reload

# Set up unprocessed array to loop over
data modify storage reds_vehicles:definitions unprocessed_vehicles set from storage reds_vehicles:definitions vehicles

# Start parsing vehicle tags
execute if data storage reds_vehicles:definitions unprocessed_vehicles[0] run function reds_vehicles:define/root_list/parse_loop

# Success!
return run function reds_vehicles:define/root_list/exit_success
