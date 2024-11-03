# This function runs when a test exceeds its allotted time to execute.
# Technically, this test SHOULD NEVER BE RUN

# Obtain the name of the test we just tried to execute

# Display text
tellraw @a ["",{"nbt": "current_test", "storage": "reds_vehicles:unittest"},{"text":" - ","color": "white"},{"text":"TIMED OUT","color": "#FF0000","bold": true}]

# Show error log if any are present
execute if data storage reds_vehicles:logging errors[0] run function reds_vehicles:define/notify/show_errors

tellraw @a {"text":"---------------------------------------------"}

# Prepare to run next test
schedule function rv_unittest:next 1t

# Return fail
return fail
