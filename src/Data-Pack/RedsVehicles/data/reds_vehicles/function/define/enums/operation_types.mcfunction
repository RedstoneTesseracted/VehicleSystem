# This function redeclares a global table that maps operation type strings to numeric IDs
# IDs must start at 1, since 0 typically represents an error elsewhere
#
# This function is part of the #reds_vehicles:declare_enums function tag, and is called upon reload

data modify storage reds_vehicles:enums operation set value [{type: "increase", id: 1}, {type: "decrease", id: 2}, {type: "set", id: 3}, {type: "toggle", id: 4}]
