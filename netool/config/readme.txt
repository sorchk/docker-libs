请将含有main方法的jar或springboot的jar文件使用docker的-v参数映射到/app/app.jar
例如：docker run -it -v /datadisk/myapp.jar:/app/app.jar sorc/boothelper:8-jdk