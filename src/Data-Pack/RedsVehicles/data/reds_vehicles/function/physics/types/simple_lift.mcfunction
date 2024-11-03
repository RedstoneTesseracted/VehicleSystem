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
execute summon minecraft:block_display run function reds_vehicles:physics/utility/precision_vector_normalize with storage reds_vehicles:physics temp


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


# title @a actionbar [{"nbt": "temp.dot","storage": "reds_vehicles:physics"}]

# Now compute the remaining b(|𝗩| norm(𝗩)•𝗨)² using display entity funkiness
data modify storage reds_vehicles:physics temp.b set from storage reds_vehicles:physics unapplied_forces[0].value
execute summon minecraft:block_display run function reds_vehicles:physics/utility/simple_lift_helper

# title @a actionbar [{"nbt": "temp.a","storage": "reds_vehicles:physics"}]


# Compute the final lift vector and apply to motion tag
function reds_vehicles:physics/utility/simple_lift_helper2 with storage reds_vehicles:physics temp

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




# Now square it, performing a precision adjustment as needed
# scoreboard players set 46340 vehicle.local 46340
# scoreboard players operation vehicle.u.x vehicle.local /= 46340 vehicle.local
# scoreboard players operation vehicle.u.x vehicle.local *= vehicle.u.x vehicle.local
# execute store result storage reds_vehicles:physics temp.dot float 0.000021579628830384117 run scoreboard players get vehicle.u.x vehicle.local


# At this point, we have: norm(𝗩) • 𝗨
# We want to calculate: b(𝗩•𝗨)²=b(|𝗩| norm(𝗩)•𝗨)²=b|𝗩|²(norm(𝗩)•𝗨)²


# Square the above calculated dot product




# Multiply by the constant "b"




# Obtain the acceleration vector (^ ^ ^$(a))
# data modify storage reds_vehicles:physics temp.x1 set from entity @s Pos[0]
# data modify storage reds_vehicles:physics temp.x2 set from entity @s Pos[1]
# data modify storage reds_vehicles:physics temp.x3 set from entity @s Pos[2]





# First, we compute the square-velocity using method the following method
#   1. Set up an 4-array of doubles with the following entries:
#       0. Value in vehicle.vel.x converted/scaled to a double
#       1. Value in vehicle.vel.y converted/scaled to a double
#       2. Value in vehicle.vel.z converted/scaled to a double
#       3. 0.0d
#   2. Summon a display entity
#   3. Write the above 4-array to left_rotation.  The game will automatically normalize this array and produce a unit vector
#   4. 
#   2. Write velocity scores to left_rotation[0:2]
#   2. Create an identity 4x4 transformation matrix and set the following elements:
#       * Store "x" in [4,4]
#   3. Push transformation matrix to display entity.  The game will automatically divide all 
#      elements in the matrix by the value in [4,4] to maintain homogeneous coordinates.  As 
#      a result, [0,0] now contains the reciprocal of x
#   4. Set up a new transformation matrix with the following elements:
#       * Get scale[0] from old matrix and store in 
#


# # Obtain forward-facing unit vector (x100 fixed-point precision)
# execute store result score vehicle.p1.x vehicle.local run data get entity @s Pos[0] 100
# execute store result score vehicle.p1.y vehicle.local run data get entity @s Pos[1] 100
# execute store result score vehicle.p1.z vehicle.local run data get entity @s Pos[2] 100
# execute positioned ^ ^ ^1 summon minecraft:marker run function reds_vehicles:physics/p2_to_score
# scoreboard players operation vehicle.p2.x vehicle.local -= vehicle.p1.x vehicle.local
# scoreboard players operation vehicle.p2.y vehicle.local -= vehicle.p1.y vehicle.local
# scoreboard players operation vehicle.p2.z vehicle.local -= vehicle.p1.z vehicle.local


