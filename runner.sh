#This is the Runner for the Entire Project 
#It's goal is to Run the Tests specified then compile the testresult.json then have the versioncontrol.sh create a completed device.json to then be sent to the database
#

#ShutDown Wolf and Eru

    adb shell am force-stop com.ifit.eru
    adb shell am force-stop com.ifit.standalone

#Create a Results folder
    mkdir "Results"


if /bin/bash ./CpuSuite/cputest.sh; 
    then
    cpuresult=$(cat ./Results/cpuresult.json)
else
    #Couldn't find test
     echo "Couldn't find Cpu test"
fi

if /bin/bash ./WifiSuite/wifitest.sh; 
    then
    #implement wifitest
    #wifiresult=$(cat ./Results/wifiresult.json)
    wifiresult="{}"
else
    #Couldn't find test
     echo "Couldn't find Wifi test"
fi


echo '{"CpuTest":'$cpuresult',"WifiTest":'$wifiresult'}' > ./Results/testresult.json

/bin/bash ./VersionControl/versioncontrol.sh
