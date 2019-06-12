<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/5/30
  Time: 14:55
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>add</title>
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
    <li class="active">Add</li>
    <li class="active">2019</li>
</ul>

<div style="width: 500px;padding: 20px">
<form id="form1" name="form1" action="/add" method="post" class="form-horizontal" role="form">
    <div class="form-group">
        <label class="col-sm-2 control-label">username</label>
        <div class="col-sm-10">
            <input type="text" class="form-control" name="username">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">password</label>
        <div class="col-sm-10">
            <input type="text" class="form-control" name="password">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">email</label>
        <div class="col-sm-10">
            <input type="text" class="form-control" name="email">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">phone</label>
        <div class="col-sm-10">
            <input type="text" class="form-control" name="phone">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">rolename</label>
        <div class="col-sm-10">
            <input type="text" class="form-control" name="rolename">
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
            <button type="submit" class="btn btn-success">submit</button>
            &nbsp;&nbsp;&nbsp;
            <button type="reset" class="btn btn-primary">reset</button>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button class="btn btn-default" onclick="javascript:history.back(-1)">return to home</button>
        </div>
    </div>
</form>
</div>
</body>
</html>
