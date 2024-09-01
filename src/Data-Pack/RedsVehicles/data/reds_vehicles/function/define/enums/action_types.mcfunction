# This function redeclares a global table that maps event action type strings to numeric IDs
# IDs must start at 1, since 0 is the easiest way to detect errors
#
# This function is part of the #reds_vehicles:declare_enums function tag, and is called upon reload

data modify storage reds_vehicles:enums actions set value [\
{type: "playsound", id: 1},\
{type: "particle", id: 2},\
{type: "set_model", id: 3},\
{type: "set_score", id: 4},\
{type: "projectile", id: 5},\
{type: "relative_particle", id: 6}\
]
