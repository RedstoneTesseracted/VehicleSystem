# Declare the orb vehicle by appending to reds_vehicles:definitions vehicles
data modify storage reds_vehicles:definitions vehicles append value \
{\
name: "helicopter",\
author: "Redstone⁴",\
handling:[\
    {\
        input: "directed.x",\
        operation: "increase",\
        scale: {\
            source: "constant",\
            value: 0.05\
        },\
        variable: "vehicle.dvel.x",\
        precision: 1000\
    },\
    {\
        input: "directed.y",\
        operation: "increase",\
        scale: {\
            source: "constant",\
            value: 0.025\
        },\
        variable: "vehicle.dvel.y",\
        precision: 1000\
    },\
    {\
        input: "directed.z",\
        operation: "increase",\
        scale: {\
            source: "constant",\
            value: 0.05\
        },\
        variable: "vehicle.dvel.z",\
        precision: 1000\
    }\
],\
physics: [\
    {\
        type: "gravity",\
        value: 0.0f\
    },\
    {\
        type: "applied",\
        predicates: [\
            "reds_vehicles:has_passenger"\
        ],\
        value: 1.0f\
    }\
],\
parts: [\
    {\
        scale: [4.0f, 4.0f, 4.0f],\
        translation: [0.0f, 0.0f, 0.0f],\
        item: "minecraft:glass",\
        custom_model_data: 1414720,\
        name: body\
    },\
    {\
        scale: [4.0f, 4.0f, 4.0f],\
        translation: [0.0f, 1.75f, -1.625f],\
        item: "minecraft:glass",\
        custom_model_data: 1414721,\
        name: blade\
    }\
],\
seat: {\
    width: 2.0f,\
    height: 2.3f\
},\
item: {\
    name: "Helicopter",\
    model: ""\
},\
ground_offset: 1.0f,\
step_height: 0.6f,\
min_version: 1\
}
