/*
package com.atguigu.crud.controller;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

*/
/**
 * 处理员工增删改查请求的java文件
 *//*

@Controller
public class EmployeeController_非ajax查询_只适用于BS {

    @Autowired//自动装配service曾业务组件
    EmployeeService employeeService;

    */
/**
     * 查询员工数据：分页查询
     * @return
     *//*

    @RequestMapping("/emps")
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
*/
