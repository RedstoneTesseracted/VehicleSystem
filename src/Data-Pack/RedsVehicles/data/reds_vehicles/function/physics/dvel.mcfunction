# Changes the current velocity by the amount specified in the following scores:
#   vehicle.dvel.x
#   vehicle.dvel.y
#   vehicle.dvel.z
#
# Said scores are reset to zero afterwards
#
# This function is called from reds_vehicles:physics/apply

# Apply "value" scale and correct for precision difference
$execute store result storage reds_vehicles:physics temp.x double $(value) run scoreboard players get @s vehicle.dvel.x
$execute store result storage reds_vehicles:physics temp.y double $(value) run scoreboard players get @s vehicle.dvel.y
$execute store result storage reds_vehicles:physics temp.z double $(value) run scoreboard players get @s vehicle.dvel.z
execute store result score @s vehicle.dvel.x run data get storage reds_vehicles:physics temp.x 100.0
execute store result score @s vehicle.dvel.y run data get storage reds_vehicles:physics temp.y 100.0
execute store result score @s vehicle.dvel.z run data get storage reds_vehicles:physics temp.z 100.0
data remove storage reds_vehicles:physics temp

#scoreboard players operation @s vehicle.dvel.x *= 100 vehicle.constants
#scoreboard players operation @s vehicle.dvel.y *= 100 vehicle.constants
#scoreboard players operation @s vehicle.dvel.z *= 100 vehicle.constants

# Change velocity
scoreboard players operation vehicle.vel.x vehicle.local += @s vehicle.dvel.x
scoreboard players operation vehicle.vel.y vehicle.local += @s vehicle.dvel.y
scoreboard players operation vehicle.vel.z vehicle.local += @s vehicle.dvel.z

title @a actionbar [{"score": {"name": "vehicle.vel.x","objective": "vehicle.local"}},{"text": ", "},{"score": {"name": "vehicle.vel.y","objective": "vehicle.local"}},{"text": ", "},{"score": {"name": "vehicle.vel.z","objective": "vehicle.local"}}]

# Reset scores
scoreboard players set @s vehicle.dvel.x 0
scoreboard players set @s vehicle.dvel.y 0
scoreboard players set @s vehicle.dvel.z 0