# # Compute dot product between velocity vector and forward unit vector
# # The result is stored in vehicle.vel.x.temp with x100000 fixed-point precision
# scoreboard players operation vehicle.vel.x.temp vehicle.local = vehicle.vel.x vehicle.local
# scoreboard players operation vehicle.vel.y.temp vehicle.local = vehicle.vel.y vehicle.local
# scoreboard players operation vehicle.vel.z.temp vehicle.local = vehicle.vel.z vehicle.local
# scoreboard players operation vehicle.vel.x.temp vehicle.local /= 100 vehicle.constants
# scoreboard players operation vehicle.vel.y.temp vehicle.local /= 100 vehicle.constants
# scoreboard players operation vehicle.vel.z.temp vehicle.local /= 100 vehicle.constants
# scoreboard players operation vehicle.vel.x.temp vehicle.local *= vehicle.p2.x vehicle.local
# scoreboard players operation vehicle.vel.y.temp vehicle.local *= vehicle.p2.y vehicle.local
# scoreboard players operation vehicle.vel.z.temp vehicle.local *= vehicle.p2.z vehicle.local
# scoreboard players operation vehicle.vel.x.temp vehicle.local += vehicle.vel.y.temp vehicle.local
# scoreboard players operation vehicle.vel.x.temp vehicle.local += vehicle.vel.z.temp vehicle.local

# # Now compute the square of the dot product
# # The result is stored in vehicle.vel.x.temp with x1000000 fixed-point precision
# scoreboard players operation vehicle.vel.x.temp vehicle.local /= 100 vehicle.constants
# scoreboard players operation vehicle.vel.x.temp vehicle.local *= vehicle.vel.x.temp vehicle.local


# # Multiply the result by a constant, "b"
# $execute store result storage reds_vehicles:physics temp.x double $(value) run scoreboard players get vehicle.vel.x.temp vehicle.local
# execute store result score vehicle.bv2 vehicle.local run data get storage reds_vehicles:physics temp.x 0.001

# # title @a actionbar ["vehicle.vel.x.temp: ",{"score":{"name": "vehicle.vel.x.temp", "objective": "vehicle.local"}}]
# title @a actionbar ["vehicle.bv2: ",{"score":{"name": "vehicle.bv2", "objective": "vehicle.local"}}]


# # Obtain unit vector corresponding to direction of acceleration (x100 fixed-point precision)
# execute store result score vehicle.p1.x vehicle.local run data get entity @s Pos[0] 100
# execute store result score vehicle.p1.y vehicle.local run data get entity @s Pos[1] 100
# execute store result score vehicle.p1.z vehicle.local run data get entity @s Pos[2] 100
# execute positioned ^ ^1 ^ summon minecraft:marker run function reds_vehicles:physics/p2_to_score
# scoreboard players operation vehicle.p2.x vehicle.local -= vehicle.p1.x vehicle.local
# scoreboard players operation vehicle.p2.y vehicle.local -= vehicle.p1.y vehicle.local
# scoreboard players operation vehicle.p2.z vehicle.local -= vehicle.p1.z vehicle.local


# # Compute full acceleration vector
# scoreboard players operation vehicle.p2.x vehicle.local *= vehicle.bv2 vehicle.local
# scoreboard players operation vehicle.p2.y vehicle.local *= vehicle.bv2 vehicle.local
# scoreboard players operation vehicle.p2.z vehicle.local *= vehicle.bv2 vehicle.local

# # title @a actionbar [{"text":"x: "},{"score": {"name": "vehicle.p2.x","objective": "vehicle.local"}},{"text":", y: "},{"score": {"name": "vehicle.p2.y","objective": "vehicle.local"}},{"text":", z: "},{"score": {"name": "vehicle.p2.z","objective": "vehicle.local"}}]

# # Add to existing velocity
# scoreboard players operation vehicle.vel.x vehicle.local += vehicle.p2.x vehicle.local
# scoreboard players operation vehicle.vel.y vehicle.local += vehicle.p2.y vehicle.local
# scoreboard players operation vehicle.vel.z vehicle.local += vehicle.p2.z vehicle.local


# # Reset temporary scores
# scoreboard players reset vehicle.bv2 vehicle.local
# scoreboard players reset vehicle.vel.x.temp vehicle.local
# scoreboard players reset vehicle.vel.y.temp vehicle.local
# scoreboard players reset vehicle.vel.z.temp vehicle.local


# # Mark this force as active
# #tag @s add vehicle.force_active.simple_lift
