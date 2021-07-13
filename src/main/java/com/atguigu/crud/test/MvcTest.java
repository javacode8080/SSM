package com.atguigu.crud.test;


import com.atguigu.crud.bean.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.EmptyStackException;
import java.util.List;

/**
 * 使用Spring测试模块提供的测试请求功能，测试crud请求的正确性
 * Spring4测试的时候需要servlet3.0依赖
 */

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:applicationContext.xml","file:D:\\JAVA\\codeLoding\\SSM_CRUD\\src\\main\\webapp\\WEB-INF\\dispatcherServlet-servlet.xml"})//需要引入Spring和SpringMvc两个配置文件的路径
public class MvcTest {
    //传入SpringMVC的ioc
    @Autowired//Autowired只能Autowired ioc容器里面的，而ioc自身如何Autowired(自动装配呢)，需要引入@WebAppConfiguration注解：这一点非常重要
    WebApplicationContext context;
    //虚拟MVC请求，获取到处理结果
    MockMvc mockMvc;
    @Before//每次使用都需要初始化mockMvc，所以使用@Before注解@Before: 前置通知, 在方法执行之前执行
    public void initMockMvc(){
          mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }
    @Test
    public void testPage() throws Exception {
        //模拟请求拿到返回值
        MvcResult pn = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();
        //请求成功之后，请求域中会有pageInfo,可以去除pageInfo进行验证
        MockHttpServletRequest request = pn.getRequest();
        PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
        System.out.println("当前页码："+pageInfo.getPageNum());
        System.out.println("总页码："+pageInfo.getPages());
        System.out.println("总记录数："+pageInfo.getTotal());
        System.out.println("页面需要连续显示的页码：");
        int[] nums=pageInfo.getNavigatepageNums();
        for(int i:nums){
            System.out.println(" "+i);
        }

        //获取员工数据
        List<Employee> list = pageInfo.getList();
        for(Employee e:list){
            System.out.println("ID:"+e.getEmpId()+"==>Name:"+e.getEmpName());
        }
    }
}
