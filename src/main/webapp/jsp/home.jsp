<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/5/29
  Time: 10:35
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>home</title>
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
    <li class="active">Home</li>
    <li class="active">2019</li>
</ul>

<div style="padding: 0px 10px 10px 10px;">
<form id="form0" name="form1" method="post" action="fuzzyQuery">
    <input type="text" name="username" placeholder="用户名模糊查询" style="height: 30px">
    &nbsp;&nbsp;&nbsp;
    <button type="submit" value="Query" class="btn btn-default" style="color: #2e6da4">查询</button>
    &nbsp;&nbsp;&nbsp;&nbsp;
    <button class="btn btn-default" type="button" data-toggle="modal" data-target="#addModal"><a>添加用户</a></button>
    <table align="right">
        <tr>
            <td><button type="submit" value="logout" class="btn btn-default"><a>退出系统</a></button> </td>
        </tr>
    </table>
</form>
</div>

<form id="form1" name="form1" method="post" action="batchDeletion">
    <table class="table table-hover" border="1px" style="border-color: #e9f5e3;font-size: 14px">
        <thead>
        <tr align="center">
            <td><input type="checkbox" name="ids"/></td>
            <td>用户名</td>
            <td>密码</td>
            <td>邮箱</td>
            <td>电话</td>
            <td>职位</td>
            <td colspan="2">操作</td>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${page.list}">
            <tr align="center">
                <td><input type="checkbox" name="ids" value="${user.id}"></td>
                <td>${user.username}</td>
                <td>${user.password}</td>
                <td>${user.email}</td>
                <td>${user.phone}</td>
                <td>${user.rolename}</td>
                <td><button type="button" class="btn btn-default" data-toggle="modal" data-target="#editModal"
                            onclick="edit(${user.id})"><a>编辑</a></button></td>
                <td><button type="button" class="btn btn-default" onclick="deleteUser(${user.id})"><a>删除</a></button></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <button type="submit" name="deletes" class="btn btn-default" style="color: #2e6da4" onclick="batchDelete()">批量删除</button>&nbsp;&nbsp;&nbsp;

    <table align="center">
        <tr>
        <td>
            当前是第 ${page.currentPage} 页, 共 ${page.totalPage} 页和 ${page.totalRecord} 条记录.
            每页显示 ${page.pageSize} 条记录.
            <ul class="pager">
                <c:if test="${page.currentPage != 1}">
                    <li><a href="home?currentPage=1">首页</a></li>&nbsp;&nbsp;
                    <li><a href="home?currentPage=${page.currentPage-1}">上一页</a></li>&nbsp;&nbsp;
                </c:if>
                <c:if test="${page.currentPage != page.totalPage}">
                    <li><a href="home?currentPage=${page.currentPage+1} ">下一页</a></li>&nbsp;&nbsp;
                    <li><a href="home?currentPage=${page.totalPage}">尾页</a></li>
                </c:if>
            </ul>
        </td>
    </tr>
    </table>
</form>

<!-- 修改模态框（Modal） -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>	<!--关闭-->
                <h4 class="modal-title">
                    修改用户信息
                </h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="user_form_edit">
                    <div class="form-group">
                        <label for="edit_id" class="col-sm-2 control-label">id</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="edit_id" name="id" readonly="readonly">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_username" class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="edit_username" placeholder="username" name="username">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_password" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="edit_password" placeholder="password" name="password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="edit_email" placeholder="email" name="email">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_phone" class="col-sm-2 control-label">电话</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="edit_phone" placeholder="phone" name="phone">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_rolename" class="col-sm-2 control-label">职位</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="edit_rolename" placeholder="rolename" name="rolename">
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

<!-- 添加模态框（Modal） -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>	<!--关闭-->
                <h4 class="modal-title">
                    添加用户
                </h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="user_form_add">
                    <div class="form-group">
                        <label for="add_username" class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="add_username" placeholder="username" name="username">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add_password" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="add_password" placeholder="password" name="password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add_email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="add_email" placeholder="email" name="email">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add_phone" class="col-sm-2 control-label">手机</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="add_phone" placeholder="phone" name="phone">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add_rolename" class="col-sm-2 control-label">职位</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="add_rolename" placeholder="rolename" name="rolename">
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" onclick="addUser()">
                    添加
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
        success:function (data) {   //data为：User形式的json字符串
            $("#edit_id").val(data.id);
            $("#edit_username").val(data.username);
            $("#edit_password").val(data.password);
            $("#edit_email").val(data.email);
            $("#edit_phone").val(data.phone);
            $("#edit_rolename").val(data.rolename);
        },
        error:function () {
            alert("意外错误！无法修改");
        }
    });
}
function updateUser() {
    //$.post(url,data,callback,type);
    $.post(
        "/update",
        //使用ajax的表单序列化方法提交表单数据
        $("#user_form_edit").serialize(),
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
function addUser() {
    if (confirm('确定要添加该用户吗?')) {
        $.post(
            "/add",
            $("#user_form_add").serialize(),
            function (data) {
                alert("添加用户成功！");
                window.location.reload();
            }
        )
    }
}
function batchDelete() {
    if (confirm('确定要删除这些用户吗?')) {
        alert("用户信息删除成功！");
        window.location.reload();
    }
}
</script>
</body>
</html>
