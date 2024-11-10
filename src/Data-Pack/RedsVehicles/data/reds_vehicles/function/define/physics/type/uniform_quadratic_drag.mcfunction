# Mark type as present
scoreboard players set vehicle.physics_type_exists vehicle.local 1

# "value" field is required
execute unless data storage reds_vehicles:definitions working_physics.value run function reds_vehicles:define/physics/report/value_missing
execute unless data storage reds_vehicles:definitions working_physics.value run return 0

# Convert value to float
execute store result score vehicle.float_convert_success vehicle.local run function reds_vehicles:define/physics/utility/value_to_float with storage reds_vehicles:definitions working_physics
execute if score vehicle.float_convert_success vehicle.local matches 0 run function reds_vehicles:define/physics/report/value_to_float_failed
execute if score vehicle.float_convert_success vehicle.local matches 0 run return 0

# No, you may NOT provide your own "inverse_value" field
data remove storage reds_vehicles:definitions working_physics.inverse_value

# "value" CANNOT be zero
data modify storage reds_vehicles:definitions temp.compare set value 0.0f
execute store result score vehicle.compare_changed vehicle.local run data modify storage reds_vehicles:definitions temp.compare set from storage reds_vehicles:definitions working_physics.value
data remove storage reds_vehicles:definitions temp.compare
execute if score vehicle.compare_changed vehicle.local matches 0 run function reds_vehicles:define/physics/report/zero_value
execute if score vehicle.compare_changed vehicle.local matches 0 run return 0

# Compute inverse of value and populate field
execute summon minecraft:block_display run function reds_vehicles:define/physics/utility/inverse_value

# Tell macro that everything is fine
return 1
