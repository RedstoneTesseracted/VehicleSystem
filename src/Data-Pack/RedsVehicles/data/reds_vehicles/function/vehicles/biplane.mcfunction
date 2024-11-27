# Declare the submarine vehicle by appending to reds_vehicles:definitions vehicles
data modify storage reds_vehicles:definitions vehicles append value \
{\
name: "biplane",\
author: "Redstone⁴",\
handling: [\
    {\
        input: "input.forward",\
        operation: "clamped_increase",\
        min: 0,\
        max: 1000,\
        scale: {\
            source: "constant",\
            value: 0.01d\
        },\
        variable: "vehicle.accel.forward",\
        predicates: [\
            "reds_vehicles:state/engine_on"\
        ]\
    },\
    {\
        input: "click.left",\
        operation: "set",\
        variable: "vehicle.button.toggle_engine",\
    },\
    {\
        input: "rotation_diff.pitch",\
        operation: "increase",\
        scale: {\
            source: "constant",\
            value: 1.0d\
        },\
        predicates: [\
            "reds_vehicles:environment/mid_air"\
        ],\
        variable: "vehicle.rot.pitch"\
    },\
    {\
        input: "rotation_diff.yaw",\
        operation: "increase",\
        scale: {\
            source: "constant",\
            value: 1.0d\
        },\
        variable: "vehicle.rot.yaw",\
        predicates: [\
            "reds_vehicles:state/engine_on"\
        ]\
    },\
    {\
        input: "heading_diff.yaw",\
        operation: "set",\
        scale: {\
            source: "constant",\
            value: 1.1d\
        },\
        predicates: [\
            "reds_vehicles:environment/mid_air"\
        ],\
        variable: "vehicle.rot.roll"\
    }\
],\
physics: [\
    {\
        type: "applied",\
        predicates: [\
            "reds_vehicles:environment/mid_air"\
        ],\
        value: 1.1f,\
        reset: 0b\
    },\
    {\
        type: "applied",\
        predicates: [\
            "reds_vehicles:has_passenger",\
            "reds_vehicles:environment/on_dry_land"\
        ],\
        value: 2.0f,\
        reset: 0b\
    },\
    {\
        type: "simple_lift",\
        predicates: [\
            "reds_vehicles:has_horizontal_movement"\
        ],\
        value: 0.03f\
    },\
    {\
        type: "uniform_quadratic_drag",\
        predicates: [\
            "reds_vehicles:has_horizontal_movement"\
        ],\
        value: 0.05f\
    }\
],\
parts: [\
    {\
        scale: [3.0f, 3.0f, 3.0f],\
        translation: [0.0f, 0.91f, -0.4f],\
        item: "minecraft:glass",\
        custom_model_data: 1414718,\
        name: display\
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
    }\
],\
events: [\
    {\
        predicates: [\
            "reds_vehicles:environment/on_dry_land"\
        ],\
        actions: [\
            {\
              action: "set_score",\
              arguments: {\
                name: "vehicle.rot.pitch",\
                value: 0\
              }\
            },\
            {\
              action: "set_score",\
              arguments: {\
                name: "vehicle.rot.roll",\
                value: 0\
              }\
            }\
        ]\
    },\
    {\
        trigger: "vehicle.accel.forward",\
        predicates: [\
            "reds_vehicles:state/engine_off"\
        ],\
        actions: [\
            {\
              action: "set_score",\
              arguments: {\
                name: "vehicle.accel.forward",\
                value: 0\
              }\
            }\
        ]\
    },\
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
              action: "message",\
              arguments: {\
                text: [\
                    {text: "Throttle: "},\
                    {score: {name: "@s", objective: "vehicle.accel.forward"}}\
                ]\
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
            },\
            {\
              action: "modify_transform",\
              arguments: {\
                source: "vehicle.rot.pitch",\
                name: "display",\
                transform: "pitch",\
                property: "angle"\
              }\
            },\
            {\
              action: "set_rotation_axis_angle",\
              arguments: {\
                source: "vehicle.rot.roll",\
                scale: 0.017453292519943295f,\
                name: "display",\
                transform: "left_rotation",\
                axis: [0.0f, 0.0f, 1.0f]\
              }\
            }\
        ]\
    }\
],\
seat: {\
    width: 4.0f,\
    height: 1.6f\
},\
item: {\
    name: "Biplane",\
    model: ""\
},\
ground_offset: 1.7f,\
step_height: 1.0f,\
min_version: 1\
}

