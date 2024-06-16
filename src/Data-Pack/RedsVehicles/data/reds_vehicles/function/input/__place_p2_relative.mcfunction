# This function places p2 using carret notation.
# Exact placement is specified using function macros.
# It is called during gather_3d to help obtain the player's acceleration vector

$execute rotated ~$(rot) ~ run summon minecraft:marker ^$(x) ^ ^$(z) {Tags:["vehicle.p2"]}
