<%--
  Author: Lin
  Date: 2019/6/1
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>login</title>
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
<div class="container" style="padding-top: 200px;padding-left: 50px">
    <div class="form-horizontal col-md-offset-3">
        <h3>Login</h3>
<form action="/login" method="post">
    <div class="col-md-6">
        <div class="form-group">
            <input class="form-control" type="text" placeholder="Username" name="username">
        </div>
        <div class="form-group">
            <input class="form-control" type="text" placeholder="Password" name="password">
        </div>
        <div class="form-group">
            <button class="btn btn-success" type="submit" id="submit">submit</button>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button class="btn btn-primary" type="reset">reset</button>
        </div>
    </div>
</form>
    </div>

</div>
<div align="center" style="color: red">
<b>${msg}</b>

</div>
</body>

</html>
