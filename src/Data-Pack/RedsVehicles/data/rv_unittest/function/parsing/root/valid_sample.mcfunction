# Declare a test orb vehicle
data modify storage reds_vehicles:definitions working_root set value \
{\
name: "orb",\
author: "Redstone⁴",\
collection: "test",\
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
        item: "minecraft:glass",\
        custom_model_data: 0,\
        name: "display.outer"\
    }\
],\
default_scores: [\
    {\
        name: vehicle.foobar,\
        value: 20\
    }\
],\
seat: {\
    width: 4.0f,\
    height: 2.0f\
},\
ground_offset: 0.05f,\
step_height: 0.6f,\
min_version: 1\
}
