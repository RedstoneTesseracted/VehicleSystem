# This function summons and configures an interaction entity
# It is called from reds_vehicles:summon/entity_loop

# Summon the entity
summon minecraft:interaction ~ ~ ~ {Tags:["vehicle.part","vehicle.seat","vehicle.new"]}

# Apply additional NBT
$data merge entity @n[tag=vehicle.seat,tag=vehicle.new] $(tags)

# Assign vehicle name tag
function reds_vehicles:summon/entity_assign_vehicle_tag

# Mark as cockpit if applicable
execute if predicate reds_vehicles:working_entity_is_cockpit run tag @n[tag=vehicle.seat,tag=vehicle.new] add vehicle.pilot_seat


