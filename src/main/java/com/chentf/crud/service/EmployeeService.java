package com.chentf.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chentf.crud.bean.Employee;
import com.chentf.crud.bean.EmployeeExample;
import com.chentf.crud.bean.EmployeeExample.Criteria;
import com.chentf.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;
	
	/**
	 * 查询所有员工
	 * @return
	 */
	public List<Employee> getAll() {
		//查询全部不需要传递参数
		return employeeMapper.selectByExampleWithDept(null);
	}

	/**
	 * 员工保存
	 * @param employee
	 */
	public void saveEmp(Employee employee) {
		employeeMapper.insertSelective(employee);
		
	}

	/**
	 * 校验用户名是否可用
	 * @param empName
	 * @return true:代表当前姓名可用,false:不可用
	 */
	public boolean checkUser(String empName) {
		EmployeeExample empExample = new EmployeeExample();
		Criteria criteria = empExample.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(empExample);
		return count == 0;
	}

	/**
	 * 根据员工id查询员工
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}

	/**
	 * 员工更新
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.updateByPrimaryKeySelective(employee);
		
	}
	
	/**
	 * 员工删除
	 * @param id
	 */
	public void deleteEmp(Integer id) {
		// TODO Auto-generated method stub
		employeeMapper.deleteByPrimaryKey(id);
	}

	public void deleteBatch(List<Integer> ids) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		//delete from xxx where emp_id in(1,2,3)
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}
	

}
