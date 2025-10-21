# This function recursively loops over the logged error list and prints one at a time
#
# Before running this function, the "errors" tag within the reds_vehicles:logging 
# storage is copied over to "unprinted_errors" within the same storage.  This allows
# us to pop errors from the list without affecting the original error list.
#
# This function is called from reds_vehicles:define/notify/show_errors

# Pop first entry from list
data modify storage reds_vehicles:logging working_error set from storage reds_vehicles:logging unprinted_errors[0]
data remove storage reds_vehicles:logging unprinted_errors[0]

# Print error message
tellraw @s {text:"---------------------------------------------",color:"dark_red"}
tellraw @s {translate:"reds_vehicles.notify.errors.function",fallback:"Function: \"%s\"",with:[{nbt:"working_error.source",storage:"reds_vehicles:logging",interpret:false,color:"gold"}],color:"red"}
tellraw @s {translate:"reds_vehicles.notify.errors.vehicle",fallback:"Vehicle: \"%s\"",with:[{nbt:"working_error.vehicle",storage:"reds_vehicles:logging",interpret:true,color:"gold"}],color:"red"}
tellraw @s {translate:"reds_vehicles.notify.errors.description",fallback:"Description: %s",with:[{nbt:"working_error.description",storage:"reds_vehicles:logging",interpret:true,color:"gold"}],color:"red"}
tellraw @s {translate:"reds_vehicles.notify.errors.code",fallback:"Code: %s",with:[{nbt:"working_error.code",storage:"reds_vehicles:logging",interpret:false,color:"gold"}],color:"red"}
execute if data storage reds_vehicles:logging working_error.extra run tellraw @s {translate:"reds_vehicles.notify.errors.extra",fallback:"Extra: %s",with:[{translate:"reds_vehicles.notify.errors.extra_hover",fallback:"[hover]",color:"aqua",hover_event:{action:"show_text",value:{nbt:"working_error.extra", storage: "reds_vehicles:logging", interpret: false}}}],color:"red"}

# Run this function again if errors remain
execute if data storage reds_vehicles:logging unprinted_errors[0] run function reds_vehicles:define/notify/show_errors_loop
