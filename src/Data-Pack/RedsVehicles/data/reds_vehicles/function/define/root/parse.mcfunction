# This function parses the root vehicle tag
#
# The tag to process MUST be stored in the "working_root"
# tag under the "reds_vehicles:definitions" tag
#
# The final processed tag is kept in "working_root"

# Validate vehicle name, and exit early with error if failed
execute unless function reds_vehicles:define/name/parse run return run function reds_vehicles:define/root/exit_fail

# Process the handling tag
data modify storage reds_vehicles:definitions working_input_list set value []
data modify storage reds_vehicles:definitions working_handling_list set from storage reds_vehicles:definitions working_root.handling
execute unless function reds_vehicles:define/handling_list/parse run return run function reds_vehicles:define/root/exit_fail
data modify storage reds_vehicles:definitions working_root.handling set from storage reds_vehicles:definitions working_handling_list
data modify storage reds_vehicles:definitions working_root.inputs set from storage reds_vehicles:definitions working_input_list

# Set default gravity
data modify storage reds_vehicles:definitions working_base_gravity set value 0.08

# Process physics list
data modify storage reds_vehicles:definitions working_physics_list set from storage reds_vehicles:definitions working_root.physics
execute unless function reds_vehicles:define/physics_list/parse run return run function reds_vehicles:define/root/exit_fail
data modify storage reds_vehicles:definitions working_root.physics set from storage reds_vehicles:definitions working_physics_list 
data modify storage reds_vehicles:definitions working_root.base_gravity set from storage reds_vehicles:definitions working_base_gravity

# Process events list
data modify storage reds_vehicles:definitions working_events_list set from storage reds_vehicles:definitions working_root.events
execute unless function reds_vehicles:define/event_list/parse run return run function reds_vehicles:define/root/exit_fail
data modify storage reds_vehicles:definitions working_root.events set from storage reds_vehicles:definitions working_events_list 


# Create entities list



# Convert "ground_offset" to "scale" by dividing by 0.9875 and remove "ground_offset" tag


data remove storage reds_vehicles:definitions working_root.ground_offset

# Manually set seat count to 1
data modify storage reds_vehicles:definitions working_root.seat_count set value 1



# Return success status
return run function reds_vehicles:define/root/exit_success
