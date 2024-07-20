# Function used by reds_vehicles:input/group/rotation to shift the execution to the pilot

data modify storage reds_vehicles:inputs input.rotation.yaw set from entity @s Rotation[0]
data modify storage reds_vehicles:inputs input.rotation.pitch set from entity @s Rotation[1]

