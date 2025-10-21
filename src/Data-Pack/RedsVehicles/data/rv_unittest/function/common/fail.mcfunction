# This function is used to display the outcome a unit test when it fails
#
# The name of the unit test must be provided via the "name" field
# in the "reds_vehicles:unittest" storage

# Mark test as failed in storage
data modify storage reds_vehicles:unittest results.failed append from storage reds_vehicles:unittest name

# Display text
tellraw @a ["",{nbt:"name",storage: "reds_vehicles:unittest",hover_event: {action: "show_text", value: {nbt: "description", storage: "reds_vehicles:unittest",interpret: true}}},{text:" - ",color:"white"},{text:"FAILED",color:"red",bold:true}]
tellraw @a [{text: "  ",color:"red",italic:true},{text: "  Reason: ",italic:false},{nbt:"reason",storage: "reds_vehicles:unittest",interpret: true}]
tellraw @a [{text: "  ",color:"red",italic:true},{text: "  Error log: ",italic:false}]

# Show error log if any are present
execute if data storage reds_vehicles:logging errors[0] as @a run function reds_vehicles:define/notify/show_errors

tellraw @a {text:"---------------------------------------------"}

# Clear timeout and prepare to run next test
schedule clear rv_unittest:common/timeout
execute if score vehicle.unittest.suite_running vehicle.unittest.global matches 1 run schedule function rv_unittest:next 1t

# Return fail
return fail
