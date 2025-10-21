# Increases the target score by the given amount

$execute store result score vehicle.input vehicle.local run data get storage reds_vehicles:handling input $(precision)
$scoreboard players operation @s $(variable) += vehicle.input vehicle.local

#$tellraw @a [{selector: "@s"}, {text: ": "}, {score: {name: "@s", objective: "$(variable)"}}, {text: "($(variable)), "}, {nbt: "input", storage: "reds_vehicles:handling"}]
