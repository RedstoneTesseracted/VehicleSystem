# Root function that branches out to other functions to apply vehicle physics
# It is run BY the vehicle base entity regardless of whether anyone is in the seat

execute if score @s vehicle.physics_type matches 1 run function reds_vehicles:physics/accelerate
execute if score @s vehicle.physics_type matches 2 run function reds_vehicles:physics/instant
execute if score @s vehicle.physics_type matches 3 run function reds_vehicles:physics/plane
