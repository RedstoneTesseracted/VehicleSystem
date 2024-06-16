# This function is used to calculate the vehicle's acceleration vector
# This version is for both flying and submarine-like vehicles that have full XYZ motion
#
# It is run BY the vehicle seat entity WHEN a player is riding it
#
# First, we obtain the player's motion vector.  This is nonzero whilst the player is riding an entity.
# This vector will be in the (x,z) basis, but we need it in the (u,v) basis
#       Where u=Unit vector in the direction the player facing, but with zero elevation
#             v=Unit vector orthogonal to u in the horizontal direction, again with zero elevation
#
#       Additionally, both (x,z) and (u,v) are orthonormal bases that span the XZ plane
#
# Mathematically, this is achieved by:
#       m = (m•u)u + (m•v)v
#
# However, note that (x,z) and (u,v) must differ solely by a rotation—specifically a rotation by the 
# player's angle about the y-axis.  We can exploit this to make Minecraft do the calculations for us
# 
# So, to obtain m with respect to (u,v):
#   1) Obtain m with respect to (x, z)
#   2) Facing the direction of m, rotate opposite to the player's current rotation, and summon a marker 1 block away
#   3) Use marker to obtain rotated motion vector

# Obtain player's motion vector and -1*rotation.  Due to technical limitations, the y-component is useless to us
data merge storage vehicle:utility {args:{x:0.0d,z:0.0d,rot:0.0d}}

# Obtain the player's normalized motion vector
execute on passengers at @s store result score vehicle.x vehicle.local run data get entity @s Motion[0] 572105.9149579407
execute on passengers at @s store result score vehicle.z vehicle.local run data get entity @s Motion[2] 572105.9149579407
execute on passengers at @s store result storage vehicle:utility args.x float 0.0001 run scoreboard players get vehicle.x vehicle.local
execute on passengers at @s store result storage vehicle:utility args.z float 0.0001 run scoreboard players get vehicle.z vehicle.local

# Obtain the negative of the player's rotation
execute on passengers at @s store result score vehicle.rotation vehicle.local run data get entity @s Rotation[0] -10000
execute on passengers at @s store result storage vehicle:utility args.rot float 0.0001 run scoreboard players get vehicle.rotation vehicle.local


# Place marker at player and at counter-rotated motion-position
execute on passengers at @s run summon minecraft:marker ~ ~ ~ {Tags:["vehicle.p1"]}
execute on passengers at @s rotated 0 0 run function reds_vehicles:input/__place_p2_relative with storage vehicle:utility args


# Get vector to counter-rotated motion-position
execute store result score vehicle.p1.x vehicle.local run data get entity @e[type=minecraft:marker,tag=vehicle.p1,limit=1,sort=nearest] Pos[0] 1000
execute store result score vehicle.p1.z vehicle.local run data get entity @e[type=minecraft:marker,tag=vehicle.p1,limit=1,sort=nearest] Pos[2] 1000

execute store result score vehicle.p2.x vehicle.local run data get entity @e[type=minecraft:marker,tag=vehicle.p2,limit=1,sort=nearest] Pos[0] 1000
execute store result score vehicle.p2.z vehicle.local run data get entity @e[type=minecraft:marker,tag=vehicle.p2,limit=1,sort=nearest] Pos[2] 1000

scoreboard players operation vehicle.p2.x vehicle.local -= vehicle.p1.x vehicle.local
scoreboard players operation vehicle.p2.z vehicle.local -= vehicle.p1.z vehicle.local



# Remove the second temporary marker—we still need the first
kill @e[type=minecraft:marker,tag=vehicle.p2]


# Now use the found (u,v) vector relative to the player's actual direction vector (elevation included)
data merge storage vehicle:utility {args:{x:0.0d,z:0.0d,rot:0.0d}}
execute store result storage vehicle:utility args.x double 0.001 run scoreboard players get vehicle.p2.x vehicle.local
execute store result storage vehicle:utility args.z double 0.001 run scoreboard players get vehicle.p2.z vehicle.local
execute on passengers at @s run function reds_vehicles:input/__place_p2_relative with storage vehicle:utility args


# Get the components of the new vector
execute store result score vehicle.p1.y vehicle.local run data get entity @e[type=minecraft:marker,tag=vehicle.p1,limit=1,sort=nearest] Pos[1] 1000

execute store result score vehicle.p2.x vehicle.local run data get entity @e[type=minecraft:marker,tag=vehicle.p2,limit=1,sort=nearest] Pos[0] 1000
execute store result score vehicle.p2.y vehicle.local run data get entity @e[type=minecraft:marker,tag=vehicle.p2,limit=1,sort=nearest] Pos[1] 1000
execute store result score vehicle.p2.z vehicle.local run data get entity @e[type=minecraft:marker,tag=vehicle.p2,limit=1,sort=nearest] Pos[2] 1000

scoreboard players operation vehicle.p2.x vehicle.local -= vehicle.p1.x vehicle.local
scoreboard players operation vehicle.p2.y vehicle.local -= vehicle.p1.y vehicle.local
scoreboard players operation vehicle.p2.z vehicle.local -= vehicle.p1.z vehicle.local

# Remove both temporary markers
kill @e[type=minecraft:marker,tag=vehicle.p1]
kill @e[type=minecraft:marker,tag=vehicle.p2]


# Increase precision by 100 to match gather_2d
scoreboard players operation vehicle.p2.x vehicle.local *= 100 vehicle.constants
scoreboard players operation vehicle.p2.y vehicle.local *= 100 vehicle.constants
scoreboard players operation vehicle.p2.z vehicle.local *= 100 vehicle.constants


# Store results in expected location
scoreboard players operation vehicle.input.x vehicle.local = vehicle.p2.x vehicle.local
scoreboard players operation vehicle.input.y vehicle.local = vehicle.p2.y vehicle.local
scoreboard players operation vehicle.input.z vehicle.local = vehicle.p2.z vehicle.local
