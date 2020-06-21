package com.chentf.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chentf.crud.bean.Department;
import com.chentf.crud.dao.DepartmentMapper;

@Service
public class DeptmentService {
	
	@Autowired
	private DepartmentMapper departmentMapper;

	public List<Department> getDepts(){
		List<Department> list = departmentMapper.selectByExample(null);
		return list;
	}

}
