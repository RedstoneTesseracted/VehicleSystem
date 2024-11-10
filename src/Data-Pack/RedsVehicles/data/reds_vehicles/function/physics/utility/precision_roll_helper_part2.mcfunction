# This handles the second part of the vector transformation in reds_vehicles:physics/utility/precision_roll_helper
# It only transforms the vector using the roll argument
#
# To achieve this, we exploit the fact that:
# [1 0 0]          [1 0 0]
# [0 0 1] R_yaw(α) [0 0 1] = R_roll(α)
# [0 1 0]          [0 1 0]
#
# That is to say: we can convert a roll rotation into a yaw rotation by temporarily the y & z coordinates.
#
# This function must be called using:
# execute positioned 0.0 0.0 0.0 run function reds_vehicles:physics/utility/precision_roll_helper_part2 with storage reds_vehicles:physics temp
#
# Additionally, it relies on external setup as outlined in reds_vehicles:physics/utility/precision_roll_helper
$say $(roll)
$execute rotated $(roll) 0.0 positioned ^$(dy) ^$(dz) ^$(dx) summon minecraft:marker run function reds_vehicles:physics/utility/__precision_roll_helper_part2
