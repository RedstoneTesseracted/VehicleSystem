# This function redeclares a global table that maps physics type strings to numeric IDs
# IDs must start at 1, since 0 typically represents an error elsewhere
#
# This function is part of the #reds_vehicles:declare_enums function tag, and is called upon reload

data modify storage reds_vehicles:enums physics set value [\
{type: "gravity", id: 1},\
{type: "buoyant", id: 2},\
{type: "simple_lift", id: 3},\
{type: "planar_drag", id: 4},\
{type: "applied", id: 5}\
]
