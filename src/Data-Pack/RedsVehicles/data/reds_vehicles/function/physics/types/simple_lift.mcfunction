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
# * The direction of acceleration is given using the vehicle's vertical
#   transverse unit vector (^ ^1 ^)

# Originally, I implemented this mainly using integer arithmetic.
# Unfortunately, that implementation succumbed precision loss, and tended to explode easily
#
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
#      a result, [0,0] now contains the reciprocol of x
#   4. Set up a new transformation matrix with the following elements:
#       * Get scale[0] from old matrix and store in 
#


# Obtain forward-facing unit vector (x100 fixed-point precision)
execute store result score vehicle.p1.x vehicle.local run data get entity @s Pos[0] 100
execute store result score vehicle.p1.y vehicle.local run data get entity @s Pos[1] 100
execute store result score vehicle.p1.z vehicle.local run data get entity @s Pos[2] 100
execute positioned ^ ^ ^1 summon minecraft:marker run function reds_vehicles:physics/p2_to_score
scoreboard players operation vehicle.p2.x vehicle.local -= vehicle.p1.x vehicle.local
scoreboard players operation vehicle.p2.y vehicle.local -= vehicle.p1.y vehicle.local
scoreboard players operation vehicle.p2.z vehicle.local -= vehicle.p1.z vehicle.local


# Compute dot product between velocity vector and forward unit vector
# The result is stored in vehicle.vel.x.temp with x100000 fixed-point precision
scoreboard players operation vehicle.vel.x.temp vehicle.local = vehicle.vel.x vehicle.local
scoreboard players operation vehicle.vel.y.temp vehicle.local = vehicle.vel.y vehicle.local
scoreboard players operation vehicle.vel.z.temp vehicle.local = vehicle.vel.z vehicle.local
scoreboard players operation vehicle.vel.x.temp vehicle.local /= 100 vehicle.constants
scoreboard players operation vehicle.vel.y.temp vehicle.local /= 100 vehicle.constants
scoreboard players operation vehicle.vel.z.temp vehicle.local /= 100 vehicle.constants
scoreboard players operation vehicle.vel.x.temp vehicle.local *= vehicle.p2.x vehicle.local
scoreboard players operation vehicle.vel.y.temp vehicle.local *= vehicle.p2.y vehicle.local
scoreboard players operation vehicle.vel.z.temp vehicle.local *= vehicle.p2.z vehicle.local
scoreboard players operation vehicle.vel.x.temp vehicle.local += vehicle.vel.y.temp vehicle.local
scoreboard players operation vehicle.vel.x.temp vehicle.local += vehicle.vel.z.temp vehicle.local

# Now compute the square of the dot product
# The result is stored in vehicle.vel.x.temp with x1000000 fixed-point precision
scoreboard players operation vehicle.vel.x.temp vehicle.local /= 100 vehicle.constants
scoreboard players operation vehicle.vel.x.temp vehicle.local *= vehicle.vel.x.temp vehicle.local


# Multiply the result by a constant, "b"
$execute store result storage reds_vehicles:physics temp.x double $(value) run scoreboard players get vehicle.vel.x.temp vehicle.local
execute store result score vehicle.bv2 vehicle.local run data get storage reds_vehicles:physics temp.x 0.001

# title @a actionbar ["vehicle.vel.x.temp: ",{"score":{"name": "vehicle.vel.x.temp", "objective": "vehicle.local"}}]
title @a actionbar ["vehicle.bv2: ",{"score":{"name": "vehicle.bv2", "objective": "vehicle.local"}}]


# Obtain unit vector corresponding to direction of acceleration (x100 fixed-point precision)
execute store result score vehicle.p1.x vehicle.local run data get entity @s Pos[0] 100
execute store result score vehicle.p1.y vehicle.local run data get entity @s Pos[1] 100
execute store result score vehicle.p1.z vehicle.local run data get entity @s Pos[2] 100
execute positioned ^ ^1 ^ summon minecraft:marker run function reds_vehicles:physics/p2_to_score
scoreboard players operation vehicle.p2.x vehicle.local -= vehicle.p1.x vehicle.local
scoreboard players operation vehicle.p2.y vehicle.local -= vehicle.p1.y vehicle.local
scoreboard players operation vehicle.p2.z vehicle.local -= vehicle.p1.z vehicle.local


# Compute full acceleration vector
scoreboard players operation vehicle.p2.x vehicle.local *= vehicle.bv2 vehicle.local
scoreboard players operation vehicle.p2.y vehicle.local *= vehicle.bv2 vehicle.local
scoreboard players operation vehicle.p2.z vehicle.local *= vehicle.bv2 vehicle.local

# title @a actionbar [{"text":"x: "},{"score": {"name": "vehicle.p2.x","objective": "vehicle.local"}},{"text":", y: "},{"score": {"name": "vehicle.p2.y","objective": "vehicle.local"}},{"text":", z: "},{"score": {"name": "vehicle.p2.z","objective": "vehicle.local"}}]

# Add to existing velocity
scoreboard players operation vehicle.vel.x vehicle.local += vehicle.p2.x vehicle.local
scoreboard players operation vehicle.vel.y vehicle.local += vehicle.p2.y vehicle.local
scoreboard players operation vehicle.vel.z vehicle.local += vehicle.p2.z vehicle.local


# Reset temporary scores
scoreboard players reset vehicle.bv2 vehicle.local
scoreboard players reset vehicle.vel.x.temp vehicle.local
scoreboard players reset vehicle.vel.y.temp vehicle.local
scoreboard players reset vehicle.vel.z.temp vehicle.local


# Mark this force as active
#tag @s add vehicle.force_active.simple_lift
