# Configures newly summoned item display entities
# This is called from reds_vehicles:summon/entity/item_display
# It is executed BY and AT the newly-spawned item display

# Add tags
tag @s add vehicle.part
tag @s add vehicle.display
tag @s add vehicle.new
function reds_vehicles:summon/entity_assign_vehicle_tag

# Configure animation properties
data merge entity @s {teleport_duration: 2, interpolation_duration: 2}

# Set transformation data
data modify entity @s transformation set from storage reds_vehicles:definitions working_entity.transform

# Set entity name
data modify entity @s CustomName set from storage reds_vehicles:definitions working_entity.name

# Configure item
data merge entity @s {item:{id:"minecraft:stone",count:1b}}
data modify entity @s item.id set from storage reds_vehicles:definitions working_entity.item.id
data modify entity @s item.components set from storage reds_vehicles:definitions working_entity.item.components
