# This handles the first part of the vector transformation in reds_vehicles:physics/utility/precision_roll_helper
# It only transforms the vector using the context's pitch and yaw
#
# This function must be called using:
# execute positioned 0.0 0.0 0.0 run function reds_vehicles:physics/utility/precision_roll_helper_part1 with storage reds_vehicles:physics temp
#
# Additionally, it relies on external setup as outlined in reds_vehicles:physics/utility/precision_roll_helper

$execute positioned ^$(w) ^$(v) ^$(u) summon minecraft:marker run function reds_vehicles:physics/utility/__precision_roll_helper_part1
