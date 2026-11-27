# Similar to reds_vehicles:items/give_spawn_egg, but summon an item entity instead
# Vehicle name is provided via function macros

$summon minecraft:item ~ ~ ~ {Item:{id:"minecraft:pig_spawn_egg",count:1b,components: {"minecraft:custom_data": {rv_spawner_item:1b, rv_id: "$(name)"}, "minecraft:lore": [{translate:"reds_vehicles.item.collection_line",italic:false,color:"gray",fallback:"%s",with:[{text:"$(collection)"}]}], "minecraft:item_model": "$(preview)", "minecraft:item_name": {translate:"reds_vehicles.item.spawn_egg",fallback:"Spawn %s",with:[{translate:"reds_vehicles.vehicle.$(name)",fallback:"$(name)"}]}, "minecraft:rarity": "uncommon", "minecraft:entity_data": {id:"minecraft:marker",Tags:["vehicle.spawner"],data:{name:'$(name)'}}, "minecraft:max_stack_size": 1}}}
return 1
