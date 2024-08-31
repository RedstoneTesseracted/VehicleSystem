# This function redeclares a global table that maps scale source type strings to numeric IDs
# IDs must start at 1, since 0 is the easiest way to detect errors
#
# This function is part of the #reds_vehicles:declare_enums function tag, and is called upon reload

data modify storage reds_vehicles:enums scale_source set value [\
{type: "constant", id: 1},\
{type: "score", id: 2},\
{type: "none", id: 3}\
]
