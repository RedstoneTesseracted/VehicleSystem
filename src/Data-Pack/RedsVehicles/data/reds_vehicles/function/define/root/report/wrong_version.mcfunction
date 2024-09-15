data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/root/parse"
data modify storage reds_vehicles:logging error.stored.required_version set from storage reds_vehicles:definitions working_root.min_version
execute store result storage reds_vehicles:logging error.stored.current_version int 1 run function reds_vehicles:version
data modify storage reds_vehicles:logging error.description set value [{text:"Vehicle requires a minimum datapack version of "},{nbt: "working_error.stored.required_version", storage: "reds_vehicles:logging"},{text:", but the loaded datapack's version is "},{nbt: "working_error.stored.current_version", storage: "reds_vehicles:logging"}]

function reds_vehicles:define/logging/log_auto_fill_name
