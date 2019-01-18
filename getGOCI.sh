#this sript is for batch downloading goci L1B data
# author: Pan Yanqun,East China Normal University
# date:2017.3.30

echo "this bash script is for batch downloading GOCI L1B image"
echo "before run this script, you should go to the kosc website(\"http://kosc.kiost.ac/eng/p10/kosc_p11.html\")"
echo "and agree the agreement\n"
echo "input the start date and end date,all the download links will be save to a .txt (goci_url_download.txt)"

read -p "input start date (yyyy-mm-dd):" start_date
echo -e "start date:" $start_date
read -p "input end date (yyyy-mm-dd):" end_date
echo -e "start date:" $end_date

post_pre="src1=GOCI&src2=1.0%2FL1B&src3=01012206&start_date="
post_end="&end_date="
post=${post_pre}${start_date}${post_end}${end_date}
echo $post

curl -d $post "http://kosc.kiost.ac/eng/p10/list.php">kosc_response1.html

cat -n ./kosc_response1.html |grep '<li>' | awk -F '\<\/li\>\<li\>' 'BEGIN{kosc="http://222.236.46.45/nfsdb/COMS/GOCI/1.0"};{
for(i=1;i<NF;i++)
{
endi = match($i,".zip\<\/a");starti = match($i,"\>COMS_GOCI_L1B_GA_");endi =endi-4; filename=substr($i,starti+1,endi-starti+7);
year = substr(filename,18,4);month = substr(filename,22,2);day = substr(filename,24,2);
print kosc"/"year"/"month"/"day"/L1B/"filename
}
}'> goci_url_download.txt

echo "\n url is saved as goci_url_download.txt"