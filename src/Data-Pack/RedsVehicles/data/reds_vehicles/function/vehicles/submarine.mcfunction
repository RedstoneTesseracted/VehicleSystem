# Declare the submarine vehicle by appending to reds_vehicles:definitions vehicles
# {
#   name: submarine,
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
#       type: "buoyant",
#       environment: "water",
#       value: 1.0
#     }
#   ],
#   bonuses: [
#     {
#       environment: "underwater",
#       type: "effect",
#       value: "minecraft:water_breathing"
#     },
#     {
#       environment: "underwater",
#       type: "effect",
#       value: "minecraft:night_vision"
#     }
#   ],
#   parts: [
#     {
#       scale: [3.5f, 3.5f, 3.5f],
#       translation: [0.0f, 1.5f, -0.4f],
#       item: "minecraft:glass",
#       model: 1414716,
#       name: display
#     }
#   ],
#   seat: {
#     width: 3.0f,
#     height: 2.0f
#   },
#   ground_offset: 0.7f
#   min_version: 1
# }


data modify storage reds_vehicles:definitions vehicles append value {name: submarine,handling: [{input: "directed.x",operation: "increase",scale: {source: "score",name: "vehicle.thrust"},variable: "vehicle.vel.x"},{input: "directed.y",operation: "increase",scale: {source: "score",name: "vehicle.thrust"},variable: "vehicle.vel.y"},{input: "directed.z",operation: "increase",scale: {source: "score",name: "vehicle.thrust"},variable: "vehicle.vel.z"}],physics: [{type: "buoyant", environment: "water",value: 1.0}],bonuses: [{environment: "underwater",type: "effect",value: "minecraft:water_breathing"},{environment: "underwater",type: "effect",value: "minecraft:night_vision"}],parts: [{scale: [3.5f, 3.5f, 3.5f],translation: [0.0f, 1.5f, -0.4f],item: "minecraft:glass",model: 1414716,name: display}],seat: {width: 3.0f,height: 2.0f},ground_offset: 0.7f, min_version: 1}
