#!/bin/sh -x

filename=hadoop_home.tar.gz
website=http://glidein.unl.edu/hadoop_grid/hadoop_home.tar.gz

source $OSG_GRID/setup.sh
export OSG_SQUID_LOCATION=${OSG_SQUID_LOCATION:-UNAVAILABLE}
if [ "$OSG_SQUID_LOCATION" != UNAVAILABLE ]; then
  export http_proxy=$OSG_SQUID_LOCATION
fi

wget --retry-connrefused --waitretry=10 $website

# Check if the download worked
if [ $? -ne 0 ]
then
   unset http_proxy
   wget --retry-connrefused --waitretry=10 $website
   if [ $? -ne 0 ]
   then
      exit 1
   fi
fi


# Untar the downloaded file
tar xzf hadoop_home.tar.gz

# Setup and start hadoop
# This now blocks
#cp keystore-2.jks hadoop_home/keystore.jks hadoop_home/conf/keystore.jks
sh hadoop_home/bin/deployHadoop.sh 

# Sleep for some random number between 4 hours and 8 hours
#sleep_time=$RANDOM
#let "sleep_time = (sleep_time % 14400) + 14400"
#echo "sleeping for $sleep_time"
#sleep $sleep_time



# Clean up
sh hadoop_home/bin/killSlave.sh
rm -rf hadoop_home*
rm -f err.*
rm -f out.*


