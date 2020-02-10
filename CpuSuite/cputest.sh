#NEEDS ROOT

if adb shell echo "Starting CPU Test"; 
    then

    #Elements that need to be tapped
    acceptbutton='android:id/button1'
    runbenchmarkbutton='com.primatelabs.geekbench:id/runCpuBenchmarks'



    adb install GeekBench4.apk
    adb shell monkey -p com.primatelabs.geekbench -c android.intent.category.LAUNCHER 1
    sleep 30s
    /bin/bash ~/Sites/Benchmark/TapTool/tap_id.sh $acceptbutton
    /bin/bash ~/Sites/Benchmark/TapTool/tap_id.sh $runbenchmarkbutton
    #Let Test Run
    sleep 900s

    #Grab Result
    filename=$(adb shell ls /data/data/com.primatelabs.geekbench/files)
    adb pull /data/data/com.primatelabs.geekbench/files/"$filename"
    mv "$filename" cpuresult.json

    adb uninstall com.primatelabs.geekbench

else
    #Couldn't find device
     echo "Couldn't find device"
fi