# This function is run by the test suite once all tests have been run
# It is used to set certain state flags and output a summary

# Clear the timeout function (shouldn't occur, but just to be safe...)
schedule clear rv_unittest:common/timeout

# Obtain results to print
execute store result score vehicle.unittest.total_passed vehicle.unittest.local run data get storage reds_vehicles:unittest results.passed
execute store result score vehicle.unittest.total_failed vehicle.unittest.local run data get storage reds_vehicles:unittest results.failed

# Print header
execute if data storage reds_vehicles:unittest results.failed[0] run tellraw @a [{text:"============== SUMMARY ==============",color:"red"}]
execute unless data storage reds_vehicles:unittest results.failed[0] run tellraw @a [{text:"============== SUMMARY ==============",color:"green"}]

# Print data
tellraw @a [{text:"  Total: "},{"score": {"name": "vehicle.unittest.total_tests", "objective": "vehicle.unittest.global"}}]

execute if data storage reds_vehicles:unittest results.failed[0] run tellraw @a [{text:"  "},{text:"Succeeded: ",color: "green"},{"score": {"name": "vehicle.unittest.total_passed", "objective": "vehicle.unittest.local"},color: "#00FF00"}]
execute if data storage reds_vehicles:unittest results.failed[0] run tellraw @a [{text:"  "},{text:"Failed: ",color: "red",bold: true},{"score": {"name": "vehicle.unittest.total_failed", "objective": "vehicle.unittest.local"},color:"#FF0000"}]

execute unless data storage reds_vehicles:unittest results.failed[0] run tellraw @a [{text:"  "},{text:"Succeeded: ",color: "green",bold: true},{"score": {"name": "vehicle.unittest.total_passed", "objective": "vehicle.unittest.local"},color: "#00FF00"}]
execute unless data storage reds_vehicles:unittest results.failed[0] run tellraw @a [{text:"  "},{text:"Failed: ",color: "green"},{"score": {"name": "vehicle.unittest.total_failed", "objective": "vehicle.unittest.local"},color:"white"}]

tellraw @a [{text:"\n  "},{translate: "reds_vehicles.unittest.finish.reload_hint",color:"gray",fallback: "It is recommended you run %s after running the test suite before using the vehicle system",with: [{text:"/reload",underlined: true,color:"#CFCFCF",hover_event: {action: "show_text", value: "/reload"},click_event: {action: "suggest_command", command: "/reload"}}]}]
