# This function declares a list of all unit test functions to be run

data modify storage reds_vehicles:unittest tests set value [\
"rv_unittest:general/check_valid_version",\
"rv_unittest:parsing/action/test_arguments_missing",\
"rv_unittest:parsing/action/test_garbled_action",\
"rv_unittest:parsing/action/test_unknown_action",\
"rv_unittest:parsing/action/effect_passenger/test_invalid_input",\
"rv_unittest:parsing/action/effect_passenger/test_valid_input",\
"rv_unittest:parsing/action/modify_transform/test_invalid_input",\
"rv_unittest:parsing/action/modify_transform/test_valid_input",\
"rv_unittest:parsing/action/particle/test_invalid_input",\
"rv_unittest:parsing/action/particle/test_valid_input",\
"rv_unittest:parsing/action/playsound/test_invalid_input",\
"rv_unittest:parsing/action/playsound/test_valid_input",\
"rv_unittest:parsing/action/projectile/test_invalid_input",\
"rv_unittest:parsing/action/projectile/test_valid_input",\
"rv_unittest:parsing/action/relative_particle/test_invalid_input",\
"rv_unittest:parsing/action/relative_particle/test_valid_input",\
"rv_unittest:parsing/action/set_custom_model_data/test_invalid_input",\
"rv_unittest:parsing/action/set_custom_model_data/test_valid_input",\
"rv_unittest:parsing/action/set_rotation_axis_angle/test_invalid_input",\
"rv_unittest:parsing/action/set_rotation_axis_angle/test_valid_input",\
"rv_unittest:parsing/action/set_score/test_invalid_input",\
"rv_unittest:parsing/action/set_score/test_valid_input",\
"rv_unittest:parsing/action/set_transform/test_invalid_input",\
"rv_unittest:parsing/action/set_transform/test_valid_input",\
"rv_unittest:parsing/action_list/test_multiple_actions"\
]

# Get global count of unit tests
execute store result score vehicle.unittest.total_tests vehicle.unittest.global run data get storage reds_vehicles:unittest tests
