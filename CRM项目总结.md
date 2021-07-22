# 项目前期准备  

## ajax的几种形式  

1. $.ajax：基于jQuery的Ajax最标准、基本的形式，应用范围最广泛  

   ​		常见的一些设置：

     - url：设置请求的url
     - data：表示要发送到服务器的数据
     - dataType：表示从服务器接收的数据的类型，常用的为（text、json）
     - success：请求成功后的回调函数
     - error：请求失败的回调函数
     - type：（GET/POST）请求的类型

2. $.get/post：在基于$.ajax上的简写形式，规定了发送请求的方式

   ​	`$.get(URL,data,function(data,status,xhr),dataType)`

   ​	*status* - 包含请求的状态（"success"、"notmodified"、"error"、"timeout"、"parsererror)"

3. $.getJSON：该方法是专门为JSON格式准备的方法，能更方便的处理JSON文件

   ​	`$(selector).getJSON(url,data,success(data,status,xhr))`  

4. 在以查询为目的的请求用get，添加、删除、修改用post

## jQuery存取值的方式  

1. val(值)：当值为空时表示取值，反之表示存值
2. html(值)：可以获取以及设置一个节点的内部的元素
3. text(值)：只能获取及设置一个节点的标签内文本
4. 如果从服务器返回的结果为一个JSON对象，则取这个值的方式为data.key

## 前后端传值的方式   

从前端传值给后端：

​	form表单、url、ajax请求

从后端传值给前端：
![image-20210702232705417](E:\Code\javaProject\CRM\image-20210702232705417.png)

## 多表联查  

在多表联查中，如果有两张表的字段名相同，在查询时注意使用别名  

多表联查时，如果涉及多个bean，有以下两种解决方式  

使用map（当前端对数据重复使用要求不高时使用）  

使用vo（value object：将多个bean对象的属性封装成一个类。当前端对数据重复使用要求高时使用）  

### git&github的使用

![image-20210710174255371](E:\Code\javaProject\CRM\image-20210710174255371.png)  

**本地库与远程库之间的交互：**  

push：将本地库的项目推送到远程库  

pull：将远程库中的项目更新到本地库

clone：将远程库项目完整克隆到本地库  

### 数据库设计

1. 对于数据库主键，在开发中尝试用char类型，UUID类
2. 数据库中通常不使用外键约束（为了减少查询所需的时间）  

## 后端开发-分层架构  

### Controller实现层：  
该层主要是编写Controller实现类，作为请求的入口，负责前后端的交互；

### Service业务层：  
该层主要是编写Service接口和ServiceImpl实现类，

编写Service接口的作用在于可实现接口与实现类的解耦，

为什么要实现接口与实现类的解耦？

1. 当编写业务层接口的人和编写业务层实现类的人不是同一个人时，可实现互不影响

2. 代码的调用先于代码的实现，所以可以先写好接口，用于Controller层的调用，后续再到实现类去实现这个接口，编写业务逻辑

编写ServiceImpl实现类，负责业务逻辑的实现

### Dao持久层：  
该层主要是编写Dao接口，负责Java和数据库的交互

### Entity实体层：  
该层主要是编写Entity实体类，负责映射数据库表

*上面这些是一个Java后端开发所必须的架构分层*

*除了以上必须的架构分层以外，还可以根据自身条件创建以下分层*

### Dto输出结果的封装层：  
该层主要是编写Dto实体类，负责对指定功能模块的输出结果进行封装处理

### Param输入参数的封装层：  
该层主要是编写Param实体类，负责对输入的参数进行封装处理

### Config配置层：  
该层主要是编写Config实体类，负责存放相关配置类（但一般配置信息都是写在application.properties或application.yml）

### Util工具层：  
该层主要是编写Util实体类，负责存放相关工具类

