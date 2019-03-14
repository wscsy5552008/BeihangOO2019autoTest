#!/bin/bash
grep -wr "main" . > findmain
grep -Go ".*.java" findmain > compileSrc
grep -Go "\\.\\/.*\\/" compileSrc > Datapath
echo -n>exeFile
echo -n>compileDatapath
origin=$(pwd)
result=$origin"/Result"


#get package name and update the Datapath file and compileSrc file
i=0
cat compileSrc | while read line

do
	i=$(($i+1))
	
	path=$(sed -n "$i p" Datapath)
	it=(${line##*/})
	exe=(${it%.*})
	
	pac=$(grep -G "package" "$line")
	if [ "$pac" = "" ]; then
		realpath=$path
		realexe=$exe
	else
		realPackage1=(${pac#* })
		realPackage2=(${realPackage1%\;})
		
		packagePath=(${realPackage2%%.*})
		paPath=/$packagePath/
		realpath=(${path%"$paPath"*})
		
		realexe=$realPackage2.$exe
	fi

	echo "$realpath" >> compileDatapath  
	echo "$realexe" >> exeFile
done

#main function
count=1

echo -n > Result

line=$(sed -n "$count p" $1)

printf "EOF" >> compileDatapath
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

#delete the mid-file and mid-data
$ sed -i '$d' "$1"
rm findmain compileSrc compileDatapath exeFile Datapath
open -e Result
