# This function is used to calculate the vehicle's acceleration vector
# This version is for car-like vehicles that are mostly confined to XZ motion
#
# It is run BY the vehicle seat entity WHEN a player is riding it

# Obtain player movement vector (x100,000 FP)
# Normalize as we do so (inverse norm of vector is about 57.21059149579407)
execute on passengers at @s store result score vehicle.input.x vehicle.local run data get entity @s Motion[0] 5721059.149579407
scoreboard players set vehicle.input.y vehicle.local 0
execute on passengers at @s store result score vehicle.input.z vehicle.local run data get entity @s Motion[2] 5721059.149579407

