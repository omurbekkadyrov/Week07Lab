<%-- 
    Document   : notes
    Created on : Oct 26, 2018, 5:35:48 PM
    Author     : 759388
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Notes</title>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <h1>Manage Notes</h1>
                <h2>Notes</h2>
                
                <c:if test="${erroMessage}">
                    <div class="alert alert-danger" role="alert">${errorMessage}</div>
                </c:if>
                
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Date Created</th>
                            <th>Contents</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="note" items="${notes}">
                            <tr>
                                <td>${note.noteId}</td>
                                <td>${note.dateCreated}</td>
                                <td>${note.contents}</td>
                                <td>
                                    <a href="notes?action=view&note=${note.noteId}"><span class="glyphicon glyphicon-pencil"></span></a>
                                    <a href="notes?action=delete&note=${note.noteId}"><span class="glyphicon glyphicon-remove"></span></a>
                                    
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                  
                </table>
            </div>
            
            <div class="row">
                <div class="col-md-12">
                    <c:choose>
                        <c:when test="${selectedNote == null}">
                            <h2>Add Note</h2>
                            <form action="notes" method="POST">
                                <input type="hidden" name="action" value="add">
                                
                                <div class="form-group">
                                    <label for="dateCreated">Date Created</label>
                                    <input type="date" class="form-control" id="dateCreated" name="dateCreated" value="${currentDate}">
                                </div>
                                <div class="form-group">
                                    <label for="contents">Contents</label>
                                    <textarea class="form-control" id="contents" name="contents"><c:out value="${selectedNote.contents}" /></textarea>
                                </div>
                                
                                <button type="submit" class="btn btn-default">Add</button>
                            </form>
                        </c:when>
                        <c:when test="${selectedNote != null}">
                            <h3>Edit Note</h3>
                            
                            <form action="notes" method="POST">
                                <input type="hidden" name="action" value="edit">
                                
                                <div class="form-group">
                                    <label for="noteId">ID</label>
                                    <input type="number" class="form-control" id="noteId" name="noteId" value="${selectedNote.noteId}" readonly>
                                </div>
                                
                                <div class="form-group">
                                    <label for="dateCreated">Date Created</label>
                                    <input type="date" class="form-control" id="dateCreated" name="dateCreated" value="${selectedNote.dateCreated}">
                                </div>
                                <div class="form-group">
                                    <label for="contents">Contents</label>
                                    <textarea class="form-control" id="contents" name="contents"><c:out value="${selectedNote.contents}" /></textarea>
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
