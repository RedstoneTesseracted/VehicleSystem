# Function used by reds_vehicles:define/root/parse to process/validate the physics list
# It uses a recursion-based loop to loop over the physics list
# The actual recursive function is reds_vehicles:define/physics_list/parse_loop
#
# If an error is raised during the loop, the loop will NOT immediately exit.
# Instead, the loop will finish to completion to allow any and all errors to be
# logged.  After that, this function will return with an error state
#
# The list in "working_physics_list" under the "reds_vehicles:definitions"
# storage is ultimately modified in place assuming no errors occurred
#
# Physics entries with the "gravity" type will be omitted from the final 
# list.  Instead the last one's "value" field will be written to 
# "reds_vehicles:definitions.working_base_gravity
#
# If no physics entry with type "gravity" is present, working_base_gravity
# will simply not be written
#
# Returns a "0" on failure, and a "1" on success

# Set failure score
scoreboard players set vehicle.physics_list_error vehicle.local 0

# Run loop
data modify storage reds_vehicles:definitions unprocessed_physics set from storage reds_vehicles:definitions working_physics_list
data modify storage reds_vehicles:definitions processed_physics set value []
execute if data storage reds_vehicles:definitions unprocessed_physics[0] run function reds_vehicles:define/physics_list/parse_loop
data modify storage reds_vehicles:definitions working_physics_list set from storage reds_vehicles:definitions processed_physics

# Handle failure/success
execute if score vehicle.physics_list_error vehicle.local matches 1 run return run function reds_vehicles:define/physics_list/exit_fail
return run function reds_vehicles:define/physics_list/exit_success
