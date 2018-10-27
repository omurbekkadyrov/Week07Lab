<%-- 
    Document   : users
    Created on : Oct 26, 2018, 5:42:16 PM
    Author     : 759388
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Users</title>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <h1>Manage Users</h1>
                <h2>Users</h2>
                
                <c:if test="${erroMessage}">
                    <div class="alert alert-danger" role="alert">${errorMessage}</div>
                </c:if>
                
                <table class="table">
                    <thead>
                        <tr>
                            <th>Username</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr>
                                <td>${user.username}</td>
                                <td>${user.firstname}</td>
                                <td>${user.lastname}</td>
                                <td>
                                    <a href="users?action=view&selectedUsername=${user.username}"><span class="glyphicon glyphicon-pencil"></span></a>
                                    <a href="users?action=delete&selectedUsername=${user.username}"><span class="glyphicon glyphicon-remove"></span></a>
                                    
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                  
                </table>
            </div>
            
            <div class="row">
                <div class="col-md-12">
                    <c:choose>
                        <c:when test="${selectedUser == null}">
                            <h2>Add User</h2>
                            <form action="users" method="POST">
                                <input type="hidden" name="action" value="add">
                                
                                <div class="form-group">
                                    <label for="username">Username</label>
                                    <input type="text" class="form-control" id="username" name="username">
                                </div>
                                <div class="form-group">
                                    <label for="firstname">First Name</label>
                                    <input type="text" class="form-control" id="firstname" name="firstname">
                                </div>
                                <div class="form-group">
                                    <label for="lastname">Last Name</label>
                                    <input type="text" class="form-control" id="lastname" name="lastname">
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="password" class="form-control" id="password" name="password">
                                </div>
                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="email" class="form-control" id="email" name="email">
                                </div>
                               <div class="checkbox">
                                    <label>
                                      <input type="checkbox" name="active"> Active
                                    </label>
                                </div>
                                
                                <button type="submit" class="btn btn-default">Add</button>
                            </form>
                        </c:when>
                        <c:when test="${selectedUser != null}">
                            <h3>Edit User</h3>
                            
                            <form action="users" method="POST">
                                <input type="hidden" name="action" value="edit">
                                
                                <div class="form-group">
                                    <label for="username">Username</label>
                                    <input type="text" class="form-control" id="username" name="username" value="${selectedUser.username}" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="firstname">First Name</label>
                                    <input type="text" class="form-control" id="firstname" name="firstname" value="${selectedUser.firstname}">
                                </div>
                                <div class="form-group">
                                    <label for="lastname">Last Name</label>
                                    <input type="text" class="form-control" id="lastname" name="lastname" value="${selectedUser.lastname}">
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="password" class="form-control" id="password" name="password" value="${selectedUser.password}">
                                </div>
                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" value="${selectedUser.email}">
                                </div>
                               <div class="checkbox">
                                    <label>
                                      <input type="checkbox" name="active" <c:if test="${selectedUser.active}">checked</c:if>> Active
                                    </label>
                                </div>
                                
                                <button type="submit" class="btn btn-default">Update</button>
                            </form>
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </div>
    </body>
</html>
