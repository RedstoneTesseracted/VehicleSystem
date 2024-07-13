# Declare the orb vehicle by appending to reds_vehicles:definitions vehicles
# {
#   name: "orb",
#   handling: [
#     {
#       input: "directed.x",
#       operation: "increase",
#       scale: {
#         source: "score",
#         name: "vehicle.thrust"
#       },
#       variable: "vehicle.vel.x"
#     },
#     {
#       input: "directed.y",
#       operation: "increase",
#       scale: {
#         source: "score",
#         name: "vehicle.thrust"
#       },
#       variable: "vehicle.vel.y"
#     },
#     {
#       input: "directed.z",
#       operation: "increase",
#       scale: {
#         source: "score",
#         name: "vehicle.thrust"
#       },
#       variable: "vehicle.vel.z"
#     }
#   ],
#   physics: [
#     {
#       type: "gravity",
#       value: 0.0
#     }
#   ],
#   parts: [
#     {
#       scale: [4.0f, 4.0f, 4.0f],
#       item: "minecraft:glass",
#       model: 0,
#       name: "display"
#     }
#   ],
#   seat: {
#     width: 4.0f,
#     height: 2.0f
#   },
#   ground_offset: 0.05f,
#   step_height: 0.6f,
#   min_version: 1b
# }

data modify storage reds_vehicles:definitions vehicles append value {name: "orb", handling:[{input: "directed.x", operation: "increase", scale: {source: "score", name: "vehicle.thrust"}, variable: "vehicle.vel.x"}, {input: "directed.y", operation: "increase", scale: {source: "score", name: "vehicle.thrust"}, variable: "vehicle.vel.y"}, {input: "directed.z", operation: "increase", scale: {source: "score", name: "vehicle.thrust"}, variable: "vehicle.vel.z"}], physics: [{type: "gravity", value: 0.0f}], parts: [{scale: [4.0f, 4.0f, 4.0f], item: "minecraft:glass", model: 0, name: "display"}], seat: {width: 4.0f, height: 2.0f}, ground_offset: 0.05f, step_height: 0.6f, min_version: 1}
