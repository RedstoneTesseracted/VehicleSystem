# Declare the submarine vehicle by appending to reds_vehicles:definitions vehicles
data modify storage reds_vehicles:definitions vehicles append value \
{\
name: "submarine",\
author: "Redstone⁴",\
collection: "builtin",\
handling: [\
    {\
        input: "directed.x",\
        operation: "increase",\
        scale: {\
            source: "score",\
            name: "vehicle.thrust",\
            score_scale: 0.01\
        },\
        variable: "vehicle.dvel.x",\
    },\
    {\
        input: "directed.y",\
        operation: "increase",\
        scale: {\
            source: "score",\
            name: "vehicle.thrust",\
            score_scale: 0.01\
        },\
        variable: "vehicle.dvel.y",\
    },\
    {\
        input: "directed.z",\
        operation: "increase",\
        scale: {\
            source: "score",\
            name: "vehicle.thrust",\
            score_scale: 0.01\
        },\
        variable: "vehicle.dvel.z",\
    },\
    {\
        input: "rotation.pitch",\
        operation: "set",\
        variable: "vehicle.rot.pitch",\
        precision: 10000\
    },\
    {\
        input: "rotation.yaw",\
        operation: "set",\
        variable: "vehicle.rot.yaw",\
        precision: 10000\
    },\
    {\
        input: "click.right",\
        operation: "set",\
        variable: "vehicle.event.honk",\
        precision: 1\
    }\
],\
physics: [\
    {\
        type: "buoyant",\
        predicates: [\
            "reds_vehicles:environment/in_water"\
        ],\
        value: 1.0\
    },\
    {\
        type: "applied",\
        predicates: [\
            "reds_vehicles:has_passenger",\
            "reds_vehicles:environment/in_water"\
        ],\
        value: 1.0\
    },\
    {\
        type: "applied",\
        predicates: [\
            "reds_vehicles:has_passenger"\
        ],\
        value: 0.1\
    },\
],\
parts: [\
    {\
        scale: [3.0f, 3.0f, 3.0f],\
        translation: [0.0f, 1.25f, -0.4f],\
        item: "minecraft:glass",\
        model: "reds_vehicles:vehicle/submarine",\
        name: display\
    }\
],\
default_scores: [\
    {\
        name: "vehicle.thrust",\
        value: 0.1d\
    }\
],\
events: [\
    {\
        predicates: [\
            "reds_vehicles:is_moving",\
            "reds_vehicles:has_passenger",\
            "reds_vehicles:environment/in_water"\
        ],\
        actions: [\
            {\
                action: "relative_particle",\
                arguments: {\
                    name: "minecraft:bubble",\
                    relative_to: "display",\
                    offset: [1.25f, 0.25f, -1.0f],\
                    delta: [0.1f, 0.1f, 0.1f],\
                    speed: 0.01,\
                    count: 2\
                }\
            },\
            {\
                action: "relative_particle",\
                arguments: {\
                    name: "minecraft:bubble",\
                    relative_to: "display",\
                    offset: [-1.25f, 0.25f, -1.0f],\
                    delta: [0.1f, 0.1f, 0.1f],\
                    speed: 0.01,\
                    count: 2\
                }\
            }\
        ]\
    },\
    {\
        predicates: [\
            "reds_vehicles:has_passenger",\
            "reds_vehicles:environment/in_water"\
        ],\
        actions: [\
            {\
                action: "effect_passenger",\
                arguments: {\
                    name: "minecraft:water_breathing",\
                    duration: 1,\
                    hide_particles: true\
                }\
            },\
            {\
                action: "effect_passenger",\
                arguments: {\
                    name: "minecraft:night_vision",\
                    duration: 1,\
                    hide_particles: true\
                }\
            }\
        ]\
    },\
    {\
        predicates: [\
            "reds_vehicles:has_passenger"\
        ],\
        actions: [\
            {\
              action: "modify_transform",\
              arguments: {\
                source: "vehicle.rot.yaw",\
                name: "display",\
                transform: "yaw",\
                property: "angle"\
              }\
            }\
        ]\
    }\
],\
seat: {\
    width: 3.0f,\
    height: 1.5f\
},\
item: {\
    name: "Submarine",\
    model: "reds_vehicles:vehicle/submarine"\
},\
ground_offset: 0.25f,\
min_version: 1\
}

