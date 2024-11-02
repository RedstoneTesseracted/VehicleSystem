# This functions handles a sideways-oriented linear drag force
#
# The resulting acceleration is calculated using:
#   a = bv
#
# Where:
#   a = Acceleration
#   b = Drag constant
#   v = Velocity in sideways direction
#
# v is calculated using:
#   v = 𝗩 • 𝗪
#
# Where:
#   𝗩 = velocity vector
#   𝗪 = side unit vector
#
# * 𝗪 is given using the vehicle's side unit vector (^1 ^ ^)

# First, obtain the side-facing unit vector (floating-point precision)
data modify storage reds_vehicles:physics temp set value {x1: 0.0f, y1: 0.0f, z1: 0.0f, dx: 0.0f, dy: 0.0f, dz: 0.0f}
data modify storage reds_vehicles:physics temp.x1 set from entity @s Pos[0]
data modify storage reds_vehicles:physics temp.y1 set from entity @s Pos[1]
data modify storage reds_vehicles:physics temp.z1 set from entity @s Pos[2]
execute positioned ^1 ^ ^ summon minecraft:marker run function reds_vehicles:physics/utility/precision_vector_calc with storage reds_vehicles:physics temp

# tellraw @a [{"text":"𝗪: "},{"nbt": "temp.dx","storage": "reds_vehicles:physics"},{"text":", "},{"nbt": "temp.dy","storage": "reds_vehicles:physics"},{"text":", "},{"nbt": "temp.dz","storage": "reds_vehicles:physics"}]

# Next, obtain the velocity vector's magnitude and normalize said vector so that
# it can be used with fixed-point arithmetic
scoreboard players add vehicle.vel.y vehicle.local 7841
execute store result storage reds_vehicles:physics temp.vx double 0.00001 run scoreboard players get vehicle.vel.x vehicle.local
execute store result storage reds_vehicles:physics temp.vy double 0.00001 run scoreboard players get vehicle.vel.y vehicle.local
execute store result storage reds_vehicles:physics temp.vz double 0.00001 run scoreboard players get vehicle.vel.z vehicle.local
scoreboard players remove vehicle.vel.y vehicle.local 7841

execute summon minecraft:block_display run function reds_vehicles:physics/utility/precision_vector_normalize with storage reds_vehicles:physics temp


# Compute the dot product using fixed-point arithmetic
# Here, we use the very funky multiplier of 46340, chosen because:
#   * The most extreme value of the dot product is ±1.0
#       * This happens when 𝗪 and 𝗩 are parallel
#   * Therefore, the highest possible multiplier that will keep norm(𝗩)•𝗪 under 
#     the 32-bit integer limit is given by: floor(sqrt((2^31-1)/1.0))=46340
#
execute store result score vehicle.u.x vehicle.local run data get storage reds_vehicles:physics temp.dx 46340
execute store result score vehicle.u.y vehicle.local run data get storage reds_vehicles:physics temp.dy 46340
execute store result score vehicle.u.z vehicle.local run data get storage reds_vehicles:physics temp.dz 46340
execute store result score vehicle.v.x vehicle.local run data get storage reds_vehicles:physics temp.nvx 46340
execute store result score vehicle.v.y vehicle.local run data get storage reds_vehicles:physics temp.nvy 46340
execute store result score vehicle.v.z vehicle.local run data get storage reds_vehicles:physics temp.nvz 46340

scoreboard players operation vehicle.u.x vehicle.local *= vehicle.v.x vehicle.local
scoreboard players operation vehicle.u.y vehicle.local *= vehicle.v.y vehicle.local
scoreboard players operation vehicle.u.z vehicle.local *= vehicle.v.z vehicle.local

scoreboard players operation vehicle.u.x vehicle.local += vehicle.u.y vehicle.local
scoreboard players operation vehicle.u.x vehicle.local += vehicle.u.z vehicle.local

execute store result storage reds_vehicles:physics temp.dot float 0.0000000004656803804571454 run scoreboard players get vehicle.u.x vehicle.local

# title @a actionbar [{"nbt": "temp.dot","storage": "reds_vehicles:physics"}]
# tellraw @a {"nbt": "Motion","entity": "@s"}

# Now compute the remaining b(|𝗩| norm(𝗩)•𝗪) using display entity funkyness
data modify storage reds_vehicles:physics temp.b set from storage reds_vehicles:physics unapplied_forces[0].value
execute summon minecraft:block_display run function reds_vehicles:physics/utility/side_drag_helper
# tellraw @a {"text":"----------------------------"}

# title @a actionbar [{"nbt": "temp.dx","storage": "reds_vehicles:physics"},{"text":", "},{"nbt": "temp.dy","storage": "reds_vehicles:physics"},{"text":", "},{"nbt": "temp.dz","storage": "reds_vehicles:physics"}]


# Compute the final drag vector
# function reds_vehicles:physics/utility/side_drag_helper2 with storage reds_vehicles:physics temp

# title @a actionbar [{"text":"dx: "},{"nbt": "temp.dx","storage": "reds_vehicles:physics"},{"text":", dy: "},{"nbt": "temp.dy","storage": "reds_vehicles:physics"},{"text":", dz: "},{"nbt": "temp.dz","storage": "reds_vehicles:physics"}]

# return fail
execute store result score vehicle.dv.x vehicle.local run data get storage reds_vehicles:physics temp.dx 100000
execute store result score vehicle.dv.y vehicle.local run data get storage reds_vehicles:physics temp.dy 100000
execute store result score vehicle.dv.z vehicle.local run data get storage reds_vehicles:physics temp.dz 100000

# title @a actionbar [{"text":"vx: "},{"score": {"name": "vehicle.dv.x","objective": "vehicle.local"}},{"text":", vy: "},{"score": {"name": "vehicle.dv.y","objective": "vehicle.local"}},{"text":", vz: "},{"score": {"name": "vehicle.dv.z","objective": "vehicle.local"}}]
# return fail
scoreboard players operation vehicle.vel.x vehicle.local += vehicle.dv.x vehicle.local
scoreboard players operation vehicle.vel.y vehicle.local += vehicle.dv.y vehicle.local
scoreboard players operation vehicle.vel.z vehicle.local += vehicle.dv.z vehicle.local





# Mark this force as active
#tag @s add vehicle.force_active.simple_lift
