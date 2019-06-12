<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/5/30
  Time: 9:43
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>edit</title>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <style type="text/css">
        body{
            background-color: #eff5cf;
        }
    </style>
</head>
<body>
<ul class="breadcrumb" style="font-size: 20px">
    <li class="active">Position</li>
    <li class="active">Edit</li>
    <li class="active">2019</li>
</ul>

<div style="width: 500px;padding: 20px">
<form id="form1" name="form1" action="/update?id=${user.id}" method="post" class="form-horizontal" role="form">
    <div class="form-group">
        <label class="col-sm-2 control-label">id</label>
        <div class="col-sm-10">
            <input type="text" class="form-control" name="id" value="${user.id}" readonly="readonly">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">username</label>
        <div class="col-sm-10">
            <input type="text" class="form-control" name="username" value="${user.username}">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">password</label>
        <div class="col-sm-10">
            <input type="text" class="form-control" name="password" value="${user.password}">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">email</label>
        <div class="col-sm-10">
            <input type="text" class="form-control" name="email" value="${user.email}">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">phone</label>
        <div class="col-sm-10">
            <input type="text" class="form-control" name="phone" value="${user.phone}">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">rolename</label>
        <div class="col-sm-10">
            <input type="text" class="form-control" name="rolename" value="${user.rolename}">
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
            <button type="submit" class="btn btn-success">submit</button>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <button class="btn btn-default" onclick="javascript:history.back(-1)">return to home</button>
        </div>
    </div>
</form>
</div>
</body>
</html>
