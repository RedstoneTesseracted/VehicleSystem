# This is the master script that executes all unit tests

# Config guard
execute unless score config vehicle.config.enable_test_suite matches 1 run tellraw @a ["",{text:"[Red's Vehicles]: ",color:"#FF0000"},{translate:"reds_vehicles.unittest.not_enabled",color:"red",italic:false,fallback: "Test suite is not enabled on this world!  To enable, run %s",with: [{text:"scoreboard players set config vehicle.config.enable_test_suite 1",underlined: false,italic: false, color: "light_purple",click_event: {action: "suggest_command", command: "/scoreboard players set config vehicle.config.enable_test_suite 1"},hover_event: {action: "show_text", value: "/scoreboard players set config vehicle.config.enable_test_suite 1"}}]}]
execute unless score config vehicle.config.enable_test_suite matches 1 run return fail

# Header
tellraw @a [{text:"======= RUNNING UNIT TEST SUITE =======",color:"green"}]

# Load list of existing unit tests
function rv_unittest:declare_tests

# Reset global storage
data modify storage reds_vehicles:unittest current_test set value "<None>"
data modify storage reds_vehicles:unittest results set value {passed: [], failed: []}

# Set the "suite_running" flag to "true"
scoreboard players set vehicle.unittest.suite_running vehicle.unittest.global 1

# Begin execution
function rv_unittest:next
