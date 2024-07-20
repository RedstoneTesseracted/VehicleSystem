# Changes the current velocity by the amount specified in the following scores:
#   vehicle.dvel.x
#   vehicle.dvel.y
#   vehicle.dvel.z
#
# Said scores are reset to zero afterwards
#
# This function is called from reds_vehicles:physics/apply

# Correct for precision difference
scoreboard players operation @s vehicle.dvel.x *= 100 vehicle.constants
scoreboard players operation @s vehicle.dvel.y *= 100 vehicle.constants
scoreboard players operation @s vehicle.dvel.z *= 100 vehicle.constants

# Change velocity
scoreboard players operation vehicle.vel.x vehicle.local += @s vehicle.dvel.x
scoreboard players operation vehicle.vel.y vehicle.local += @s vehicle.dvel.y
scoreboard players operation vehicle.vel.z vehicle.local += @s vehicle.dvel.z

# Reset scores
scoreboard players set @s vehicle.dvel.x 0
scoreboard players set @s vehicle.dvel.y 0
scoreboard players set @s vehicle.dvel.z 0
