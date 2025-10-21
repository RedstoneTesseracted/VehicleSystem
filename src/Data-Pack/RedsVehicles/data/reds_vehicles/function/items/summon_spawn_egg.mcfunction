# Similar to reds_vehicles:items/give_spawn_egg, but summon an item entity instead
# Vehicle name is provided via function macros

$summon minecraft:item ~ ~ ~ {Item:{id:"minecraft:pig_spawn_egg",count:1b,components:{"minecraft:custom_data":{rv_spawner_item:1b},"minecraft:item_name":"Spawn $(name)","minecraft:rarity":"uncommon","minecraft:entity_data":{id:"minecraft:marker",Tags:["vehicle.spawner"],data:{name:'$(name)'}}}}}
