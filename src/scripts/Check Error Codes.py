"""
This script runs through all error reporting functions and checks
for any missing or duplicated error codes
"""
__author__ = "Redstone⁴"


# Import modules
import os
from os import path


# Global constants
datapack_path = path.join(path.pardir, 'Data-Pack', 'RedsVehicles')


def main():
    known_codes = dict()
    errors_occurred = False
    for working_path, subdirs, files in os.walk(datapack_path):
        # Filter paths to those under "function/define/[whatever]/report/"
        if 'function' not in working_path: continue
        if 'define' not in working_path: continue
        if 'report' not in working_path: continue

        # Check all .mcfunction files
        files = [i for i in files if i.endswith('.mcfunction')]
        for file in files:
            path_to_file = path.join(working_path, file)
            found_code = False
            with open(path_to_file, mode='r') as rf:
                while True:
                    # Search next line (or stop reading if
                    # we've reached the end)
                    pos_before = rf.tell()
                    line = rf.readline()
                    pos_after = rf.tell()
                    if pos_before == pos_after: break

                    # Look for the marker line.  The line
                    # immediately after should contain the
                    # error code
                    if line == "## ERROR CODE LINE ##\n":
                        found_code = True
                        code = rf.readline().strip().split()[-1]
                        if not code.isdigit():
                            errors_occurred = True
                            print(f"ERROR: Not a number \"{code}\" in", path_to_file)
                            break
                        code = int(code)

                        if code in known_codes:
                            errors_occurred = True
                            print(f"ERROR: Code \"{code}\" in {path_to_file} conflicts with {known_codes[code]}")
                            break
                        else:
                            known_codes[code] = path_to_file

            if not found_code:
                errors_occurred = True
                print("ERROR: Couldn't find error code for", path_to_file)

    # Summary
    #known_codes = [(i,j) for i, j in known_codes.items()]
    #known_codes.sort(key=lambda x: x[0])
    #known_codes = dict(known_codes)
    for i, j in known_codes.items():
        print(f'{j} - {i}')

    print(f"Error Code Range: {min(known_codes.keys())}-{max(known_codes.keys())}")
    
    if not errors_occurred:
        print("Finished without errors!")


if __name__ == "__main__":
    main()
