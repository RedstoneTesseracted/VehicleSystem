# This function gathers pilot's rotation input data
# It is run BY and AT the base vehicle entity

execute on passengers if entity @s[tag=vehicle.pilot_seat] on passengers run function reds_vehicles:input/group/__rotation
