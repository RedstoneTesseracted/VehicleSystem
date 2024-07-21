# Configures newly summoned interaction entities
# This is called from reds_vehicles:summon/entity/interaction
# It is executed BY and AT the newly-spawned interaction

# Apply tags
tag @s add vehicle.part
tag @s add vehicle.seat
tag @s add vehicle.new
function reds_vehicles:summon/entity_assign_vehicle_tag

# Apply additional NBT
$data merge entity @s $(tags)

# Mark as cockpit if applicable
execute if predicate reds_vehicles:working_entity_is_cockpit run tag @s add vehicle.pilot_seat

