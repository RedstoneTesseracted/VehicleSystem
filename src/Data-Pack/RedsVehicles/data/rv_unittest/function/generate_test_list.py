"""
This script scans the unit test directories and generates a list of all 
runnable unit tests.  This list is then written as a function so it may
be used by the unit test suite
"""
__author__ = "Redstone⁴"

# Import modules
import os
from os import path


# Scan all directories to build up a list of unit tests
# Unit test's first line should be "#### UNIT TEST ####"
unit_tests = []
for working_path, subdirs, files in os.walk('.'):
    for file in files:
        path_to_file = path.join(working_path, file)
        
        # Check extension and verify it's a file
        if path.splitext(file)[-1] != '.mcfunction': continue
        if not path.isfile(path_to_file): continue

        # Check first line
        with open(path.join(working_path, file), mode='r') as rf:
            first_line = rf.readline()
        if not first_line.startswith("#### UNIT TEST ####"): continue

        # We found a unit test!
        function_name = 'rv_unittest:' + path_to_file.removeprefix(path.join('.', '')).replace(path.sep,'/').removesuffix('.mcfunction')
        print("Found:", function_name)
        unit_tests.append(function_name)


# Write file that schedules all unit tests
with open('declare_tests.mcfunction', mode='w') as wf:
    # Write header
    wf.write("# This function declares a list of all unit test functions to be run\n\n")

    # Write list
    wf.write("data modify storage reds_vehicles:unittest tests set value [\\\n")
    for test in unit_tests[:-1]:
        wf.write(f'"{test}",\\\n')
    wf.write(f'"{unit_tests[-1]}"\\\n')
    wf.write("]\n\n")

    # Set total unit test score
    wf.write("# Get global count of unit tests\n")
    wf.write("execute store result score vehicle.unittest.total_tests vehicle.unittest.global run data get storage reds_vehicles:unittest tests\n")
