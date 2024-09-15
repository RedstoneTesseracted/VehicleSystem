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
execute if data storage reds_vehicles:definitions working_base_gravity run data modify storage reds_vehicles:definitions working_root.base_gravity set from storage reds_vehicles:definitions working_base_gravity

# Process events list
data modify storage reds_vehicles:definitions working_event_list set from storage reds_vehicles:definitions working_root.events
execute unless function reds_vehicles:define/event_list/parse run return run function reds_vehicles:define/root/exit_fail
data modify storage reds_vehicles:definitions working_root.events set from storage reds_vehicles:definitions working_event_list

# Process bonuses
data modify storage reds_vehicles:definitions working_bonus_list set from storage reds_vehicles:definitions working_root.bonuses
execute unless function reds_vehicles:define/bonus_list/parse run return run function reds_vehicles:define/root/exit_fail
data modify storage reds_vehicles:definitions working_root.bonuses set from storage reds_vehicles:definitions working_bonus_list


# Create entities list
data modify storage reds_vehicles:definitions working_entities set value []

# Add seat interaction entity
data merge storage reds_vehicles:definitions {working_seat: {type: "interaction", pilot: true, tags: {width: 1.0f, height: 1.0f}}}
execute if data storage reds_vehicles:definitions working_root.seat.width run data modify storage reds_vehicles:definitions working_seat.tags.width set from storage reds_vehicles:definitions working_root.seat.width
execute if data storage reds_vehicles:definitions working_root.seat.height run data modify storage reds_vehicles:definitions working_seat.tags.height set from storage reds_vehicles:definitions working_root.seat.height
data modify storage reds_vehicles:definitions working_entities append from storage reds_vehicles:definitions working_seat
data remove storage reds_vehicles:definitions working_root.seat

# Add item display entities
data modify storage reds_vehicles:definitions working_part_list set from storage reds_vehicles:definitions working_root.parts
execute unless function reds_vehicles:define/part_list/parse run return run function reds_vehicles:define/root/exit_fail
data modify storage reds_vehicles:definitions working_entities append from storage reds_vehicles:definitions working_part_list[]
data remove storage reds_vehicles:definitions working_root.parts

data modify storage reds_vehicles:definitions working_root.entities set from storage reds_vehicles:definitions working_entities

# Convert "ground_offset" to "scale" by dividing by 0.9875 and remove "ground_offset" tag
execute store result score vehicle.ground_offset vehicle.local run data get storage reds_vehicles:definitions working_root.ground_offset 10000
execute unless data storage reds_vehicles:definitions working_root.ground_offset run scoreboard players set vehicle.ground_offset vehicle.local 10000
execute store result storage reds_vehicles:definitions working_root.scale float 0.00010126582278481013 run scoreboard players get vehicle.ground_offset vehicle.local
data remove storage reds_vehicles:definitions working_root.ground_offset

# Manually set seat count to 1
data modify storage reds_vehicles:definitions working_root.seat_count set value 1

# Return success status
return run function reds_vehicles:define/root/exit_success
