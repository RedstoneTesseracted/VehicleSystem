# This function handles the per-tick requirements of the vehicle system

# Perform vehicle behavior
execute as @e[tag=vehicle.base] at @s run function reds_vehicles:vehicle/root

# Reset camera distance when player unmounts vehicle
execute as @a[tag=vehicle.riding] unless function reds_vehicles:vehicle/is_riding_vehicle run function reds_vehicles:vehicle/unmount
