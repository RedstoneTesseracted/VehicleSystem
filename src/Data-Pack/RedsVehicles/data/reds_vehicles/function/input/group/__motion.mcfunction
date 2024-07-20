# Function used by reds_vehicles:input/group/motion to shift the execution to the pilot

# We assume a standard vector length of 57.21059149579407
execute store result storage reds_vehicles:inputs input.motion.x float 0.0005721059149579407 run data get entity @s Motion[0] 100000
execute store result storage reds_vehicles:inputs input.motion.z float 0.0005721059149579407 run data get entity @s Motion[2] 100000
