# This function redeclares a global table that maps environment type strings to numeric IDs
# IDs must start at 1, since 0 typically represents an error elsewhere
#
# This function is part of the #reds_vehicles:declare_enums function tag, and is called upon reload

data modify storage reds_vehicles:enums environment set value [{type: "water", id: 1}, {type: "lava", id: 2}, {type: "air", id: 3}]
