data modify storage reds_vehicles:logging error.vehicle set value '"<invalid>"'
data modify storage reds_vehicles:logging error.source set value "reds_vehicles:define/name/parse"
data modify storage reds_vehicles:logging error.description set value [{text:"Expected a string for vehicle \"name\" field.  See Extra for provided name."}]
data modify storage reds_vehicles:logging error.extra set from storage reds_vehicles:definitions working_root.name
## ERROR CODE LINE ##
data modify storage reds_vehicles:logging error.code set value 59

function reds_vehicles:define/logging/log_error
