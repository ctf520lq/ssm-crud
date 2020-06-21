package com.chentf.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chentf.crud.bean.Department;
import com.chentf.crud.bean.Msg;
import com.chentf.crud.service.DeptmentService;

/**
 * 处理和部门有关的请求
 * @author Administrator
 *
 */
@Controller
public class DepartmentController {

	@Autowired
	private DeptmentService deptmentService;
	
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts() {
		//查出的所有部门信息
		List<Department>list =  deptmentService.getDepts();
		return Msg.success().add("depts", list);
	}
}
