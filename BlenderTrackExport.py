# script that exports tracking data from Blender into *.csv files
# to use it, you have to create tracks in Blender in the "Motion Tracking " workspace

#FILE NAMES ORIGINATE FROM TRACK NAMING IN BLENDER!
import bpy
import os

# index of movieclip the track marks are on. default = 0
movieclip = 0

# frame range for the export
frameBegin = 1
frameEnd = 80


# main export script
tracks = bpy.data.movieclips[movieclip].tracking.tracks

for tr in tracks:
    fileName = tr.name + ".csv"

    with open(fileName,'w') as f:

        for frame in range(frameBegin,frameEnd+1):
            loc = tr.markers[frame].co
            f.write('{0}, {1}\n'.format(loc[0], loc[1]))

print("track export finished")
