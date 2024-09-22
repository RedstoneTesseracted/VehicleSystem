#### UNIT TEST ####

# Check that the current version is valid
data modify storage reds_vehicles:unittest name set value "general/check_valid_version"
data modify storage reds_vehicles:unittest description set value {text:"Checks that the datapack version number is valid"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Get datapack format number (should be nonzero)
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:datapack_format
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Unrecognized datapack version"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

#####################################################################################################

# Everything passed!
return run function rv_unittest:common/pass
