#NEEDS ROOT

if adb shell echo "Starting CPU Test"; 
    then
    pathing=$(pwd)
    #Elements that need to be tapped
    acceptbutton='android:id/button1'
    runbenchmarkbutton='com.primatelabs.geekbench:id/runCpuBenchmarks'



    adb install ./CpuSuite/GeekBench4.apk
    adb shell monkey -p com.primatelabs.geekbench -c android.intent.category.LAUNCHER 1
    sleep 30s
    /bin/bash ./TapTool/tap_id.sh $acceptbutton
    /bin/bash ./TapTool/tap_id.sh $runbenchmarkbutton
    #Let Test Run
    sleep 900s

    #Grab Result
    filename=$(adb shell ls /data/data/com.primatelabs.geekbench/files)
    adb pull /data/data/com.primatelabs.geekbench/files/"$filename"
    mv "$filename" ./Results/cpuresult.json

    adb uninstall com.primatelabs.geekbench

else
    #Couldn't find device
     echo "Couldn't find device"
fi