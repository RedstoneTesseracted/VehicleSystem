# This function adds fuel to the vehicle's internal tank.
#
# Though each can adds up to 1000 units of fuel, any fuel
# that exceeds the tank's capacity will be rejected.  The amount
# of fuel actually added is returned.
#
# The amount of fuel in the tank after this operation as well
# as the tank capacity are written to the scores 
# vehicle.current_fuel:vehicle.local and vehicle.max_fuel:vehicle.local
# respectively
#

scoreboard players set vehicle.max_fuel vehicle.local 0
scoreboard players set vehicle.current_fuel vehicle.local 0

# Grab this vehicle's definition
# If there is no matching definition, exit early
execute unless function reds_vehicles:vehicle/grab_executor_definition run return 0

# Determine how much fuel we can add
execute if data storage reds_vehicles:definitions current{accepts_fuel: false} run return 0
execute store result score vehicle.max_fuel vehicle.local run data get storage reds_vehicles:definitions current.max_fuel 1
execute store result score vehicle.fuel_added vehicle.local run data get storage reds_vehicles:definitions current.max_fuel 1
scoreboard players operation vehicle.fuel_added vehicle.local -= @s vehicle.fuel
execute if score vehicle.fuel_added vehicle.local matches 1000.. run scoreboard players set vehicle.fuel_added vehicle.local 1000

# Add that amount of fuel and return the result
scoreboard players operation @s vehicle.fuel += vehicle.fuel_added vehicle.local
scoreboard players operation vehicle.current_fuel vehicle.local = @s vehicle.fuel
return run scoreboard players get vehicle.fuel_added vehicle.local
