#!/bin/bash
grep -wr "main" . > findmain
grep -Go ".*.java" findmain > compileSrc
grep -Go "\\.\\/.*\\/" compileSrc > compileDatapath
cat compileDatapath | while read line

do
	echo $line
        javac -sourcepath $line $line/*.java
done
rm findmain compileSrc compileDatapath
