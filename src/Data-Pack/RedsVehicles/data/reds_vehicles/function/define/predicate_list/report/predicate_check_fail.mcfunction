data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/predicate_list/parse_loop"
data modify storage reds_vehicles:logging error.predicate_name set from storage reds_vehicles:definitions predicate_args.append
data modify storage reds_vehicles:logging error.description set value [{text:"Failed to validate existence of predicate \""},{nbt: "working_error.predicate_name",storage:"reds_vehicles:logging"},{text:"\" using function macros"}]
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 76

function reds_vehicles:define/logging/log_auto_fill_name
