# This function handles the looping aspect of reds_vehicles:define/physics_list/parse
#
# Does NOT return a success/failure code

# Pop the first element in the list
data modify storage reds_vehicles:definitions working_physics set from storage reds_vehicles:definitions unprocessed_physics[0]
data remove storage reds_vehicles:definitions unprocessed_physics[0]

# Process physics element
execute unless function reds_vehicles:define/physics/parse run scoreboard players set vehicle.physics_list_error vehicle.local 1

# Gravity is special: instead of being added to the physics array like the other forces, 
# its value is used to set "base_gravity" on the root vehicle tag
execute if data storage reds_vehicles:definitions {working_physics:{type:"gravity"}} if data storage reds_vehicles:definitions working_physics.value run data modify storage reds_vehicles:definitions working_base_gravity set from storage reds_vehicles:definitions working_physics.value

# Add processed element to processed array (unless it's gravity)
execute unless data storage reds_vehicles:definitions {working_physics:{type:"gravity"}} run data modify storage reds_vehicles:definitions processed_physics append from storage reds_vehicles:definitions working_physics

# Run again if unprocessed physics entries remain
execute if data storage reds_vehicles:definitions unprocessed_physics[0] run function reds_vehicles:define/physics_list/parse_loop
