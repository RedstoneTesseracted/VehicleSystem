"""
A simple script that generates a bunch of overlay folders containing a
function that's used to get the current datapack version number
"""
# Import modules
import os
from os import path
import json


# Declare global constants
FIRST_OVERLAY_VERSION = 16
pack_root = path.join(path.pardir, 'Data-Pack', 'RedsVehicles')

# Obtain current pack.mcmeta JSON and extract compatible versions
with open(path.join(pack_root, 'pack.mcmeta'), mode='r', encoding='utf-8') as rf:
    pack = json.load(rf)

min_version = max(pack['pack']['supported_formats']['min_inclusive'], FIRST_OVERLAY_VERSION)
max_version = pack['pack']['supported_formats']['max_inclusive']

# Fill in missing overlay directories in the "overlays" tag
existing_versions = list(map(lambda x: x['formats'], pack["overlays"]["entries"]))
existing_directories = list(map(lambda x: x['directory'], pack["overlays"]["entries"]))

for version in range(min_version, max_version+1):
    # Pass if a overlay & directory already exist for this version
    if version in existing_versions and str(version) in existing_directories:
        continue

    # Otherwise, add an entry for this version
    pack['overlays']['entries'].append({"formats": version, "directory": str(version)})

# Save updated pack.mcmeta to file
with open(path.join(pack_root, 'pack.mcmeta'), mode='w', encoding='utf-8') as wf:
    json.dump(pack, wf, indent=3, ensure_ascii=False)


# Generate all overlays if they don't already exist
for version in range(min_version, max_version+1):
    function = 'function' if version >= 48 else 'functions'
    functions_path = path.join(pack_root, str(version), 'data', 'reds_vehicles', function)

    # Make directory structure
    os.makedirs(functions_path, exist_ok=True)

    # Add mcfunction file
    with open(path.join(functions_path, 'datapack_format.mcfunction'), mode='w') as wf:
        wf.write(f'return {version}\n')
