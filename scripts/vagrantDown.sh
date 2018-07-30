echo "vagrantDown: finding all runnning vagrant boxes"
vagrant global-status | awk '/running/{print $1}' >> /tmp/vagrantRunning.txt
sleep 3
echo "vagrantDown: shutting down all running boxes"
while read p; do
 echo "halting box" $p
 vagrant halt $p
done </tmp/vagrantRunning.txt
rm /tmp/vagrantRunning.txt