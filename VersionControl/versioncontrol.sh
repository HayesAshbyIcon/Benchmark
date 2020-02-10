#A future project to better create a version control for our devices
#getprop does not require root

#If Device is connected and USB Debugging Enabled
if adb shell echo "Starting Test"; 
    then

    #Mongo Stuff
    collection='asdfasdf'
    #collection=$(curl http://127.0.0.1:8081/target)
    server='localhost:27017'
    db='test'

    #Grab Device info
        #SerialNumber
            serial=$(adb shell getprop ro.serialno)
        #Model Number
            model=$(adb shell getprop ro.product.model)
        #Build Version
            build=$(adb shell getprop ro.build.display.id)
        #Android Version
            android=$(adb shell getprop ro.build.version.release)
        #Chipset
            chipset=$(adb shell getprop ro.board.platform)
        
        #Not compatible with non mediatek?
        #>>>>
        #Chipset Hardware Version
            chipsethardware=$(adb shell getprop ro.mediatek.chip_ver)
        #Chipset Release Version
            chipsetrelease=$(adb shell getprop ro.mediatek.version.release)
        #>>>>

        #Screen Size
            adb shell wm size | cut -d " " -f 3 > temp.txt
            xres=$(cut -d "x" -f 1 temp.txt)
            yres=$(cut -d "x" -f 2 temp.txt)
            rm temp.txt
            xdpi=$(adb shell wm density | cut -d " " -f 3)
            ydpi=$(adb shell wm density | cut -d " " -f 3)
            approxscreensize=$(bc <<< "scale=2 ; sqrt((($xres / $xdpi)*($xres / $xdpi)) + (($yres / $ydpi)*($yres / $ydpi)))")

    #add all device details and the results of the tests that were ran
    testresults=$1
    jsonobject='{"Serial":"'"$serial"'","Model":"'"$model"'","Build":"'"$build"'","Android":"'"$android"'","Chipset":"'"$chipset"'","ChipsetHardwareVersion":"'"$chipsethardware"'","ChipsetReleaseVersion":"'"$chipsetrelease"'","ApproxScreenSize":"'"$approxscreensize"'","TestResults":"'"$testresults"'"}'


    #Import Device.json to our DB
    printf $jsonobject > device.json
    mongoimport --host $server --db $db --collection $collection  --file device.json



else
    #Couldn't find device
    echo "Couldn't find device"
fi       



       
 #OUR CODE STUFF
    #THIS UPDATES SO THIS KINDA BOTHERS ME
    #Wolf Version
        #echo "Wolf:" >> ReportFile.txt
        #adb shell dumpsys package com.ifit.standalone | grep version >> ReportFile.txt
    #Eru Version
        #echo "Eru:" >> ReportFile.txt
        #adb shell dumpsys package com.ifit.eru | grep version >> ReportFile.txt
    #Wolf Launcher Version 
        #echo "Launcher:" >> ReportFile.txt
        #adb shell dumpsys package com.ifit.launcher | grep version >> ReportFile.txt
    #BrainBoard Version?
    
    #WebViewer Version?