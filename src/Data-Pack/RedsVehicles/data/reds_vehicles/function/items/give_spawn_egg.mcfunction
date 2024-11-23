# This function gives the executor a vehicle spawning item for a specific vehicle
# Vehicle is provided via function macros

$give @s minecraft:pig_spawn_egg[custom_data={rv_spawner_item:1b},item_name='{"translate":"reds_vehicles.item.spawn_egg","fallback":"Spawn %s","with":[{"translate":"reds_vehicles.vehicle.$(name)","fallback":"$(name)"}]}',minecraft:rarity="uncommon",entity_data={id:"minecraft:marker",Tags:["vehicle.spawner"],data:{name:'$(name)'}}]
