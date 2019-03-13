# 说明
1、在当前目录下放入源码文件夹，一个文件夹装一个人的源码，如果有多人，分装不同的文件夹
2、在当前目录下放入待测数据文件，可以多行，一行代表一个测试数据，设文件名为a
3、运行autoCompile.sh自动编译所有源码
4、linux下运行./Test.sh a  
5、结果在Result文件中看

注：
1、若源码是一个package，暂时无法运行，可以把pakage去掉运行，正在解决这个问题。
2、有些小bug、还在修复，不影响正确性，只影响体验（有些测试数据会自动变更）
3、windows下会有问题，是脚本中while read的问题，可以将autoCompile.sh中的循环去掉就可以使用，但只能测一个数据，在修复了1后会尽快解决此问题。
