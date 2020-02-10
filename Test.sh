if adb shell echo "Starting Test"; 
    then

        filename=$(adb shell ls /data/data/com.primatelabs.geekbench/files)
        adb pull /data/data/com.primatelabs.geekbench/files/"$filename"
        mv "$filename" cpuresult.json
else
    #Couldn't find device
     echo "Couldn't find device"
fi