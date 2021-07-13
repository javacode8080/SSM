package com.atguigu.crud.controller;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.junit.runner.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工增删改查请求的java文件：使用JSON字符串的形式返回数据
 */
@Controller
public class EmployeeController {

    @Autowired//自动装配service曾业务组件
    EmployeeService employeeService;

    /**
     * 单个或者批量删除二合一的方法
     * 批量删除：1-2-3
     * 单个删除1
     */

    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpById(@PathVariable("ids")String ids){
        if(ids.contains("-")){//表示批量删除
            ArrayList<Integer> list = new ArrayList<>();
            String[] strings = ids.split("-");
            for(String s:strings){
                list.add(Integer.valueOf(s));
            }
            employeeService.deleteBatch(list);
        }else{//表示单个删除
            employeeService.deleteEmpById(Integer.valueOf(ids));
        }

        return Msg.success();
    }

    /**
     * 修改员工信息
     *Tomcat:
     * 1.将请求体中的数据封装成一个map，
     * 2.request.getParameter("empName"),就会从map中取值。
     * 3.SpringMVC封装POJO对象的时候会把POJO中每个属性的值调用Request.getParamter("email")
     * ajax发送PUT请求不能直接发，PUT请求请求体中的数据，request.getParameter("empName")拿不到，Tomcat一看是PUT请求就不会封装请求体的数据为MAP，只有POST形式的请求才封装请求体
     */
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee emp, HttpServletRequest request){
        System.out.println(request.getParameter("gender"));
        employeeService.updateEmp(emp);
        return Msg.success();
    }

    /**
     * 查询员工信息
     */

    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee=employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }






    /**
     * 支持JSR303校验
     * 1.导入Hibernate-Validator
     */

    /**
     * 用户名是否可用的方法
     */
    @RequestMapping("/checkUser")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName") String empName){
        boolean b=employeeService.checkUser(empName);
        if(b){
            return Msg.success();
        }else{
            return Msg.fail();
        }
    }


    /**
     * @ResponseBody的使用需要导入jackson包。
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody//该注解可以自动的将返回值封装成JSON字符串
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        //分页查询
        //引入PageHelper实现分页查询
        //查询之前调用，传入页码及每页显示数目
        PageHelper.startPage(pn,5);
        //startPage紧跟着的查询就是分页查询
        List<Employee> emps=employeeService.getAll();
        //使用pageInfo包装查询结果，只需要将PageInfo交给页面即可。
        PageInfo page=new PageInfo(emps,5);//5:表示连续显示的页数是5页
        return Msg.success().add("pageInfo",page);
    }

    /**
     * 员工保存方法
     */
    @RequestMapping(value = "emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){//这里利用了SpringMVC将表单提交的内容自动封装为对象的手段，记住自动封装的注意事项
        if(result.hasErrors()){
            //1.校验失败需要返回失败信息
            Map<String,Object> map=new HashMap<>();
            List<FieldError> list = result.getFieldErrors();
            for(FieldError f:list){
                System.out.println("错误的字段名:"+f.getField());
                System.out.println("错误信息:"+f.getDefaultMessage());
                map.put(f.getField(),f.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else{
            employeeService.saveEmp(employee);
            return Msg.success();
        }

    }





    /**
     * 查询员工数据：分页查询
     * @return
     */
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        //分页查询
        //引入PageHelper实现分页查询
        //查询之前调用，传入页码及每页显示数目
        PageHelper.startPage(pn,5);
        //startPage紧跟着的查询就是分页查询
        List<Employee> emps=employeeService.getAll();
        //使用pageInfo包装查询结果，只需要将PageInfo交给页面即可。
        PageInfo page=new PageInfo(emps,5);//5:表示连续显示的页数是5页
        model.addAttribute("pageInfo",page);
        return "list";//由于存在视图解析器(在dispatcherServlet-servlet.xml中配置)
    }
}
