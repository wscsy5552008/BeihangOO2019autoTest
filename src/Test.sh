#!/bin/bash
grep -wr "main" . > findmain
grep -Go ".*.java" findmain > compileSrc
grep -Go "\\.\\/.*\\/" compileSrc > Datapath
echo -n>exeFile
echo -n>compileDatapath
origin=$(pwd)
result=$origin"/Result"

i=0
cat compileSrc | while read line

do
	i=$(($i+1))
	
	path=$(sed -n "$i p" Datapath)
	it=(${line##*/})
	exe=(${it%.*})
	
	pac=$(grep -Go "package" "$line")
	if [ "$pac" = "package" ]; then
		realpatho=(${path%/*})
		realpath=(${realpatho%/*})
		ppp=(${realpatho##*/})
		realexe=$ppp.$exe	
	else
		realpath=$path
		realexe=$exe
	fi
	echo $realpath >> compileDatapath  
	echo $realexe >> exeFile
done

count=0

echo -n > Result
cat $1 | while read line
do
    echo "test $count data"
    count=$(($count+1))
    echo ------------------------------ >> Result
    echo $line >>Result
    echo ------------------------------ >> Result
    s=0
	cat compileDatapath | while read road
	do	
  		s=$(($s+1))
		echo test data $i for src $s
		exe=$(sed -n "$s p" exeFile)
    		cd "$road"
                name=(${road#*/})
                real=(${name%%/*})
		printf "|%-10s|\t" $real >> $result
    		echo $line | java "$exe" >> $result
    		cd "$origin"   
	done
done
rm findmain compileSrc compileDatapath exeFile Datapath
open -e Result
