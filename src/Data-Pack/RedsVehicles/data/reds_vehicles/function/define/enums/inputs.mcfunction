# This function redeclares a global table that maps input type strings to numeric IDs and their input group
# IDs must start at 1, since 0 typically represents an error elsewhere
#
# This function is part of the #reds_vehicles:declare_enums function tag, and is called upon reload

data modify storage reds_vehicles:enums inputs set value [\
{type: "look.x", id: 1, group: "look"}, \
{type: "look.y", id: 2, group: "look"}, \
{type: "look.z", id: 3, group: "look"}, \
{type: "look_xz.x", id: 1, group: "look_xz"}, \
{type: "look_xz.z", id: 3, group: "look_xz"}, \
{type: "motion.x", id: 4, group: "motion"}, \
{type: "motion.z", id: 5, group: "motion"}, \
{type: "directed.x", id: 6, group: "directed"}, \
{type: "directed.y", id: 7, group: "directed"}, \
{type: "directed.z", id: 8, group: "directed"}, \
{type: "rotation.pitch", id: 9, group: "rotation"}, \
{type: "rotation.yaw", id: 10, group: "rotation"}, \
{type: "rotation_diff.pitch", id: 11, group: "rotation_diff"}, \
{type: "rotation_diff.yaw", id: 12, group: "rotation_diff"}, \
{type: "click.right", id: 13, group: "click"}, \
{type: "click.left", id: 14, group: "click"}, \
{type: "input.forward", id: 15, group: "input"}, \
{type: "input.side", id: 16, group: "input"}]
