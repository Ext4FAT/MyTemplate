LAST=`ls -l --time-style="+%Y-%m-%d  %H:%M:%S" IDLER_thesis.tex|awk '{print $(NF-2)"-"$(NF-1)}' `
while true
do
    NEW=`ls -l --time-style="+%Y-%m-%d  %H:%M:%S" IDLER_thesis.tex|awk '{print $(NF-2)"-"$(NF-1)}'` 
    if [ "$LAST" != "$NEW" ];then
        #echo "[$NEW != $LAST]"
        LAST=$NEW
        ./make.bat 1>./tmp/make.log 2>./tmp/error.log
        echo "[$NEW] updated."
    fi
    sleep 1 
done
