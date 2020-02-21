    #Set the First Argument of the script to the id to tap
    id=$1

    #To find future IDs go to the screen in which the id is present then use the commands:
    #"adb shell uiautomator dump"
    #"adb shell /sdcard/window_dump.xml" 
    #And locate via the Text on the button or other means

    #Big Complicated thing Thats doing a lot https://stackoverflow.com/questions/18924968/using-adb-to-access-a-particular-ui-control-on-the-screen
    if adb shell echo "Tapping element: " $id 
    then 

        adb shell uiautomator dump
        adb pull /sdcard/window_dump.xml
        coords=$(xpath window_dump.xml //node[@resource-id="'$id'"]/@bounds)

        
        #We are creating extra variables here but its if for future development we would like not to tap the top most left pixel
        leftuppercoords=$(echo "$coords" | cut -d "[" -f 2 | cut -d "]" -f 1)
        #X and Y
        leftupperx=$(echo "$leftuppercoords" | cut -d "," -f 1)
        leftuppery=$(echo "$leftuppercoords" | cut -d "," -f 2)

        bottomrightcoords=$(echo "$coords" | cut -d "[" -f 3 | cut -d "]" -f 1)
        #X and Y 
        bottomrightx=$(echo "$bottomrightcoords" | cut -d "," -f 1)
        bottomrighty=$(echo "$bottomrightcoords" | cut -d "," -f 2)

        adb shell input tap $leftupperx $leftuppery

    else
        #Couldn't find Id
         echo "Couldn't find Id"
    fi