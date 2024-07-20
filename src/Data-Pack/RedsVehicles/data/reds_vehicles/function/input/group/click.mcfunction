# This function gathers input data about whether the vehicle's interaction entity was
# just right or left-clicked
# It is run BY and AT the base vehicle entity

# Compare last clicked time against current time
data modify storage reds_vehicles:inputs input.click set value {left: 0b, right: 0b}
execute store result score vehicle.current_time vehicle.local run time query gametime
execute on passengers if entity @s[tag=vehicle.pilot_seat] run function reds_vehicles:input/group/__click
