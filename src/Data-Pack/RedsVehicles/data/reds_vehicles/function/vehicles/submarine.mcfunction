# Declare the submarine vehicle by appending to reds_vehicles:definitions vehicles
data modify storage reds_vehicles:definitions vehicles append value \
{\
name: submarine,\
handling: [\
    {\
        input: "click.left",\
        operation: "set",\
        variable: "vehicle.event.horn"\
    },\
    {\
        input: "directed.x",\
        operation: "increase",\
        scale: {\
            source: "score",\
            name: "vehicle.thrust",\
            score_scale: 0.01\
        },\
        variable: "vehicle.dvel.x",\
        precision: 1000\
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
        precision: 1000\
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
        precision: 1000\
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
    }\
],\
physics: [\
    {\
        type: "buoyant",\
        environment: "water",\
        value: 1.0\
    }\
],\
bonuses: [\
    {\
        environment: "underwater",\
        type: "effect",\
        value: "minecraft:water_breathing"\
    },\
    {\
        environment: "underwater",\
        type: "effect",\
        value: "minecraft:night_vision"\
    }\
],\
parts: [\
    {\
        scale: [3.5f, 3.5f, 3.5f],\
        translation: [0.0f, 1.5f, -0.4f],\
        item: "minecraft:glass",\
        model: 1414716,name: display\
    }\
],\
default_scores: [\
    {\
        name: "vehicle.thrust",\
        value: 100\
    }\
],\
seat: {\
    width: 3.0f,\
    height: 2.0f\
},\
ground_offset: 0.7f,\
min_version: 1\
}
