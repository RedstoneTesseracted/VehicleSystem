# Used by heading_diff to get the yaw/pitch angles corresponding to an x,y,z vector

# Point entity in direction of vector
function reds_vehicles:input/group/____heading_diff with storage reds_vehicles:inputs temp

# Extract results to scoreboard
execute store result score vehicle.heading.yaw vehicle.local run data get entity @s Rotation[0] 10000
execute store result score vehicle.heading.pitch vehicle.local run data get entity @s Rotation[1] 10000

# Remove temporary entity
kill @s[type=minecraft:marker]
