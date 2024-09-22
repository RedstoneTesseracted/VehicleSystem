# Convenience function that reports a test failure if the 
# number of logged errors is not equal to one

execute unless data storage reds_vehicles:logging errors[0] run data modify storage reds_vehicles:unittest reason set value [{text:"No error was logged"}]
execute unless data storage reds_vehicles:logging errors[0] run return 0
execute if data storage reds_vehicles:logging errors[1] run data modify storage reds_vehicles:unittest reason set value [{text:"Was not expecting multiple errors to be raised"}]
execute if data storage reds_vehicles:logging errors[1] run return 0
return 1
