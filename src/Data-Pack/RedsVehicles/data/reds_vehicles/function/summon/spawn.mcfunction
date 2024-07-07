# This function spawns the vehicle with the requested name
# If no such vehicle exists within the global vehicle table, this
# function will fail.
#
# Vehicle name must be provided via function a macro

# Fail if no such vehicle exists
$execute unless data storage reds_vehicles:definitions processed[{name:"$(name)"}] run return fail

# Obtain definition with corresponding name
$data modify storage reds_vehicles:definitions summon set from storage reds_vehicles:definitions processed[{name:"$(name)"}]

# Summon the vehicle base entity
execute summon minecraft:armor_stand run function reds_vehicles:summon/configure_base with storage reds_vehicles:definitions summon

# Summon additional entities
data modify storage reds_vehicles:definitions unsummoned_entities set from storage reds_vehicles:definitions summon.entities
execute if data storage reds_vehicles:definitions unsummoned_entities[0] run function reds_vehicles:summon/entity_loop

# Mount newly summoned entities onto base entity
execute as @e[tag=vehicle.new,tag=!vehicle.base] run ride @s mount @n[tag=vehicle.new,tag=vehicle.base]

# Clear "new" status
tag @e[tag=vehicle.new] remove vehicle.new

# Clear temporary storage
data remove storage reds_vehicles:definitions working_entity
data remove storage reds_vehicles:definitions unsummoned_entities
data remove storage reds_vehicles:definitions summon
