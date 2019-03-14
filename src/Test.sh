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
	echo "$realpath" >> compileDatapath  
	echo "$realexe" >> exeFile
done

count=1

echo  > Result

line=$(sed -n "$count p" $1)

printf "EOF" >> compileDatapath
echo >>"$1"
echo EOF >> "$1"

while :

do
    echo "test $count data $line"
    count=$(($count+1))
    echo ------------------------------ >> Result
    echo "$line" >>Result
    echo ------------------------------ >> Result
    s=1
    road=$(sed -n "$s p" compileDatapath)
	while :

	do	

		echo "test datafor src $s"
		exe=$(sed -n "$s p" exeFile)
    		cd "$road"
                name=(${road#*/})
                real=(${name%%/*})
		cop=$(echo "$line" | java "$exe")
		printf "|%-10s|\t" $real >> $result
    		printf "%s\n" "$cop" >> $result
    		cd "$origin"   
		s=$(($s+1))
		road=$(sed -n "$s p" compileDatapath)
  		if [ "$road" = "EOF" ]; then 
			break
		fi
	done

    line=$(sed -n "$count p" $1)
    if [ "$line" = "EOF" ]; then
	break
    fi
done

tail -1 compileDatapath
tail -1 "$1"
rm findmain compileSrc compileDatapath exeFile Datapath
open -e Result
