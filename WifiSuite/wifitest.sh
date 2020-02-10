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
    adb shell monkey -p com.primatelabs.geekbench -c android.intent.category.LAUNCHER 1

else
    #Couldn't find device
     echo "Couldn't find device"
fi

#Variables
    now=$(date)
    ipaddr=$(ipconfig getifaddr en0)

#ShutDown Wolf and Eru

    adb shell am force-stop com.ifit.eru
    adb shell am force-stop com.ifit.standalone

#Installations

    #Installing TcpDump
    adb remount
    adb push ./tcpdump /system/xbin/tcpdump
    
#Tests
    #Counting Retransmissions
    #adb shell tcpdump -c 100
    adb shell tcpdump -p -v -w /sdcard/$now.pcap

    #Latency
    adb shell ping $ipaddr > /sdcard/WifiTestSuiteResults.txt

    #SpeedTest
    ./data/data/com.termux/files/usr/bin/speedtest-cli >> WifiTestSuiteResults.txt
    #adb uninstall com.termux
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