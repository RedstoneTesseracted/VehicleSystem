# Used by reds_vehicles:physics/accel_forward to do what *should* be basic math

# Summon temporary entity at position corresponding to the vector sum
$execute positioned ~$(vx) ~$(vy) ~$(vz) positioned ^ ^ ^$(a) summon minecraft:marker run function reds_vehicles:physics/utility/__accel_forward_helper
