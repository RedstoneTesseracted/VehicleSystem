# Used by reds_vehicles:input/group/__directed to use reds_vehicles:input/group/position_to_score
# after applying the motion vector's contribution

$execute positioned ^$(w) ^ ^$(u) summon minecraft:marker run function reds_vehicles:input/group/position_to_score {point: "p2"}
#$particle minecraft:dust{color:[1.0f,0.0f,0.0f],scale:1.0f} ^$(w) ^ ^$(u) 0 0 0 1 20
