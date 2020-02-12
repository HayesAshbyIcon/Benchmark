#This Script requires root access to be enabled on the device.

#Computer Setup
    #Install WireShark
    #Setup SpeedTest Server
        #Run this command "python ~/Benchmark/WifiSuite/wifi_speed_test_server.py"


if adb shell echo "Starting Wifi Test"; 
    then

    #Variables
    now=$(date)
    ipaddr=$(ipconfig getifaddr en0)
    #Tap Elements
    disablebutton='android:id/button2'
    startbutton='com.pzolee.android.localwifispeedtester:id/buttonStart'
    bothbutton='com.pzolee.android.localwifispeedtester:id/radioBoth'
    exportcsv='com.pzolee.android.localwifispeedtester:id/btnShareAsCsv'
    #nobutton='android:id/button2'
    #Installations

        #Installing SpeedTest
        adb install ./WifiSuite/localspeedtest.apk

        #Installing TcpDump
        #adb remount
        #adb push ./WifiSuite/tcpdump /system/xbin/tcpdump

    #Tests
    
        #SpeedTest
        adb shell monkey -p com.pzolee.android.localwifispeedtester -c android.intent.category.LAUNCHER 1
        sleep 30s
        /bin/bash ./TapTool/tap_id.sh $disablebutton
        sleep 30s
        adb shell input keyboard text $ipaddr
        /bin/bash ./TapTool/tap_id.sh $bothbutton
        sleep 10s
        for i in 1 2 3 4 5
        do 
            /bin/bash ./TapTool/tap_id.sh $startbutton
            sleep 10s
        done

        /bin/bash ./TapTool/tap_id.sh $exportcsv
        sleep 10s
        filename=$(adb shell ls /sdcard/wifispeedtest)
        adb pull /sdcard/wifispeedtest/"$filename"
        adb shell rm /sdcard/wifispeedtest/"$filename"

        #Counting Retransmissions
        #adb shell tcpdump -c 100
        #adb shell tcpdump -p -v -w /sdcard/$now.pcap

        #Latency
        #adb shell ping $ipaddr > ./Results/wifiresult.json

    #Uninstall
        #adb uninstall com.pzolee.android.localwifispeedtester

else
    #Couldn't find device
     echo "Couldn't find device"
fi



#PullResults

    #SpeedTest
    #adb pull /sdcard/WifiTestSuiteResults.txt
    #adb shell rm /sdcard/WifiTestSuiteResults.txt

    #TcpDump
    adb pull /sdcard/$now.pcap
    adb shell rm /sdcard/$now.pcap
        
#CheckResults
    #Filter Retransmissions with Tshark
    tshark -r $now.pcap -Y tcp.analysis.retransmission -W Retransmission.pcap

    grep -c '[TCP Retransmission]' Retransmission.pcap >> WifiTestSuiteResults.txt

    #run cts --module CtsNetTestcases

    #Fail


    #Pass

#ReportResults