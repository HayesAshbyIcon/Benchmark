#TODO BETTER FILE PATHING


#ShutDown Wolf and Eru

    adb shell am force-stop com.ifit.eru
    adb shell am force-stop com.ifit.standalone
  

if /bin/bash ~/Benchmark/CpuSuite/cputest.sh; 
    then
    cpuresult=$(cat \~/Sites/Benchmark/CpuSuite/cpuresult.json)
else
    #Couldn't find test
     echo "Couldn't find Cpu test"
fi

if /bin/bash ~/Benchmark/WifiSuite/wifitest.sh; 
    then
else
    #Couldn't find test
     echo "Couldn't find Wifi test"
fi



jsonobject='{"CpuTest":{"'"$cpuresult"'"},"WifiTest":{"'"$wifiresult"'"}}'



/bin/bash ~/Benchmark/WifiSuite/versioncontrol.sh $jsonobject
