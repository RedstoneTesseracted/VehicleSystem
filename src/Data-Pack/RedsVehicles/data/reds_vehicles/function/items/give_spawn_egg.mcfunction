# This function gives the executor a vehicle spawning item for a specific vehicle
# Vehicle is provided via function macros

$give @s minecraft:pig_spawn_egg[minecraft:custom_data={rv_spawner_item:1b, rv_id: "$(name)"},minecraft:lore=[{translate:"reds_vehicles.item.collection_line",italic:false,color:"gray",fallback:"%s",with:[{text:"$(collection)"}]}],item_model="$(preview)",item_name={translate:"reds_vehicles.item.spawn_egg",fallback:"Spawn %s",with:[{translate:"reds_vehicles.vehicle.$(name)",fallback:"$(name)"}]},minecraft:rarity="uncommon",entity_data={id:"minecraft:marker",Tags:["vehicle.spawner"],data:{name:'$(name)'}},minecraft:max_stack_size=1]
return 1
