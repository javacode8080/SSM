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
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <!--引入样式css-->
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" >
    <!--引入js文件-->
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js" ></script>
</head>
<body>
<!--模态框：员工添加的模态框-->
<!-- Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_input" placeholder="empName">
                            <span  class="help-block"> </span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@163.c0m"><!--placeholder:示例填充-->
                            <span  class="help-block"> </span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-10">
                        <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                        <!--内联表单，value属性代表的是选择这个单选按钮所提交的信息-->
                        <label class="radio-inline">
                            <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                        </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!--下拉列表：从数据库查询部门名:部门提交部门id-->
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>





<!--模态框：员工修改的模态框-->
<!-- Modal -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"> </p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@163.c0m"><!--placeholder:示例填充-->
                            <span  class="help-block"> </span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-10">
                            <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                            <!--内联表单，value属性代表的是选择这个单选按钮所提交的信息-->
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_aupdate_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!--下拉列表：从数据库查询部门名:部门提交部门id-->
                            <select class="form-control" name="dId" id="dept_update_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>








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
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <!--第三行：显示表格数据-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead><!--表头-->
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all">
                        </th>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody><!--表格体:ajax通过回调函数进行添加-->

                </tbody>


            </table>
        </div>

    </div>
    <!--第四行：显示分页信息-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-md-6" id="page_info_area">

        </div>
        <!--分页条信息:bootstrap获得-->
        <div class="col-md-6" id="page_nav">
        </div>
    </div>
    <!--发起ajax请求-->
    <script type="text/javascript">
        var totoalRecord;//全局变量，总记录数
        var empName_flag;//姓名校验状态
        var email_flag;//邮箱校验状态
        var email_update_flag=true;//修改的邮箱校验状态
        var currentPage;//当前页
        //1.页面加载完成之后，直接发起一个ajax请求，要到分页数据
        $(function () {
        //去首页
            toPage(1);//将ajax请求封装为方法，方便与导航条点击响应ajax请求
        });
        //解析并显示员工数据
        function build_emps_table(result){
            //由于ajax是无刷新请求，所有在每次发生ajax请求的时候需要先清空所有数据
            $("#emps_table tbody").empty();

            var emps=result.extend.pageInfo.list//获取员工信息
            //遍历数据进行显示
            $.each(emps,function (index,item) {//index:遍历的位置坐标，item:对应坐标的数据
                //构建表格显示的员工行
                //0.checkbox:选择框：用来批量删除使用
                var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>");
                //1.员工Id
                var empIdTd=$("<td></td>").append(item.empId);
                //2.员工姓名
                var empNameTd=$("<td></td>").append(item.empName);
                //3.员工性别
                var genderTd=$("<td></td>").append(item.gender=="M"?"男":"女");
                //4.员工邮箱
                var emailTd=$("<td></td>").append(item.email);
                //5.员工部门名
                var deptNameTd=$("<td></td>").append(item.department.deptName);
                //6.按钮设计
                var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
                //6.1:为编辑按钮添加一个自定义属性，表示当前员工的id
                editBtn.attr("edit-id",item.empId);
                var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm del_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                delBtn.attr("edit-id",item.empId);
                var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);
                $("<tr></tr>").append(checkBoxTd)
                              .append(empIdTd)
                              .append(empNameTd)
                              .append(genderTd)
                              .append(emailTd)
                              .append(deptNameTd)
                              .append(btnTd)
                              .appendTo("#emps_table tbody");//appendTo表示添加到对应id的表格中
            })
        }
        //解析显示分页信息
        function build_page_info(result) {
            $("#page_info_area").empty();

            $("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum+"页,总共"+result.extend.pageInfo.pages+"页,总共"+result.extend.pageInfo.total+"条记录")
            totoalRecord=result.extend.pageInfo.total;
            currentPage=result.extend.pageInfo.pageNum;
        }
        //解析并解析分页条,点击分页要能去下一页，需要添加ajax请求
        function build_page_nav(result) {
            //page_nav
            $("#page_nav").empty();
            //ul
            var ul=$("<ul></ul>").addClass("pagination")

            //1.首页li
            var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));//$(selector).attr(attribute,value)attribute	规定属性的名称   value	规定属性的值。
            //2.末页li
            var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));//$(selector).attr(attribute,value)attribute	规定属性的名称   value	规定属性的值。
            //3.前一页li
            var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));
            //4.后一页li
            var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));



            if(result.extend.pageInfo.hasPreviousPage==false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");

            }else{
                firstPageLi.click(function () {
                    toPage(-1);//利用了pageHelper的参数合理化

                })
                prePageLi.click(function () {
                    toPage(result.extend.pageInfo.pageNum-1);

                })
            }
            if(result.extend.pageInfo.hasNextPage==false){
                lastPageLi.addClass("disabled");
                nextPageLi.addClass("disabled");
            }else{
                lastPageLi.click(function () {
                    toPage(result.extend.pageInfo.total);//利用了pageHelper的参数合理化

                })
                nextPageLi.click(function () {
                    toPage(result.extend.pageInfo.pageNum+1);

                })
            }
            ul.append(firstPageLi).append(prePageLi);//添加首页和前一页
            //5.第某页li[navigatepageNums中存放的是当前显示的页码，从前到后共五项，个数有controller种pageHelper参数决定]
            $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {

                var numLi= $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
                if(result.extend.pageInfo.pageNum==item){//当前页添加活跃属性
                    numLi.addClass("active");
                }
                //绑定单击事件：这个地方是一个重点
                numLi.click(function () {
                    toPage(item);
                });
                ul.append(numLi);//遍历添加页码号
            })
            ul.append(nextPageLi).append(lastPageLi);//添加后一页以及末页

            var navEle=$("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav");//添加到导航条的id中。


        }
        function toPage(pn) {
            $("#check_all").attr("checked",false);//确保每次页面刷新后，全选框的状态都在未选中的情况
            $.ajax({
                url:"${APP_PATH}/emps",
                data:"pn="+pn,
                type:"GET",
                success:function (result) {//成功的回调函数，result就是返回的数据
                    //1.解析并显示员工数据(抽取成方法)
                    build_emps_table(result);
                    //2.解析并解析分页信息(抽取成方法)
                    build_page_info(result)
                    //3.解析并解析分页条(抽取成方法)
                    build_page_nav(result)
                }
            })
        }

        //表单重置方法
        function reset_form(element) {
            $(element)[0].reset();
            //清空表单样式
            $(element).find("*").removeClass("has-success has-error");
            $(element).find(".help-block").text("");
            $(element+" select").empty();
        }

        //添加新增按钮绑定单击事件，弹出模态框
        $("#emp_add_modal_btn").click(function () {
            //0.清除表单数据(表单重置)
            reset_form("#empAddModal form");
            //1.发送ajax请求查询部门信息，将部门信息添加到下拉列表中
            getDepts("#dept_add_select");

            //2.弹出模态框
            $("#empAddModal").modal({//按钮点击后触发模态框显示，下面是设置模态框相关参数
                backdrop:"static"//背景消除：否
            });
        });
        //获得部门信息，并显示
        function getDepts(ele) {
            $.ajax({
                url:"${APP_PATH}/depts",
                type: "GET",
                success:function (result) {
                    //显示所有部门名称
                    $.each(result.extend.depts,function () {
                        var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId);//注意这里的概念：我们下拉列表显示的是开发部，但是实际上传递的值是value:部门ID号。
                        optionEle.appendTo(ele);
                    });


                }
            });

        }
        /*********************************校验1：jQurey+正则表达式校验用户名和邮箱是否符合规范*****************************/
        //校验方法：校验表单数据:改进：实现焦点判断
        $("#empName_input").blur(function () {
            var empName=$("#empName_input").val();//获得表单中填写姓名那一栏填写的值
            isempNameREPEATandStandard(empName);//判断是否出现重复名字，出现就结束这个地方，防止出现失去焦点将名字重复的判断给覆盖掉
        })
        $("#email_add_input").blur(function () {
            //2.校验邮箱信息
            var email=$("#email_add_input").val();//拿到email值
            var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;//邮箱的正则表达式
            if(!regEmail.test(email)){
                //alert("邮箱格式不正确");
                show_validate_msg("#email_add_input","error","邮箱格式错误");
                email_flag=false;
            }else{
                show_validate_msg("#email_add_input","success","");
                email_flag=true;
            }
        })

        $("#email_update_input").blur(function () {
            //2.校验邮箱信息
            var email=$("#email_update_input").val();//拿到email值
            var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;//邮箱的正则表达式
            if(!regEmail.test(email)){
                //alert("邮箱格式不正确");
                show_validate_msg("#email_update_input","error","邮箱格式错误");
                email_update_flag=false;
                return false;
            }else{
                show_validate_msg("#email_update_input","success","");
                email_update_flag=true;
            }
        })
            //为保存按钮绑定单击事件
            $("#emp_save_btn").click(function () {
                //1.将模态框中填写的表单数据提交给服务器进行保存
              /*  if(email_flag==false|empName_flag==false){
                    return false;
                }*/
                //2.发送ajax请求，保存员工
                $.ajax({
                    url:"${APP_PATH}/emp",
                    type:"POST",
                    data:$("#empAddModal form").serialize(),//到了controller自动封装成Employee对象
                    success:function (result) {
                        //员工保存失败(JSR303校验失败)
                        if(result.code==200){
                            //显示失败信息
                           // console.log(result);
                            if(undefined!=result.extend.errorFields.empName){
                                //显示员工姓名错误信息
                                show_validate_msg("#empName_input","error",result.extend.errorFields.empName)
                            }else if(undefined!=result.extend.errorFields.email){
                                //显示员工邮箱错误信息
                                show_validate_msg("#email_add_input","error",result.extend.errorFields.email)
                            }
                        }
                        //员工保存成功：
                        if(result.code==100){
                            //1.关闭模态框
                            $("#empAddModal").modal("hide");//关闭模态框提供的方法
                            alert(result.msg);
                            //2.来到最后一页，显示刚才保存的数据:发送ajax请求（这里利用了参数合理化属性）
                            toPage(totoalRecord);
                        }

                    }
                })
            });

        //校验状态变化抽取成的函数
        function show_validate_msg(element,status,msg) {
            //每次处理之前都应该先把当前的样式给清空
            $(element).parent().removeClass("has-success has-error");
            $(element).next("span").text("");
            if(status=="success"){
                $(element).parent().addClass("has-"+status);//这个是bootstrap提供的CSS样式，给相应的空间的氟元素提供has-error等属性就可以实现美观的校验信息表示。【详见bootstrap】
                $(element).next("span").text(msg);//找到对应的span标签添加文本值，bootstrap将span同输入框设置为同样的像是，同时变色。
            }else if(status=="error"){
                $(element).parent().addClass("has-"+status);//这个是bootstrap提供的CSS样式，给相应的空间的氟元素提供has-error等属性就可以实现美观的校验信息表示。【详见bootstrap】
                $(element).next("span").text(msg);//找到对应的span标签添加文本值，bootstrap将span同输入框设置为同样的像是，同时变色。
            }
        }
        /****************************校验2：ajax请求校验用户名是否重复**********************************/
        function isempNameREPEATandStandard (empName) {
            //发送ajax请求，校验用户名是否重复
            $.ajax({
                url:"${APP_PATH}/checkUser",
                data:"empName="+empName,
                type:"POST",
                success:function (result) {
                    if(result.code==100){
                        //1.拿到校验的数据，使用正则表达式校验
                        var regName=/(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})/;//正则表达式校验姓名
                        if(!regName.test(empName)){;//测试用户名是否满足正则表达式的规定
                            show_validate_msg("#empName_input","error","用户名格式错误");
                            empName_flag=false;
                        }else{
                            show_validate_msg("#empName_input","success","用户名可用");
                            empName_flag=true;
                        }
                    }else{
                        show_validate_msg("#empName_input","error","用户名已存在")
                        empName_flag=false;
                        return false;
                    }
                }
            });
        }

        /**************************************修改部分*************************************************/
                          /********************** 1.编辑的单击事件绑定 ******************************/
        //1.我们是按钮创建之前就绑定了单击事件中，这是绑定不上的
        //1):可以在创建按钮的时候绑定点击事件
        //2):绑定单击事件.live()方法，可以为我们后来添加的新元素绑定单击事件，但是jQurey新版已将方法删除，使用on()方法进行替代
        $(document).on("click",".edit_btn",function () {//给整个文档document绑定单击事件，最后单击事件落到".edit_btn"上，这就是selector参数的含义。
            //0.清除表单数据(表单重置)
            reset_form("#empUpdateModal form");
            //1.查出员工信息，显示员工信息到文本框
            getEmp($(this).attr("edit-id"));//attr只有一个参数的时候是获取属性内容
            //1.2:把员工的id传递给模态框的更新按钮
            $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
            //2.查出部门信息并显示部门列表，
            getDepts("#empUpdateModal select");
            //3.弹出模态框
            $("#empUpdateModal").modal({//按钮点击后触发模态框显示，下面是设置模态框相关参数
                backdrop:"static"//背景消除：否
            });
        })


        function getEmp(id) {
            $.ajax({
                url:"${APP_PATH}/emp/"+id,
                type:"GET",
                success:function (result) {
                var empEle=result.extend.emp;
                $("#empName_update_static").text(empEle.empName);
                $("#email_update_input").val(empEle.email);
                $("#empUpdateModal input[name=gender]").val([empEle.gender]);//单元框赋值
                $("#empUpdateModal select").val([empEle.dId]);//下拉列表幅值
                }
            })

        }

        /********************** 2.更新按钮的单击事件绑定 ******************************/
        $("#emp_update_btn").click(function () {
            //验证邮箱是否合法:前面youblur()
            //2.发送ajax请求，保存更新的员工数据
            if(email_update_flag==true){
                $.ajax({
                    url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
                    type:"PUT",
                    data:$("#empUpdateModal form").serialize(),//到了controller自动封装成Employee对象,
                    success:function (result) {
                        //1.关闭模态框
                        $("#empUpdateModal").modal("hide");//关闭模态框提供的方法
                        alert(result.msg);
                        //2.来到更改的这一页
                        toPage(currentPage);
                    }
                })
            }
        })
        /********************** 3.删除按钮的单击事件绑定 ******************************/
        //1.我们是按钮创建之前就绑定了单击事件中，这是绑定不上的
        //1):可以在创建按钮的时候绑定点击事件
        //2):绑定单击事件.live()方法，可以为我们后来添加的新元素绑定单击事件，但是jQurey新版已将方法删除，使用on()方法进行替代
        $(document).on("click",".del_btn",function () {//给整个文档document绑定单击事件，最后单击事件落到".edit_btn"上，这就是selector参数的含义。
            //0.清除表单数据(表单重置)
            reset_form("#empUpdateModal form");
            //1.弹出是否确认删除对话框
           var empName= $(this).parents("tr").find("td:eq(2)").text();//查找删除的姓名，是利用前端标签之间的父子关系查找的，
           var empId= $(this).attr("edit-id");//1.2:把员工的id传递给请求

            if(confirm("确认删除【"+empName+"】吗？")){
                $.ajax({
                    url:"${APP_PATH}/emp/"+empId,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        //2.来到更改的这一页
                        toPage(currentPage);

                    }
                })
            }

        })
        /********************** 4.表格头的选择框实现全选操作 ******************************/
        $("#check_all").click(function () {
            //alert($(this).prop("checked"));//checked属性可以用来判断选择框是否被选中
            $(".check_item").attr("checked",$(this).prop("checked"))//prop用来获取原生属性，attr用来获取自定义属性,利用该句话巧妙的是的全选全不选被实现

        });
        $(document).on("click",".check_item",function () {
            //判断选择的元素是与全部选择框数目相同
            var flag=$(".check_item:checked").length==$(".check_item").length//;//获取选择框被选中的个数，判断与全部选择框的数目是否相同，从而确定全选框是否应该被选中
                $("#check_all").prop("checked",flag);
        })
        /********************** 4.顶部删除选项的单击事件绑定 ******************************/
        $("#emp_delete_all_btn").click(function () {
            //$(".check_item:checked")//表示被选中的选择框
            var empNames="";
            var del_idstr="";
            $.each($(".check_item:checked"),function () {
                 empNames  += $(this).parents("tr").find("td:eq(2)").text()+",";
                 del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
            });
            //去除empNames末尾多余的逗号
            empNames = empNames.substring(0,empNames.length-1);
            del_idstr=del_idstr.substring(0,del_idstr.length-1);
            if(confirm("确认删除【"+empNames+"】吗?")){
                $.ajax({
                    url:"${APP_PATH}/emp/"+del_idstr,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        //2.来到更改的这一页
                        toPage(currentPage);
                    }
                })
            }
        })
    </script>
</div>

</body>
</html>
