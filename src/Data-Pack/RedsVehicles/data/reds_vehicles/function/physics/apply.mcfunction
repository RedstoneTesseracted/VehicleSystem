# This function handles the application of physics forces
# and updates motion-related data
#
# It is called from reds_vehicles:vehicle/root
# It is run BY and AT the base vehicle entity


# # Counteract drag
# data modify storage reds_vehicles:physics temp.vx set from entity @s Motion[0]
# data modify storage reds_vehicles:physics temp.vy set from entity @s Motion[1]
# data modify storage reds_vehicles:physics temp.vz set from entity @s Motion[2]
# data modify storage reds_vehicles:physics temp.vdrag set value 0.98
# data modify storage reds_vehicles:physics temp.hdrag set value 0.91
# execute if predicate reds_vehicles:environment/on_land run data modify storage reds_vehicles:physics temp.hdrag set value 0.546
# # execute if predicate reds_vehicles:environment/on_land run data modify storage reds_vehicles:physics temp.hdrag set value 0.55
# execute summon minecraft:block_display run function reds_vehicles:physics/counter_drag
# function reds_vehicles:physics/after_drag_apply with storage reds_vehicles:physics temp

# title @a actionbar [{"nbt": "temp.my","storage": "reds_vehicles:physics"},{"text":", "},{"nbt": "Motion[1]", "entity":"@s"}]


# Reset gravity-affecting attribute modifiers
# I REALLY don't like this, but it's the least-broken way of doing things
execute if data entity @s attributes[{id:"minecraft:gravity"}].modifiers run function reds_vehicles:physics/reset_gravity

# Obtain current velocity (x100000 fixed-point)
execute store result score vehicle.vel.x vehicle.local run data get entity @s Motion[0] 100000
execute store result score vehicle.vel.y vehicle.local run data get entity @s Motion[1] 100000
execute store result score vehicle.vel.z vehicle.local run data get entity @s Motion[2] 100000

# Set base rotation to match scores
execute store result entity @s Rotation[0] float 0.0001 run scoreboard players get @s vehicle.rot.yaw
execute store result entity @s Rotation[1] float 0.0001 run scoreboard players get @s vehicle.rot.pitch

# Apply non-gravity forces
execute if data storage reds_vehicles:definitions current.physics[0] run function reds_vehicles:physics/apply_forces

# Set new velocity
execute store result entity @s Motion[0] double 0.00001 run scoreboard players get vehicle.vel.x vehicle.local
execute store result entity @s Motion[1] double 0.00001 run scoreboard players get vehicle.vel.y vehicle.local
execute store result entity @s Motion[2] double 0.00001 run scoreboard players get vehicle.vel.z vehicle.local


# Remove temporary storage
data remove storage reds_vehicles:physics temp


#say ===============================================
