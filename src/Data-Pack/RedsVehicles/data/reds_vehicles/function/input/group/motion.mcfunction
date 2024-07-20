# This function gathers the pilot's normalized motion input data
# It is run BY and AT the base vehicle entity

execute on passengers if entity @s[tag=vehicle.pilot_seat] on passengers run function reds_vehicles:input/group/__motion
