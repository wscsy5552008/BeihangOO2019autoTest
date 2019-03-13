#!/bin/bash
grep -wr "main" . > findmain
grep -Go ".*.java" findmain > compileSrc
grep -Go "\\.\\/.*\\/" compileSrc > compileDatapath
echo -n>exeFile
origin=$(pwd)

cat compileSrc | while read line

do
	it=(${line##*/})
	echo ${it%.*} >> exeFile
done

echo -n > Result
cat $1 | while read line

do
    echo ------------------------------ >> Result
    echo $line >>Result
    echo ------------------------------ >> Result
    s=0
	cat compileDatapath | while read road
	do	
  		s=$(($s+1))
		exe=$(sed -n "$s p" exeFile)
    		cd "$road"
		name=(${road#*/})
		real=(${name%/*})
    		echo -n $real >> ../Result
		echo -en "\t" >> ../Result
    		echo $line | java "$exe" >> ../Result
    		cd "$origin"    
    		echo >> Result
	done
done
#rm findmain compileSrc compileDatapath exeFile
