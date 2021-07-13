package com.atguigu.crud.service;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.EmployeeExample;
import com.atguigu.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired//自动装配Dao曾业务逻辑组件
    EmployeeMapper employeeMapper;


    /**
     * 按照员工id查询员工
     */
    public Employee getEmp(Integer id){
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    /**
     * 检验用户名是否重复
     * true:可用
     */
    public boolean checkUser(String empName){
        EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long l = employeeMapper.countByExample(example);
        return l==0;
    }

    /**
     * 查询所有员工
     * @return
     */
    public List<Employee> getAll(){
        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
     * 员工保存方法
     */
    public void saveEmp(Employee employee){
        employeeMapper.insertSelective(employee);
    }

    /**
     * 员工更新
     * @param emp
     */

    public void updateEmp(Employee emp) {
        employeeMapper.updateByPrimaryKeySelective(emp);
    }

    /**
     * 单个删除
     * @param id
     */
    public void deleteEmpById(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        //这个example表示的sql:delete from xxx where emp_id in (1,2,3...);
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }
}
