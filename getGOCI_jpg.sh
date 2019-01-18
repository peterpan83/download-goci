echo "this bash script is for batch downloading GOCI L1B image"
echo "before run this script, you should go to the kosc website(\"http://kosc.kiost.ac/eng/p10/kosc_p11.html\")"
echo "and agree the agreement\n"
echo "input the start date and end date,all the download links will be save to a .txt (goci_url_download.txt)"

read -p "input start date (yyyy-mm--dd):" start_date
echo -e "start date:" $start_date
read -p "input end date (yyyy-mm--dd):" end_date
echo -e "start date:" $end_date

post_pre="src1=GOCI&src2=1.0%2FL1B&src3=01012206&start_date="
post_end="&end_date="
post=${post_pre}${start_date}${post_end}${end_date}
echo $post

curl -d $post "http://kosc.kiost.ac/eng/p10/list.php">kosc_response1.html

cat -n ./kosc_response1.html |grep '<li>' | awk -F '\<\/li\>\<li\>' 'BEGIN{kosc="http://kosc.kiost.ac"};{
for(i=1;i<NF;i++)
{
si=match($i,"viewImgFnc\(");ei=match($i,".JPG");filename= substr($i,si+13,ei-si-9);
print kosc"/"filename
}
}'>> goci_JPG_url_download.txt

echo "\n url is saved as goci_JPG_url_download.txt"