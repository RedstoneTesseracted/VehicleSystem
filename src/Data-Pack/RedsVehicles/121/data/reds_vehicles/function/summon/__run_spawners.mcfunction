# This function summons a vehicle and destroys the spawner that summoned it
# It is run BY and AT a vehicle spawner entity

# Run the matching summoning function
execute store result score vehicle.result vehicle.local run function reds_vehicles:summon/spawn with entity @s data

# If something went wrong, re-spawn the item and inform the user
execute unless score vehicle.result vehicle.local matches 1 run playsound minecraft:block.anvil.land block @a ~ ~ ~ 1 0
execute unless score vehicle.result vehicle.local matches 1 run particle minecraft:block{block_state:{id:"minecraft:anvil"}} ~ ~1 ~ 1.0 1.0 1.0 0.05 100
execute unless score vehicle.result vehicle.local matches 1 run function reds_vehicles:items/summon_spawn_egg with entity @s data
execute unless score vehicle.result vehicle.local matches 1 run tellraw @a[distance=..15] [{text:"[Red's Vehicles]: ",color:"#FF0000"},{translate: "reds_vehicles.spawning.item_spawning_failed", fallback: "Failed to summon vehicle \"%s\"", with: [{nbt: "data.name","entity": "@s",color: "gold",underlined: true}], color: "red"}]

# Play sound effect when vehicle is summoned successfully
execute if score vehicle.result vehicle.local matches 1 run playsound minecraft:block.anvil.use block @a ~ ~ ~ 1 1.5
execute if score vehicle.result vehicle.local matches 1 run particle minecraft:happy_villager ~ ~1 ~ 0.5 0.5 0.5 1 20

# Remove temporary data storage
scoreboard players reset vehicle.result vehicle.local

# Remove temporary spawner entity
kill @s[tag=vehicle.spawner]

