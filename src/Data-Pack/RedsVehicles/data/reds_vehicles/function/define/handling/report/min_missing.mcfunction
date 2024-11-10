data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/handling/parse"
data modify storage reds_vehicles:logging error.description set value [{text:"Operation type \""},{text:""},{text:"\" requires a \"min\" field"}]
data modify storage reds_vehicles:logging error.description[1].text set from storage reds_vehicles:definitions working_handling.operation
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 81

function reds_vehicles:define/logging/log_auto_fill_name
