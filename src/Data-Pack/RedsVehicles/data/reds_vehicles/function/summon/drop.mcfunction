# This function drops a vehicle's spawner item

# Only vehicles allowed!
execute unless entity @s[tag=vehicle.base] run return fail

# Grab this vehicle's definition
execute unless function reds_vehicles:vehicle/grab_executor_definition run return fail

data remove storage reds_vehicles:definitions args
data modify storage reds_vehicles:definitions args.name set from storage reds_vehicles:definitions current.name
data modify storage reds_vehicles:definitions args.preview set from storage reds_vehicles:definitions current.preview
data modify storage reds_vehicles:definitions args.collection set from storage reds_vehicles:definitions current.collection
scoreboard players set vehicle.result vehicle.local 0
execute store result score vehicle.result vehicle.local run function reds_vehicles:items/summon_spawn_egg with storage reds_vehicles:definitions args
execute if score vehicle.result vehicle.local matches 0 run tellraw @p {translate: "reds_vehicles.notify.errors.generic_macro_fail", color: red, with: [{text: "reds_vehicles:items/summon_spawn_egg", color: "gold"}, {text: "reds_vehicles:summon/drop", color: "gold"}, {translate: "reds_vehicles.notify.errors.generic_macro_fail.hover_text", color: "gold", underlined: true, hover_event: {action: "show_text", value: {nbt: "args", storage: "reds_vehicles:definitions"}}}]}
