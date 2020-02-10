#TODO BETTER FILE PATHING

if /bin/bash ~/Sites/Benchmark/CpuSuite/cputest.sh; 
    then
    cpuresult=$(cat \~/Sites/Benchmark/CpuSuite/cpuresult.json)
else
    #Couldn't find test
     echo "Couldn't find Cpu test"
fi

#if /bin/bash ~/Sites/Benchmark/WifiSuite/wifitest.sh; 
#    then
#else
    #Couldn't find test
#     echo "Couldn't find Wifi test"
#fi



jsonobject='{"CpuTest":{"'"$cpuresult"'"},"WifiTest":{"'"$wifiresult"'"}}'



/bin/bash ~/Sites/Benchmark/WifiSuite/versioncontrol.sh $jsonobject
