# This function redeclares the precision table
# by calling all functions within the tag

data modify storage reds_vehicles:precision defaults set value []
function #reds_vehicles:declare_precisions
