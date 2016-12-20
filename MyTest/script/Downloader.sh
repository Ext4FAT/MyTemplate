#!/bin/bash


COV="cov"	#COVER
BOK="bok"	#BOOKNAME
LEG="leg"	#COPYRIGHT
FOW="fow"	#FORWORD
CATA="!00"	#CATALOG

mywget(){
  URL=$1
  JID=$2
  PATH=$3
  #echo $JID $PATH
  /usr/bin/wget "$URL$JID" -O $PATH 1>/dev/null 2>/dev/null
}

safedown(){
  URL=$1
  TYPE=$2
  i=1
  for i in `/usr/bin/seq 1 10`; do 
    file=$(printf "%03d" "$i")
    mywget $URL $TYPE$file".jpg" "./$NAME/$TYPE$file.jpg"
    filesize=`/bin/ls -l "./$NAME/$TYPE$file.jpg" | /usr/bin/awk '{ print $5 }'` 
    if [ $filesize -lt 1000 ]; then
      /bin/rm "./$NAME/$TYPE$file.jpg"
      break
    fi
  done
}

content(){
  HTML=$1 
  NAME=`/bin/grep "<title>" $HTML | /bin/sed 's/<[^<>]*>//g'|/usr/bin/tr -d "\n\t\r "`
  PAGES=`/bin/grep -Eo "epage = [0-9]+" $HTML|/bin/grep -Eo "[0-9]+"`
  URL=`/bin/grep -Eo "http://114.212.7.104:88/png/png.dll[^' ]+" $HTML`

  /bin/mkdir $NAME 
  if [ ! $? -eq 0 ];then
    return 
  fi
  
  #PREFIX
  safedown $URL $COV
  safedown $URL $BOK
  safedown $URL $LEG
  safedown $URL $FOW
  safedown $URL $CATA

  #CONTENT  
  for i in `/usr/bin/seq 1 $PAGES`; do 
    file=$(printf "%06d" "$i")
    mywget $URL $file".jpg" "./$NAME/"$file".jpg"
  done
}

html(){
  BOOKS=$1
  i=0
  while read URL
  do
    i=`expr $i + 1`
    wget "$URL" -O $i.html
  done  <$BOOKS
  return $i;
}


html "Booklist.txt"
ROWS=$?
for index in `/usr/bin/seq 1 $ROWS`; do
  content "$index.html"
  /bin/rm "$index.html"
done



#URL PARA
#URL="http://114.212.7.104:88/png/png.dll"
#DID="a174"
#PID="705A149D7950F4CD7D9BF9570E772A1FABDBC05F46DF7BC244F4C774EE347F469999390FA43A74EC2B7735C306C456CC19E5E04EAC9466AA16AC3D79C93998E97E1D0BCE879F784309C7A0BCA6242DE24A809AF6EFB82B65880284CB1C02580A2BECE9E7C1FF054AD5F16C744ECF6FBB3A15"




