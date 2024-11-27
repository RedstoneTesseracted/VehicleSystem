# Declare the orb vehicle by appending to reds_vehicles:definitions vehicles
data modify storage reds_vehicles:definitions vehicles append value \
{\
name: "helicopter",\
author: "Redstone⁴",\
collection: "builtin",\
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
    },\
    {\
        input: "click.left",\
        operation: "set",\
        variable: "vehicle.button.toggle_engine",\
    },\
    {\
        input: "rotation.yaw",\
        operation: "set",\
        variable: "vehicle.rot.yaw",\
        predicates: [\
            "reds_vehicles:state/engine_on",\
            "reds_vehicles:environment/mid_air"\
        ]\
    }\
],\
physics: [\
    {\
        type: "buoyant",\
        value: 1.0f,\
        predicates: [\
            "reds_vehicles:state/engine_on",\
            "reds_vehicles:environment/in_air",\
        ]\
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
        groups: ["display"],\
        custom_model_data: 1414720,\
        name: body\
    },\
    {\
        scale: [4.0f, 4.0f, 4.0f],\
        translation: [0.0f, 1.75f, -1.125f],\
        item: "minecraft:glass",\
        groups: ["display"],\
        custom_model_data: 1414721,\
        name: blade\
    }\
],\
default_scores: [\
    {\
        name: "vehicle.engine",\
        value: 0\
    },\
    {\
        name: "vehicle.button.toggle_engine",\
        value: 0\
    },\
    {\
        name: "vehicle.button.toggle_engine",\
        value: 0\
    }\
],\
events: [\
    {\
        predicates: [\
            "reds_vehicles:state/engine_on"\
        ],\
        actions: [\
            {\
              action: "playsound",\
              arguments: {\
                sound: "reds_vehicles:vehicle.biplane.engine_hum"\
              }\
            },\
            {\
              action: "set_rotation_axis_angle",\
              arguments: {\
                source: "vehicle.spin.time",\
                scale: 0.5f,\
                name: "blade",\
                transform: "left_rotation",\
                axis: [0.0f, 1.0f, 0.0f]\
              }\
            },\
            {\
              action: "add_score",\
              arguments: {\
                name: "vehicle.spin.time",\
                value: 1\
              }\
            }\
        ]\
    },\
    {\
        trigger: "vehicle.button.toggle_engine",\
        predicates: [\
            "reds_vehicles:state/engine_on"\
        ],\
        actions: [\
            {\
              action: "set_score",\
              arguments: {\
                name: "vehicle.engine",\
                value: 0\
              }\
            },\
            {\
              action: "set_score",\
              arguments: {\
                name: "vehicle.button.toggle_engine",\
                value: 0\
              }\
            },\
            {\
              action: "set_model",\
              arguments: {\
                name: "display",\
                value: 1414718\
              }\
            },\
            {\
              action: "playsound",\
              arguments: {\
                sound: "reds_vehicles:vehicle.biplane.engine_off"\
              }\
            }\
        ]\
    },\
    {\
        trigger: "vehicle.button.toggle_engine",\
        predicates: [\
            "reds_vehicles:state/engine_off"\
        ],\
        actions: [\
            {\
              action: "set_score",\
              arguments: {\
                name: "vehicle.engine",\
                value: 1\
              }\
            },\
            {\
              action: "set_score",\
              arguments: {\
                name: "vehicle.button.toggle_engine",\
                value: 0\
              }\
            },\
            {\
              action: "set_model",\
              arguments: {\
                name: "display",\
                value: 1414717\
              }\
            },\
            {\
              action: "playsound",\
              arguments: {\
                sound: "reds_vehicles:vehicle.biplane.engine_on"\
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
                group: "display",\
                transform: "yaw",\
                property: "angle"\
              }\
            },\
            {\
              action: "modify_transform",\
              arguments: {\
                source: "vehicle.rot.pitch",\
                group: "display",\
                transform: "pitch",\
                property: "angle"\
              }\
            }\
        ]\
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
