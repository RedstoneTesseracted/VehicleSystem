# This function runs one tick AFTER reload to make sure vehicle loading wasn't
# interrupted from hitting the maximum command count.

# Check scoreboard value
execute store result score vehicle.max_command_count vehicle.local run gamerule maxCommandChainLength
execute if score vehicle.vehicle_define_in_progress vehicle.global matches 1 run tellraw @a [{text:"[Red's Vehicles]: ",color:"#FF0000",italic:false},{translate:"reds_vehicles.notify.fatal.command_limit_exceeded",fallback:"A fatal error occurred that prevented vehicle loading from finishing.  The maximum command limit (%s) may have been reached.",with:[{"score":{"name":"vehicle.max_command_count","objective":"vehicle.local"},italic:true}],color:"red",italic:false}]
scoreboard players reset vehicle.max_command_count vehicle.local

# Enter safe mode by nuking the processed vehicles list
execute if score vehicle.vehicle_define_in_progress vehicle.global matches 1 run data modify storage reds_vehicles:definitions processed set value []
