# This function gathers the pilot's xz-projected look vector input data
# It is run BY and AT the base vehicle entity

execute on passengers if entity @s[tag=vehicle.pilot_seat] on passengers at @s run function reds_vehicles:input/group/__look_xz
