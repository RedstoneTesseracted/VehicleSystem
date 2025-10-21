# This functions handles a simple lift force
#
# The resulting acceleration is calculated using:
#   a = bv²
#
# Where:
#   a = Acceleration
#   b = Some constant that sweeps a whole bunch of terms under the rug
#   v = Velocity in forward direction
#
# v is calculated using:
#   v = 𝗩 • 𝗨
#
# Where:
#   𝗩 = velocity vector
#   𝗨 = forward unit vector
#
# * The forward direction is given using the vehicle's forward unit vector (^ ^ ^1)
# * The direction of acceleration is given using the vehicle's vertical unit vector (^ ^1 ^)

# Originally, I implemented this mainly using integer arithmetic.
# Unfortunately, that implementation succumbed to precision loss and tended to explode easily.
# So... I had to get... "creative" with this implementation

# return fail
# First, obtain the forward-facing unit vector (floating-point precision)
data modify storage reds_vehicles:physics temp set value {x1: 0.0f, y1: 0.0f, z1: 0.0f, dx: 0.0f, dy: 0.0f, dz: 0.0f}
data modify storage reds_vehicles:physics temp.x1 set from entity @s Pos[0]
data modify storage reds_vehicles:physics temp.y1 set from entity @s Pos[1]
data modify storage reds_vehicles:physics temp.z1 set from entity @s Pos[2]
execute positioned ^ ^ ^1 summon minecraft:marker run function reds_vehicles:physics/utility/precision_vector_calc with storage reds_vehicles:physics temp


# Next, obtain the velocity vector's magnitude and normalize said vector so that
# it can be used with fixed-point arithmetic
scoreboard players add vehicle.vel.y vehicle.local 7841
execute store result storage reds_vehicles:physics temp.vx double 0.00001 run scoreboard players get vehicle.vel.x vehicle.local
execute store result storage reds_vehicles:physics temp.vy double 0.00001 run scoreboard players get vehicle.vel.y vehicle.local
execute store result storage reds_vehicles:physics temp.vz double 0.00001 run scoreboard players get vehicle.vel.z vehicle.local
scoreboard players remove vehicle.vel.y vehicle.local 7841

# data modify storage reds_vehicles:physics temp.vx set from entity @s Motion[0]
# data modify storage reds_vehicles:physics temp.vy set from entity @s Motion[1]
# data modify storage reds_vehicles:physics temp.vz set from entity @s Motion[2]
execute summon minecraft:block_display run function reds_vehicles:physics/utility/precision_vector_normalize

# tellraw @a [{nbt: "temp.vmag",storage: "reds_vehicles:physics"}]

# Compute the dot product using fixed-point arithmetic
# Here, we use the very funky multiplier of 46340, chosen because:
#   * The most extreme value of the dot product is ±1.0
#       * This happens when 𝗨 and 𝗩 are parallel
#   * Therefore, the highest possible multiplier that will keep norm(𝗩)•𝗨 under 
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


# title @a actionbar [{nbt: "temp.dot",storage: "reds_vehicles:physics"}]

# Now compute the remaining b(|𝗩| norm(𝗩)•𝗨)² using display entity funkiness
data modify storage reds_vehicles:physics temp.b set from storage reds_vehicles:physics unapplied_forces[0].value
execute summon minecraft:block_display run function reds_vehicles:physics/utility/simple_lift_helper

# title @a actionbar [{nbt: "temp.a",storage: "reds_vehicles:physics"}]
# tellraw @a [{nbt: "temp.a",storage: "reds_vehicles:physics"}]


# Compute the final lift vector and apply to motion tag
data merge storage reds_vehicles:physics {temp:{u: 0.0f, w: 0.0f, dx: 0.0f, dy: 0.0f, dz: 0.0f}}
data modify storage reds_vehicles:physics temp.v set from storage reds_vehicles:physics temp.a
execute store result storage reds_vehicles:physics temp.roll double 0.0001 run scoreboard players get @s vehicle.rot.roll
# function reds_vehicles:physics/utility/simple_lift_helper2 with storage reds_vehicles:physics temp
function reds_vehicles:physics/utility/precision_roll_helper with storage reds_vehicles:physics temp

# title @a actionbar [{text:"dx: "},{nbt: "temp.dx",storage: "reds_vehicles:physics"},{text:", dy: "},{nbt: "temp.dy",storage: "reds_vehicles:physics"},{text:", dz: "},{nbt: "temp.dz",storage: "reds_vehicles:physics"}]

# Apply the change in velocity
execute store result score vehicle.dv.x vehicle.local run data get storage reds_vehicles:physics temp.dx 100000
execute store result score vehicle.dv.y vehicle.local run data get storage reds_vehicles:physics temp.dy 100000
execute store result score vehicle.dv.z vehicle.local run data get storage reds_vehicles:physics temp.dz 100000

scoreboard players operation vehicle.vel.x vehicle.local += vehicle.dv.x vehicle.local
scoreboard players operation vehicle.vel.y vehicle.local += vehicle.dv.y vehicle.local
scoreboard players operation vehicle.vel.z vehicle.local += vehicle.dv.z vehicle.local


# # Mark this force as active
# #tag @s add vehicle.force_active.simple_lift
