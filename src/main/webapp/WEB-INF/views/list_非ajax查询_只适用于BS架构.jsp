<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><!--使用c:foreach必须引入的库-->
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"> <!--/*一些先开始，不以斜线结束*/-->
    <title>员工列表</title>

    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>

    <!--web路径
        不以/开始的相对路径找资源，以当前资源的路径为基准，经常出现问题
        以/开始的相对路径，以服务器的路径为标准（http://localhost:3306）：需要加上项目名
        http://localhost:3306/crud
    -->
    <!--引入JQuery:必须先引用-->
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.7.2.min.js"></script>
    <!--引入样式css-->
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" >
    <!--引入js文件-->
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js" ></script>
</head>
<body>
    <!--搭建显示页面:bootstrap是栅格动态分配，适时调节显示大小-->
    <div class="container">
        <!--第一行：标题-->
        <div class="row">
            <div class="col-md-12">
                <h1>SSM-CRUD</h1>
            </div>
        </div>
        <!--第二行：按钮-->
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary">新增</button>
                <button class="btn btn-danger">删除</button>
            </div>
        </div>
        <!--第三行：显示表格数据-->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                    <!--循环访问所获得的数据-->
                    <c:forEach items="${pageInfo.list}" var="emp">
                    <tr>
                        <th>${emp.empId}</th>
                        <th>${emp.empName}</th>
                        <th>${emp.gender=="M"?"男":"女"}</th>
                        <th>${emp.email}</th>
                        <th>${emp.department.deptName}</th>
                        <th>
                            <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span><!--用来加图标的-->
                                编辑
                            </button>

                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span><!--用来加图标的-->
                                删除
                            </button>
                        </th>
                    </tr>
                    </c:forEach>
                </table>
            </div>

        </div>
        <!--第四行：显示分页信息-->
        <div class="row">
            <!--分页文字信息-->
            <div class="col-md-6">
                当前第${pageInfo.pageNum}页,总共${pageInfo.pages}页,总共${pageInfo.total}条记录
            </div>
            <!--分页条信息:bootstrap获得-->
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <!--判断是否存在上一页，存在的话则显示首页按钮-->
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li>
                                <!--首页按钮的链接是重新发送emps请求去查询首页页码-->
                                <a href="${APP_PATH}/emps?pn=${pageInfo.navigateFirstPage}">首页</a>
                            </li>
                        </c:if>
                        <!--如果当前页是首页，就禁用首页按钮-->
                        <c:if test="${pageInfo.isFirstPage}">
                            <li class="disabled">
                                <a href="#">首页</a>
                            </li>
                        </c:if>
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                            <c:if test="${pageNum==pageInfo.pageNum}">
                                <li class="active"><a href="#">${pageNum}</a></li>
                            </c:if>
                            <c:if test="${pageNum!=pageInfo.pageNum}">
                                <li><a href="${APP_PATH}/emps?pn=${pageNum}">${pageNum}</a></li>
                            </c:if>

                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.navigateLastPage}">末页</a>
                            </li>
                        </c:if>
                        <!--如果当前页是末页，就禁用末页按钮-->
                        <c:if test="${pageInfo.isLastPage}">
                            <li class="disabled">
                                <a href="#">末页</a>
                            </li>
                        </c:if>

                    </ul>
                </nav>
            </div>



        </div>
    </div>

</body>
</html>
