<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <!-- 引入核心标签库 -->
 <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<!-- web路径
		不以/开始的相对路径,找资源,以当前资源的路径为基准,经常容易出问题.
		以/开始的相对路径,找资源,以服务器的路径为标准(http://localhost:3306),需要加上项目名称:http://localhost:3306/crud
 -->
<!-- 引入jquery  -->
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
<!-- 引入样式  -->
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

	<!-- 员工添加的页面 -->
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
					    <label class="col-sm-2 control-label">empName</label>
					    <div class="col-sm-10">
					      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
					      <span class="help-block"></span>
					    </div>
					  </div>
					  <div class="form-group">
					    <label class="col-sm-2 control-label">email</label>
					    <div class="col-sm-10">
					      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="chentf@164.com">
					      <span class="help-block"></span>
					    </div>
					  </div>
					  <div class="form-group">
					    <label class="col-sm-2 control-label">gender</label>
					    <div class="col-sm-10">
					      <label class="radio-inline">
						  	<input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
						  </label>
						  <label class="radio-inline">
						  	<input type="radio" name="gender" id="gender2_add_input" value="F"> 女
						  </label>
					    </div>
					  </div>
					  <div class="form-group">
					    <label class="col-sm-2 control-label">deptName</label>
					    <div class="col-sm-4">
					    <!-- 部门提交部门id即可 -->
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

	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8"">
				<button class="btn btn-primary" id="emp_add_modal">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_tables">
					<thead>
						<tr>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					
					</tbody>
					
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area">
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area">
				
			</div>
		</div>
	</div>
	<script type="text/javascript">
		//定义总记录数	
		var totalRecord;
		//1.页面加载完成后,直接发送一个ajax请求,接收到分页的数据
		$(function(){
			//去首页
			to_page(1);
		});
		
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn="+pn,
				type:"GET",
				success:function(result){
					//console.log(result);
					//1.解析并显示员工的数据
					build_emps_table(result);
					//2.解析并显示分页的数据
					build_page_info(result);
					//3.解析心事分页条数据
					build_page_nav(result);
				}
			});
		}
		
		//1.解析并显示员工的数据
		function build_emps_table(result){
			//清空table表格
			$("#emps_tables tbody").empty();
			//获取json串中的数据
			var emps = result.extend.pageInfo.list;
			//通过jquery遍历方法遍历数据
			$.each(emps,function(index,item){
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);
				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
								.append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
								.append("编辑");
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
								.append($("<span></span>").addClass("glyphicon glyphicon-trash"))
								.append("删除");
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
				$("<tr></tr>").append(empIdTd)
						.append(empNameTd)
						.append(genderTd)
						.append(emailTd)
						.append(deptNameTd)
						.append(btnTd)
						.appendTo("#emps_tables tbody");
			});
		}
		
		//2.解析并显示分页的数据
		function build_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总共"+
						result.extend.pageInfo.pages+"页,总共"+
						result.extend.pageInfo.total+"条记录");
			//将总记录数赋值给全局变量
			totalRecord = result.extend.pageInfo.total;
		}
		
		//3.解析心事分页条数据,点击分页条能去到下一页...
		function build_page_nav(result){
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			//首页
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			//前一页
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			//判断是否有前一页
			if(result.extend.pageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				//为元素添加点击翻页事件
				firstPageLi.click(function(){
					to_page(1);
				});
				prePageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum - 1);
				});
			}
			//后一页
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			//末页
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			//判断是否有后一页
			if(result.extend.pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum + 1);
				});
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
				});
			}
			//添加首页和前一页的提示
			ul.append(firstPageLi).append(prePageLi);
			
			//遍历页码号 1,2,3,4,5,遍历给ul中添加页码号
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if(result.extend.pageInfo.pageNum == item){
					numLi.addClass("active");
				}
				numLi.click(function(){
					to_page(item);
				});
				ul.append(numLi);
			});
			//添加下一页和末页的提示
			ul.append(nextPageLi).append(lastPageLi);
			//把ul添加到nav中
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
						
		}
		
		//清空表单样式及内容
		function reset_form(ele){
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
		//点击新增按钮弹出模态框
		$("#emp_add_modal").click(function(){
			//清除表单数据(表单完整重置,包括表单数据,表单的样式)
			reset_form("#empAddModal form");
			//发送ajax请求,查出部门信息,显示在下拉框列表中
			getDepts();
			//弹出模态框
			$("#empAddModal").modal({
				backdrop:"static"
			});
		});
		
		//查出所有的部门信息并显示在下拉列表中
		function getDepts(){
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					//console.log(result);
					//显示部门信息在下拉列表中
					$.each(result.extend.depts,function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo("#empAddModal select");
					});
				}
			});
		}
		
		//校验表单数据的方法
		function validate_add_form(){
			//1.拿到要检验的数据,使用正则表达式
			//校验用户名
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(empName)){
				//alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
				//$("#empName_add_input").parent().addClass("has-error");
				//$("#empName_add_input").next("span").text("用户名可以是2-5位中文或者6-16位英文和数字的组合");
				show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位英文和数字的组合");
				return false;
			}else{
				//$("#empName_add_input").parent().addClass("has-success");
				//$("#empName_add_input").next("span").text("");
				show_validate_msg("#empName_add_input","success","");
			}
			//2.校验邮箱
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				//应该清空这个元素之前的样式
				//$("#email_add_input").parent().addClass("has-error");
				//$("#email_add_input").next("span").text("邮箱格式不正确");
				show_validate_msg("#email_add_input","error","邮箱格式不正确");
				return false;
			}else{
				//$("#email_add_input").parent().addClass("has-success");
				//$("#email_add_input").next("span").text("");
				show_validate_msg("#email_add_input","success","");
			}
			return true;
		}
		
		//封装校验,显示校验结果的提示信息
		function show_validate_msg(ele,status,msg){
			//清除当前元素的校验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success" == status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		//校验用户名是否可用
		$("#empName_add_input").change(function(){
			//发送ajax请求校验用户名是否可用
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data:"empName="+empName,
				type:"POST",
				success:function(result){
					if(result.code == 100){
						show_validate_msg("#empName_add_input","success","用户名可用");
						$("#emp_save_btn").attr("ajax-va","success");
					}else{
						show_validate_msg("#empName_add_input","error",result.extend.va_msg);
						$("#emp_save_btn").attr("ajax-va","error");
					}
				}
			});
		});
		
		//点击保存,保存员工的方法
		$("#emp_save_btn").click(function(){
			//1.模态框中填写的数据提交给服务器进行保存
			//1.先对要提交到服务器的数据进行校验
			/* if(!validate_add_form()){
				return false;
			} */
			//1.判断之前的ajax用户名校验是否成功,如果成功.
			if($(this).attr("ajax-va") == "error"){
				return false;
			}
			
			//2.发送ajax请求保存员工
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result){
					if(result.code == 100){
						//alert(result.msg);
						//员工保存成功:
						//1.关闭模态框
						$("#empAddModal").modal("hide");
						//2.来到最后一页,显示刚才添加的数据
						//发送ajax请求显示最后一页数据即可
						to_page(totalRecord);
					}else{
						//显示失败信息
						//console.log(result);
						//有那个字段的错误信息就显示那个字段的
						if(undefined != result.extend.errorFields.email){
							//显示邮箱错误信息
							show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
						}
						if(undefined != result.extend.errorFields.empName){
							//显示员工名字的错误信息
							show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
						}
					}
				}
			});
		});
		
	</script>
</body>
</html>