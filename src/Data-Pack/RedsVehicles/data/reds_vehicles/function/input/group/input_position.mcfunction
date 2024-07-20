# Used by reds_vehicles:input/group/__directed to use reds_vehicles:input/group/position_to_score
# after applying the motion vector's contribution

$execute positioned ~$(x) ~ ~$(z) summon minecraft:marker run function reds_vehicles:input/group/xz_position_to_score {point: "p2"}
