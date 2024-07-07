# This function summons and configures an item display entity
# It is called from reds_vehicles:summon/entity_loop

# Summon the entity
summon minecraft:item_display ~ ~ ~ {Tags:["vehicle.part","vehicle.display","vehicle.new"], teleport_duration:2, interpolation_duration: 2, item:{id:"minecraft:stone",count:1b}}

# Set transformation data
data modify entity @n[tag=vehicle.display,tag=vehicle.new] transformation set from storage reds_vehicles:definitions working_entity.transform

# Set entity name
data modify entity @n[tag=vehicle.display,tag=vehicle.new] CustomName set from storage reds_vehicles:definitions working_entity.name
item modify entity @n[tag=vehicle.display,tag=vehicle.new] container.0 reds_vehicles:set_model_from_working_entity

# Set model data
data modify entity @n[tag=vehicle.display,tag=vehicle.new] item.id set from storage reds_vehicles:definitions working_entity.item

# Assign vehicle name tag
function reds_vehicles:summon/entity_assign_vehicle_tag

