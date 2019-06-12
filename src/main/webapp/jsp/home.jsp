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
<form id="form0" name="form1" method="post" action="/fuzzyQuery">
    User name&nbsp;
    <input type="text" name="username" placeholder="Query by username" style="height: 30px">
    &nbsp;&nbsp;&nbsp;
    <button type="submit" value="Query" class="btn btn-default" style="color: #2e6da4">Query</button>
    &nbsp;&nbsp;&nbsp;&nbsp;
    <button class="btn btn-default"><a href="../jsp/add.jsp">AddUser</a></button>
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
        <c:forEach var="user" items="${page.list}">
            <tr align="center">
                <td><input type="checkbox" name="ids" value="${user.id}"></td>
                <td>${user.username}</td>
                <td>${user.password}</td>
                <td>${user.email}</td>
                <td>${user.phone}</td>
                <td>${user.rolename}</td>
                <td><button class="btn btn-default"><a href="/toEdit?id=${user.id}">edit</a></button></td>
                <td><button class="btn btn-default"><a href="/delete?id=${user.id}">delete</a></button></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <button type="submit" name="deletes" class="btn btn-default" style="color: #2e6da4">BatchDeletion</button>&nbsp;&nbsp;&nbsp;

    <table align="center">
        <tr>
        <td>
            The current page is ${page.currentPage}, with ${page.totalPage} page and ${page.totalRecord} records.
            Each page shows ${page.pageSize} records
            <ul class="pager">
                <c:if test="${page.currentPage != 1}">
                    <li><a href="/home?currentPage=1">Home</a></li>&nbsp;&nbsp;
                    <li><a href="/home?currentPage=${page.currentPage-1}">Previous</a></li>&nbsp;&nbsp;
                </c:if>
                <c:if test="${page.currentPage != page.totalPage}">
                    <li><a href="/home?currentPage=${page.currentPage+1} ">Next</a></li>&nbsp;&nbsp;
                    <li><a href="/home?currentPage=${page.totalPage}">End</a></li>
                </c:if>
            </ul>
        </td>
    </tr>
    </table>
</form>
</body>
</html>
