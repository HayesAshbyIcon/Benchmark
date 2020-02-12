    #Set the First Argument of the script to the id to tap
    id=$1

    echo "Tapping element: " $id
    #To find future IDs go to the screen in which the id is present then use the commands:
    #"adb shell uiautomator dump"
    #"adb shell cat /sdcard/window_dump.xml" 
    #And locate via the Text on the button or other means and grab the @id


    #Big Complicated thing Thats doing a lot https://stackoverflow.com/questions/18924968/using-adb-to-access-a-particular-ui-control-on-the-screen
    if adb exec-out uiautomator dump /dev/tty | sed 's/UI hierchary dumped to: \/dev\/tty//' | sed 'N;s/Usage: don'\''t use this (cf dexopt usage).\n//' | xpath 'string(//node[@resource-id="'"$id"'"]/@bounds)' 2> /dev/null; 
    then 

        coords=$(adb exec-out uiautomator dump /dev/tty | sed 's/UI hierchary dumped to: \/dev\/tty//' | sed 'N;s/Usage: don'\''t use this (cf dexopt usage).\n//' | xpath 'string(//node[@resource-id="'"$id"'"]/@bounds)' 2> /dev/null)

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