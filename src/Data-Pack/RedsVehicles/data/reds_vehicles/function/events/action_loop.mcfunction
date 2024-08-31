# This function uses a recursion-based loop to iterate
# over the actions list and apply each one
#
# The action type is provided via function macros
#
# It is called from reds_vehicles:event/execute_event
# It is run BY and AT the base vehicle entity

# Run the corresponding action function
$function reds_vehicles:events/actions/$(action) with storage reds_vehicles:events unapplied_actions[0].arguments

# Pop this action from the list and run again if any remain
data remove storage reds_vehicles:events unapplied_actions[0]
execute if data storage reds_vehicles:events unapplied_actions[0] run function reds_vehicles:events/action_loop with storage reds_vehicles:events unapplied_actions[0]



