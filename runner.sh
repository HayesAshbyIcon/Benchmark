#TODO BETTER FILE PATHING


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
else
    #Couldn't find test
     echo "Couldn't find Wifi test"
fi

#These are json objects by themselves
cpuresult=$(cat ./Results/cpuresult.json)
#implement wifitest
wifiresult="{}"

echo '{"CpuTest":'$cpuresult',"WifiTest":'$wifiresult'}' > ./Results/testresult.json

/bin/bash ./VersionControl/versioncontrol.sh
