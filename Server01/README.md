使用：
    1、命令窗口cd到服务器目录文件夹下
    2、执行命令：java -jar moco-0.11.0.jar start -p 8080 -g Configs.json;
    3、接口：http://本机ip:8080/(uri)

注意点：
1、headers为application/json类型,后面是一个json
"headers":{
"content-type":"application/json"
},
"json":{
"name" :"zhangsan",
"password" :"123456"
}

2、headers为application/x-www-form-urlencoded类型,后面是一个forms
"headers":{
"content-type":"application/x-www-form-urlencoded"
},
"forms":{
"name" :"zhangsan",
"password" :"123456"
}

3、request 请求

有14个固定的属性:

method,headers,json,factory,uri,text,cookies,xpaths,

json_paths,version,file,queries,path_resource,forms。

一定要遵循这些方法。

常用的method(请求方式),headers(heads参数),uri(url地址),file(指定调用的请求文件),queries(请求带参)，forms(表单内容)。

4、response 响应

有12个固定属性：

status,attachment,headers,version,factory,file,text,proxy,cookies,json,latency,path_resource。

5、延迟
"response":{
"latency":{"duration": 1,"unit": "second"},
"file":"login/login_fail_response.json"
}

