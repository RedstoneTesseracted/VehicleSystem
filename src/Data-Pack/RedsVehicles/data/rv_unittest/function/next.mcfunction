# This function executes the next unit test

# Finish the test suite if no tests remain
execute unless data storage reds_vehicles:unittest tests[0] run function rv_unittest:finish
execute unless data storage reds_vehicles:unittest tests[0] run return 1

# Get the next test to be run
data modify storage reds_vehicles:unittest current_test set from storage reds_vehicles:unittest tests[0]
data remove storage reds_vehicles:unittest tests[0]

# Schedule a timeout function in case something goes wrong
schedule function rv_unittest:common/timeout 10t

# Schedule this test's function
function rv_unittest:__next with storage reds_vehicles:unittest {}
