# This function declare scoreboards/data used by the unit test suite

scoreboard objectives add vehicle.config.enable_test_suite dummy
scoreboard objectives add vehicle.unittest.local dummy
scoreboard objectives add vehicle.unittest.global dummy

# Default configuration scores
execute unless score config vehicle.config.enable_test_suite matches -2147483648..2147483647 run scoreboard players set config vehicle.config.enable_test_suite 0
scoreboard objectives modify vehicle.config.enable_test_suite displayname {"text":"Enable test suite","color":"aqua"} 

