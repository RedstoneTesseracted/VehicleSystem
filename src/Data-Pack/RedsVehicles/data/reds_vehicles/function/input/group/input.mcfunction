# This function gathers input data about what direction the pilot is trying to
# move in (forwards/backwards, left/right)
# It is run BY and AT the base vehicle entity

execute on passengers if entity @s[tag=vehicle.pilot_seat] on passengers at @s run function reds_vehicles:input/group/__input
