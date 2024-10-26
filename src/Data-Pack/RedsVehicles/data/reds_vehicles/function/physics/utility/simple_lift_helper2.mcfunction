# This function is used by reds_vehicles:physics/types/simple_lift
# to scale the lift direction unit vector by the lift force magnitude
#
# This uses function macros in order to generate the vector in the vehicle's
# coordinate system
#
# The result is stored in temp.[dx,dy,dz]
# $say check $(a)
$execute positioned ^ ^$(a) ^ summon minecraft:marker run function reds_vehicles:physics/utility/precision_vector_calc with storage reds_vehicles:physics temp
