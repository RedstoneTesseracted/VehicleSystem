# Declare the submarine vehicle by appending to reds_vehicles:definitions vehicles
data modify storage reds_vehicles:definitions vehicles append value \
{\
name: biplane,\
handling: [\
    {\
        input: "input.forward",\
        operation: "increase",\
        scale: {\
            source: "constant",\
            value: 0.01d\
        },\
        variable: "vehicle.accel.forward",\
    },\
    {\
        input: "click.left",\
        operation: "set",\
        variable: "vehicle.button.kill_throttle",\
    },\
    {\
        input: "rotation_diff.pitch",\
        operation: "increase",\
        variable: "vehicle.rot.pitch"\
    },\
    {\
        input: "rotation_diff.yaw",\
        operation: "increase",\
        variable: "vehicle.rot.yaw"\
    },\
    {\
        input: "rotation_diff.yaw",\
        operation: "set",\
        scale: {\
            source: "constant",\
            value: 4.0d\
        },\
        variable: "vehicle.rot.roll"\
    }\
],\
physics: [\
    {\
        type: "applied",\
        predicates: [\
            "reds_vehicles:has_passenger",\
            "reds_vehicles:environment/mid_air"\
        ],\
        value: 8.0f\
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
            "reds_vehicles:environment/on_dry_land",\
            "reds_vehicles:is_moving"\
        ],\
        value: 0.07f\
    },\
    {\
        type: "elytra_glide",\
        predicates: [\
            "reds_vehicles:environment/in_air",\
            "reds_vehicles:is_moving"\
        ],\
    },\
    {\
        type: "side_linear_drag",\
        predicates: [\
            "reds_vehicles:environment/on_dry_land",\
            "reds_vehicles:is_moving"\
        ],\
        value: -0.2f\
    }\
],\
parts: [\
    {\
        scale: [3.0f, 3.0f, 3.0f],\
        translation: [0.0f, 1.25f, -0.4f],\
        item: "minecraft:glass",\
        custom_model_data: 1414716,\
        name: display\
    }\
],\
default_scores: [],\
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
        trigger: "vehicle.button.kill_throttle",\
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
    width: 3.0f,\
    height: 1.5f\
},\
item: {\
    name: "Biplane",\
    model: ""\
},\
ground_offset: 0.7f,\
step_height: 1.0f,\
min_version: 1\
}

