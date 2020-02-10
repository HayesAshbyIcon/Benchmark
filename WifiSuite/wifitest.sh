#This Script requires root access to be enabled on the device.
#To get root access go to the calculator app and type in ".xππx=" then type "rootacess" and hit enter
#Enable usb debugging via the settings
#Currently working for Mac Only and was written for Argon Devices.

#Computer Setup
    #Install WireShark
    #Install ADB
    #Setup SpeedTest Server
        #Run this command "cd ~/Sites/WifiTestingSuite/OoklaServer" then "./ooklaserver.sh start"


if adb shell echo "Starting Wifi Test"; 
    then

    #Variables
    now=$(date)
    ipaddr=$(ipconfig getifaddr en0)

    #Installations

        #Installing OoklaApp
        adb install ~/Benchmark/WifiSuite/ooklaspeedtest.apk

        #Installing TcpDump
        adb remount
        adb push ./tcpdump /system/xbin/tcpdump

    #Tests
    
        #OoklaSpeedTest
        adb shell monkey -p com.primatelabs.geekbench -c android.intent.category.LAUNCHER 1

        #Counting Retransmissions
        #adb shell tcpdump -c 100
        adb shell tcpdump -p -v -w /sdcard/$now.pcap

        #Latency
        adb shell ping $ipaddr > /sdcard/WifiTestSuiteResults.txt


else
    #Couldn't find device
     echo "Couldn't find device"
fi

#ShutDown Wolf and Eru

    adb shell am force-stop com.ifit.eru
    adb shell am force-stop com.ifit.standalone
   

#PullResults

    #SpeedTest
    #adb pull /sdcard/WifiTestSuiteResults.txt
    #adb shell rm /sdcard/WifiTestSuiteResults.txt

    #TcpDump
    adb pull /sdcard/$now.pcap
    #adb shell rm /sdcard/$now.pcap
        
#CheckResults
    #Filter Retransmissions with Tshark
    tshark -r $now.pcap -Y tcp.analysis.retransmission -W Retransmission.pcap

    grep -c '[TCP Retransmission]' Retransmission.pcap >> WifiTestSuiteResults.txt

    #run cts --module CtsNetTestcases

    #Fail


    #Pass

#ReportResults