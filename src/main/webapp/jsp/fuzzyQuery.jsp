<%--
  Author: Lin
  Date: 2019/6/2
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>fuzzy paging</title>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <style type="text/css">
        a:link,a:visited{
            text-decoration:none;
        }
        body{
            background-color: #eff5cf;
        }
    </style>
</head>
<body>
<ul class="breadcrumb" style="font-size: 20px">
    <li class="active">Position</li>
    <li class="active">Query</li>
    <li class="active">2019</li>
</ul>

<div style="padding: 0px 10px 10px 10px;">
    <form id="form0" name="form1" method="post" action="/fuzzyQuery" class="bs-example bs-example-form" role="form">
        User name&nbsp;
        <input type="text"  name="username" placeholder="Query by username" style="height: 30px">
        &nbsp;&nbsp;&nbsp;
        <button type="submit" value="Query" class="btn btn-default" style="color: #2e6da4">Query</button>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <button class="btn btn-default"><a href="../jsp/add.jsp" >AddUser</a></button>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <button class="btn btn-default"><a href="/home">return to home</a></button>
        <table align="right">
            <tr>
                <td><button type="submit" value="logout" class="btn btn-default"><a href="/logout">logout</a></button> </td>
            </tr>
        </table>
    </form>
</div>

<form id="form1" name="form1" method="post" action="/batchDeletion">
    <table class="table table-hover" border="1px" style="border-color: #e9f5e3;font-size: 14px">
        <thead>
        <tr align="center">
            <td><input type="checkbox" name="ids"></td>
            <td>userName</td>
            <td>password</td>
            <td>email</td>
            <td>phone</td>
            <td>roleName</td>
            <td colspan="2">action</td>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${page1.list}">
            <tr align="center">
                <td><input type="checkbox" name="ids" value="${user.id}"></td>
                <td>${user.username}</td>
                <td>${user.password}</td>
                <td>${user.email}</td>
                <td>${user.phone}</td>
                <td>${user.rolename}</td>
                <td><button type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal"
                            onclick="edit(${user.id})"><a>edit</a></button></td>
                <td><button class="btn btn-default" onclick="deleteUser(${user.id})"><a>delete</a></button></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <button type="submit" name="deletes" class="btn btn-default" style="color: #2e6da4">BatchDeletion</button>&nbsp;&nbsp;&nbsp;

    <table align="center">
        <tr>
            <td>
                The current page is ${page1.currentPage}, with ${page1.totalPage} page and ${page1.totalRecord} records.
                Each page shows ${page1.pageSize} records
                <ul class="pager">
                <c:if test="${page1.currentPage != 1}">
                    <li><a href="/fuzzyQuery?currentPage=1">Home</a></li>&nbsp;&nbsp;
                    <li><a href="/fuzzyQuery?currentPage=${page1.currentPage-1}">Previous</a></li>&nbsp;&nbsp;
                </c:if>
                <c:if test="${page1.currentPage != page1.totalPage}">
                    <li><a href="/fuzzyQuery?currentPage=${page1.currentPage+1} ">Next</a></li>&nbsp;&nbsp;
                    <li><a href="/fuzzyQuery?currentPage=${page1.totalPage}">End</a></li>
                </c:if>
                </ul>
            </td>
        </tr>
    </table>
</form>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>	<!--关闭-->
                <h4 class="modal-title" id="myModalLabel">
                    修改用户信息
                </h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="user_form">
                    <div class="form-group">
                        <label for="id" class="col-sm-2 control-label">id</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="id" name="id" readonly="readonly">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="username" class="col-sm-2 control-label">username</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="username" placeholder="username" name="username">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password" class="col-sm-2 control-label">password</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="password" placeholder="password" name="password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="email" placeholder="email" name="email">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="phone" class="col-sm-2 control-label">phone</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="phone" placeholder="phone" name="phone">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="rolename" class="col-sm-2 control-label">rolename</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="rolename" placeholder="rolename" name="rolename">
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" onclick="updateUser()">
                    提交更改
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<script type="text/javascript">
    function edit(id) {
        $.ajax({
            type:"post",
            url:"/toEdit",
            data:{"id":id},
            success:function (data) {
                $("#id").val(data.id);
                $("#username").val(data.username);
                $("#password").val(data.password);
                $("#email").val(data.email);
                $("#phone").val(data.phone);
                $("#rolename").val(data.rolename);
            },
            error:function () {
                alert("意外错误！无法修改");
            }
        });
    }
    function updateUser() {
        $.post(
            "/update",
            $("#user_form").serialize(),
            function(data){
                alert("用户信息更新成功！");
                window.location.reload();
        });
    }
    function deleteUser(id) {
        if (confirm('确实要删除该用户吗?')) {
            $.post(
                "/delete",
                {"id":id},
                function(data){
                    alert("用户信息删除成功！");
                    window.location.reload();
                });
        }
    }
</script>
</body>
</html>
