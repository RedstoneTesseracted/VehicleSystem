# This function recursively checks and parses vehicle definitions.
#
# Definitions are found in the reds_vehicles:definitions storage under the vehicles tag
# Results are added to the reds_vehicles:definitions storage under the processed tag
#
# Before running this function, the contents of "vehicles" are copied to "unprocessed"
# This function then pops and processes the first element of "unprocessed" before running again

# Reset error flag
scoreboard players set vehicle.error vehicle.local 0

# Prepare a temporary tag to place the working definition in
data modify storage reds_vehicles:definitions working set value {}

# Pop first element
data modify storage reds_vehicles:definitions working set from storage reds_vehicles:definitions unprocessed[0]
data remove storage reds_vehicles:definitions unprocessed[0]

# Process additional elements for the definition

# Check for REQUIRED name tag
function reds_vehicles:define/assert_name


# Validate handling list and gather a list of inputs that are actually used
# TODO: Make flag declaration here automatic
scoreboard players set vehicle.uses_input.look vehicle.local 0
scoreboard players set vehicle.uses_input.motion vehicle.local 0
scoreboard players set vehicle.uses_input.directed vehicle.local 0
scoreboard players set vehicle.uses_input.rotation vehicle.local 0
scoreboard players set vehicle.uses_input.rotation_diff vehicle.local 0
scoreboard players set vehicle.uses_input.click vehicle.local 0
scoreboard players set vehicle.uses_input.input vehicle.local 0

data modify storage reds_vehicles:definitions unprocessed_handling set from storage reds_vehicles:definitions working.handling
execute if data storage reds_vehicles:definitions unprocessed_handling[0] run function reds_vehicles:define/process_handling_loop

data modify storage reds_vehicles:definitions working.handling set from storage reds_vehicles:definitions processed_handling
data remove storage reds_vehicles:definitions processed_handling
data remove storage reds_vehicles:definitions unprocessed_handling
data remove storage reds_vehicles:definitions working_handling


# Compile list of used inputs from the marked flags
data modify storage reds_vehicles:definitions working.inputs set value []
# TODO: Make flag declaration here automatic
execute if score vehicle.uses_input.look vehicle.local matches 1 run data modify storage reds_vehicles:definitions working.inputs append value 'look'
execute if score vehicle.uses_input.motion vehicle.local matches 1 run data modify storage reds_vehicles:definitions working.inputs append value 'motion'
execute if score vehicle.uses_input.directed vehicle.local matches 1 run data modify storage reds_vehicles:definitions working.inputs append value 'directed'
execute if score vehicle.uses_input.rotation vehicle.local matches 1 run data modify storage reds_vehicles:definitions working.inputs append value 'rotation'
execute if score vehicle.uses_input.rotation_diff vehicle.local matches 1 run data modify storage reds_vehicles:definitions working.inputs append value 'rotation_diff'
execute if score vehicle.uses_input.click vehicle.local matches 1 run data modify storage reds_vehicles:definitions working.inputs append value 'click'
execute if score vehicle.uses_input.input vehicle.local matches 1 run data modify storage reds_vehicles:definitions working.inputs append value 'input'

scoreboard players reset vehicle.uses_input.look vehicle.local
scoreboard players reset vehicle.uses_input.motion vehicle.local
scoreboard players reset vehicle.uses_input.directed vehicle.local
scoreboard players reset vehicle.uses_input.rotation vehicle.local
scoreboard players reset vehicle.uses_input.rotation_diff vehicle.local
scoreboard players reset vehicle.uses_input.click vehicle.local
scoreboard players reset vehicle.uses_input.input vehicle.local



# Set default gravity
data modify storage reds_vehicles:definitions working.base_gravity set value 0.08

# Process physics list
data modify storage reds_vehicles:definitions processed_physics set value []
data modify storage reds_vehicles:definitions unprocessed_physics set from storage reds_vehicles:definitions working.physics
execute if data storage reds_vehicles:definitions unprocessed_physics[0] run function reds_vehicles:define/process_physics_loop

data modify storage reds_vehicles:definitions working.physics set from storage reds_vehicles:definitions processed_physics
data remove storage reds_vehicles:definitions processed_physics
data remove storage reds_vehicles:definitions unprocessed_physics
data remove storage reds_vehicles:definitions working_physics

# Create entities list
data modify storage reds_vehicles:definitions working.entities set value []

# Add seat interaction entity
data merge storage reds_vehicles:definitions {working_seat: {type: "minecraft:interaction", pilot: true, tags:{width: 1.0f, height: 1.0f}}}
execute if data storage reds_vehicles:definitions working.seat.width run data modify storage reds_vehicles:definitions working_seat.tags.width set from storage reds_vehicles:definitions working.seat.width
execute if data storage reds_vehicles:definitions working.seat.height run data modify storage reds_vehicles:definitions working_seat.tags.height set from storage reds_vehicles:definitions working.seat.height
data modify storage reds_vehicles:definitions working.entities append from storage reds_vehicles:definitions working_seat
data remove storage reds_vehicles:definitions working_seat
data remove storage reds_vehicles:definitions working.seat

# Add item display entities
data modify storage reds_vehicles:definitions unprocessed_parts set from storage reds_vehicles:definitions working.parts
execute if data storage reds_vehicles:definitions unprocessed_parts[0] run function reds_vehicles:define/process_parts_loop

data remove storage reds_vehicles:definitions working.parts
data remove storage reds_vehicles:definitions unprocessed_parts
data remove storage reds_vehicles:definitions working_part



# Convert "ground_offset" to "scale" by dividing by 0.9875 and remove "ground_offset" tag
# FIXME: Add default value
execute store result score vehicle.ground_offset vehicle.local run data get storage reds_vehicles:definitions working.ground_offset 10000
execute store result storage reds_vehicles:definitions working.scale float 0.00010126582278481013 run scoreboard players get vehicle.ground_offset vehicle.local
scoreboard players reset vehicle.ground_offset vehicle.local
data remove storage reds_vehicles:definitions working.ground_offset


# Manually set seat count to 1
data modify storage reds_vehicles:definitions working.seat_count set value 1


# Add the finished definition to the processed table
execute if score vehicle.error vehicle.local matches 0 run data modify storage reds_vehicles:definitions processed append from storage reds_vehicles:definitions working
data remove storage reds_vehicles:definitions working

# Execute this function again for the next element (if any remain)
execute if data storage reds_vehicles:definitions unprocessed[0] run function reds_vehicles:define/process_loop
