data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/action/parse"
data modify storage reds_vehicles:logging error.description set value [{text:"\""},{"text":""},{"text":"\" is not a recognized action type"}]
data modify storage reds_vehicles:logging error.description[1].text set from storage reds_vehicles:definitions working_action.action
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 39

function reds_vehicles:define/logging/log_auto_fill_name
