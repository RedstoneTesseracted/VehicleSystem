# This function is used to display the outcome a unit test when it succeeds
#
# The name of the unit test must be provided via the "name" field
# in the "reds_vehicles:unittest" storage

# Mark test as passed in storage
data modify storage reds_vehicles:unittest results.passed append from storage reds_vehicles:unittest name

# Display text
tellraw @a ["",{"nbt":"name","storage": "reds_vehicles:unittest","hoverEvent": {"action": "show_text","contents": {"nbt": "description", "storage": "reds_vehicles:unittest","interpret": true}}},{"text":" - ","color":"white"},{"text":"SUCCESS","color":"green","bold":true}]

# Clear timeout and prepare to run next test
schedule clear rv_unittest:common/timeout
execute if score vehicle.unittest.suite_running vehicle.unittest.global matches 1 run schedule function rv_unittest:next 1t

# Return success
return 1
