data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/action/type/modify_transform"
data modify storage reds_vehicles:logging error.description set value {text:"An unknown error caused the function macro \"reds_vehicles:define/action/__generate_name_selector\" to fail to compile.  Either the given entity name is invalid or there is a bug in the pack.  See Extra for the \"name\" passed to the macro."}
data modify storage reds_vehicles:logging error.extra set from storage reds_vehicles:definitions working_action.arguments.name

function reds_vehicles:define/logging/log_auto_fill_name
