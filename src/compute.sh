#main function
count=1
total=1
echo -n > "$1"
line=$(sed -n "$count p" input.txt)
result=$(sed -n "$total p" computeResult)
echo "compute to $1"
while :

do
    if [ "$line" = "EOF" ]; then
	break
    fi
    echo "compute data $count"
    count=$(($count+1))
    echo ------------------------------ >> "$1"
    echo "$line" >> "$1"
    echo ------------------------------ >> "$1"
    s=1
    road=$(sed -n "$s p" compileDatapath)
	while :

	do	

		#echo "test datafor src $s"
        if [ "$road" = "EOF" ]; then 
			break
		fi
        name=(${road#*/})
        real=(${name%%/*})

		printf "|%-10s|\t" "$real" >> "$1"
    	printf "%s\n" "$result" >> "$1"
        s=$(($s+1))
        total=$(($total+1))

		road=$(sed -n "$s p" compileDatapath)
        result=$(sed -n "$total p" computeResult)

	done

    line=$(sed -n "$count p" input.txt)

done
