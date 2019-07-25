<%--
  Created by IntelliJ IDEA.
  User: lingxd
  Date: 2019/7/25
  Time: 14:17
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>SSM集成easyUI实现增删改查</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <link rel="stylesheet" type="text/css" href="/static/jquery-easyui-1.8.2/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="/static/jquery-easyui-1.8.2/themes/icon.css">
    <script type="text/javascript" src="/static/jquery-easyui-1.8.2/jquery.min.js"></script>
    <script type="text/javascript" src="/static/jquery-easyui-1.8.2/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/static/jquery-easyui-1.8.2/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">
        var url;
        function openUserAddDialog() {
            $("#dlg").dialog("open").dialog("setTitle", "添加用户信息");
            url = "${pageContext.request.contextPath}/user/save.do";
        }
        function saveUser() {
            $("#fm").form("submit", {
                url : url,
                onSubmit : function() {
                    if ($("#roleName").combobox("getValue") == "") {
                        $.messager.alert("系统提示", "请选择用户角色！");
                        return false;
                    }
                    return $(this).form("validate");
                },
                success : function(result) {
                    var result = eval('(' + result + ')');
                    if (result.success) {
                        $.messager.alert("系统提示", "保存成功！");
                        resetValue();
                        $("#dlg").dialog("close");
                        $("#dg").datagrid("reload");
                    } else {
                        $.messager.alert("系统提示", "保存失败！");
                        return;
                    }
                }
            });
        }
        function searchUser() {
            $("#dg").datagrid('load', {
                "userName" : $("#s_userName").val(),
                "page":"0",
                "rows":"10"
            });
        }
        function resetValue() {
            $("#userName").val("");
            $("#password").val("");
            $("#trueName").val("");
            $("#email").val("");
            $("#phone").val("");
            $("#roleName").combobox("setValue", "");
        }
        function deleteUser() {
            var selectedRows = $("#dg").datagrid("getSelections");
            if (selectedRows.length == 0) {
                $.messager.alert("系统提示", "请选择要删除的数据！");
                return;
            }
            var strIds = [];
            for ( var i = 0; i < selectedRows.length; i++) {
                strIds.push(selectedRows[i].id);
            }
            var ids = strIds.join(",");
            $.messager.confirm("系统提示", "您确定要删除这<font color=red>"
                + selectedRows.length + "</font>条数据吗？", function(r) {
                if (r) {
                    $.post("${pageContext.request.contextPath}/user/delete.do", {
                        ids : ids
                    }, function(result) {
                        if (result.success) {
                            $.messager.alert("系统提示", "数据已成功删除！");
                            $("#dg").datagrid("reload");
                        } else {
                            $.messager.alert("系统提示", "数据删除失败，请联系系统管理员！");
                        }
                    }, "json");
                }
            });
        }
        function openUserModifyDialog() {
            var selectedRows = $("#dg").datagrid("getSelections");
            if (selectedRows.length != 1) {
                $.messager.alert("系统提示", "请选择一条要编辑的数据！");
                return;
            }
            var row = selectedRows[0];
            $("#dlg").dialog("open").dialog("setTitle", "编辑用户信息");
            $("#fm").form("load", row);
            url = "${pageContext.request.contextPath}/user/save.do?id=" + row.id;
        }
        function closeUserDialog() {
            $('#dlg').dialog("close");
        }
    </script>
</head>

<body style="margin: 1px">
<table id="dg" title="用户管理" class="easyui-datagrid" fitColumns="true"
       pagination="true" rownumbers="true"
       url="/user/list.do" fit="true"
       toolbar="#tb">
    <thead>
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <th field="id" width="50" align="center">编号</th>
        <th field="userName" width="50" align="center">用户名</th>
        <th field="password" width="50" align="center">密码</th>
        <th field="trueName" width="50" align="center">真实姓名</th>
        <th field="email" width="50" align="center">邮件</th>
        <th field="phone" width="50" align="center">联系电话</th>
        <th field="roleName" width="50" align="center">角色</th>
    </tr>
    </thead>
</table>
<div id="tb">
    <a href="javascript:openUserAddDialog()" class="easyui-linkbutton"
       iconCls="icon-add" plain="true">添加</a> <a
        href="javascript:openUserModifyDialog()" class="easyui-linkbutton"
        iconCls="icon-edit" plain="true">修改</a> <a
        href="javascript:deleteUser()" class="easyui-linkbutton"
        iconCls="icon-remove" plain="true">删除</a>
    <div>
        用户名： <input type="text" id="s_userName" size="20"
                    onkeydown="if(event.keyCode == 13)searchUser()" /> <a
            href="javascript:searchUser()" class="easyui-linkbutton"
            iconCls="icon-search" plain="true">查询</a>
    </div>
    <div id="dlg-buttons">
        <a href="javascript:saveUser()" class="easyui-linkbutton"
           iconCls="icon-ok">保存</a> <a href="javascript:closeUserDialog()"
                                       class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
    </div>
    <div id="dlg" class="easyui-dialog"
         style="width: 730px;height:280px;padding:10px 10px;" closed="true"
         buttons="#dlg-buttons">
        <form method="post" id="fm">
            <table cellspacing="8px;">
                <tr>
                    <td>用户名：</td>
                    <td><input type="text" id="userName" name="userName"
                               class="easyui-validatebox" required="true" /> <span
                            style="color: red">*</span>
                    </td>
                    <td>	</td>
                    <td>密码：</td>
                    <td><input type="password" id="password" name="password"
                               class="easyui-validatebox" required="true" /> <span
                            style="color: red">*</span>
                    </td>
                </tr>
                <tr>
                    <td>真实姓名：</td>
                    <td><input type="text" id="trueName" name="trueName"
                               class="easyui-validatebox" required="true" /> <span
                            style="color: red">*</span>
                    </td>
                    <td>	</td>
                    <td>邮箱：</td>
                    <td><input type="text" id="email" name="email"
                               validType="email" class="easyui-validatebox" />
                    </td>
                </tr>
                <tr>
                    <td>联系电话：</td>
                    <td><input type="text" id="phone" name="phone"
                               class="easyui-validatebox" required="true" /> <span
                            style="color: red">*</span>
                    </td>
                    <td>	</td>
                    <td>年龄：</td>
                    <td><input type="text" id="age" name="age"
                               class="easyui-validatebox"  />
                    </td>

                </tr>
                <tr>
                    <td>用户角色：</td>
                    <td><select name="roleName" class="easyui-combobox"
                                id="roleName" style="width: 154px;" editable="false"
                                panelHeight="auto">
                        <option value="">请选择角色</option>
                        <option value="admin">系统管理员</option>
                        <option value="sales executive">销售主管</option>
                        <option value="customer manager">客户经理</option>
                        <option value="senior executive">高管</option>
                    </select>  <span style="color: red">*</span>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
</body>
</html>
