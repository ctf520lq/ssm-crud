package com.chentf.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.chentf.crud.bean.Department;
import com.chentf.crud.bean.Employee;
import com.chentf.crud.dao.DepartmentMapper;
import com.chentf.crud.dao.EmployeeMapper;

/**
 * 测试dao层的工作
 * @author Administrator
 * 推荐使用spring的项目就可以使用spring的单元测试,可以自动注入我们需要的组件
 * 	1.导入springTest模块
 * 	2.@ContextConfiguration指定spring配置文件的位置
 * 	3.直接使用@autowired注入要使用的组件即可
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {

	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void testCRUD() {
		/*	//1、创建SpringIOC容器
		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
		//2、从容器中获取mapper
		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);*/
		//使用注入bean的方式,直接返回org.apache.ibatis.binding.MapperProxy@5495333e代理对象
		//System.out.println(departmentMapper);
		
		//1.插入部门的测试
//		departmentMapper.insertSelective(new Department(1, "开发部"));
//		departmentMapper.insertSelective(new Department(2, "测试部"));
		
		//2.生成员工数据,测试员工插入
//		employeeMapper.insertSelective(new Employee(null, "chentf", "M", "chentf@163.com", 1));
		
		//3.批量插入多个员工,批量,使用可以执行批量操作的sqlSession
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i=0;i<1000;i++) {
			String uid = UUID.randomUUID().toString().substring(0,5)+1;
			mapper.insertSelective(new Employee(null,uid,"M",uid+"@163.com",1));
		}
		System.out.println("批量插入完成!!!");
	}
}
