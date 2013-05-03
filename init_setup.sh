//log into raspberry pi
ssh-keygen ##to create .ssh directory...
cd .ssh
rm id* ##remove the nonsence keys
vi authorized_keys #add public keys

##do the updates
sudo apt-get update
sudo apt-get upgrade

sudo apt-get install git #install git



########
OUTFILE=/home/pi/DATA/DATA_`date +"%Y%m%d"`.csv
if [ ! -f $OUTFILE ]; then  echo date,time,temp1,temp2,humidity > $OUTFILE; fi
DATA=`date +"%D"`,`date +"%T"`,`cat /mnt/1wire/10.AAA4E4000800/temperature`,`cat /mnt/1wire/26.627E61000000/temperature`,`cat /mnt/1wire/26.627E61000000/humidity`
echo $DATA >> $OUTFILE

##########
OUTFILE=/home/pi/DATA/DATA_`date +"%Y%m%d"`.csv ; #define the output file
if [ ! -f $OUTFILE ]; then  echo date_time,sensorID,temperature,humidity > $OUTFILE; fi ; #initialize the file

cd /mnt/1wire/
###get just the temperature sensors
for TFILE in `find 10* -name temperature -type f`
do
TDIR=`dirname $TFILE` ; #et the directory name
echo `date +"%D %T"`,`cat ${TDIR}/id`,`cat ${TDIR}/temperature`, >> $OUTFILE
done

###get the temperature and humidity sensors
for TFILE in `find 26* -name temperature -type f`
do
TDIR=`dirname $TFILE` ; #et the directory name
echo `date +"%D %T"`,`cat ${TDIR}/id`,`cat ${TDIR}/temperature`,`cat ${TDIR}/humidity` >> $OUTFILE
done

###get the temperature and humidity sensors
for TFILE in `find 28* -name temperature -type f`
do
TDIR=`dirname $TFILE` ; #et the directory name
echo `date +"%D %T"`,`cat ${TDIR}/id`,`cat ${TDIR}/temperature`,`cat ${TDIR}/humidity` >> $OUTFILE
done



#crontab runs
#rsync -az /home/pi/DATA/ --rsh='ssh -p8822' jc165798@login.hpc.jcu.edu.au:/home/jc165798/BACKUP/home.1wire
#rsync -az /home/pi/DATA/ --rsh='ssh -p8822' jc165798@spatialecology.jcu.edu.au:/home/jc165798/1wireData

