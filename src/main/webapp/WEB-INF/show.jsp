<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!-- c:out ; c:forEach ; c:if -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Formatting (like dates) -->
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
      integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>A Web Page</title>
</head>
<body>
<%--@elvariable id="user" type="java"--%>
<div class="navbar" style="background-color: #e3f2fd;">
    <a href="/dashboard">Home</a>
    <a href="/event/new">New</a>
    <a href="/search">Search</a>
    <a href="/users/${user.id}">Account</a>
</div>
<div style="flex: 1; flex-direction: row">
<div style="display: flex; flex-direction: row;">
    <div class="button-container" style="margin-left: 10px; margin-top: 20px; display: flex; flex-direction: row; width: 500px; height: 300px" >
        <div>
            <p>Title: ${sportEvent.eventName}</p>
            <p>Date: ${sportEvent.date}</p
            <p>Information : ${sportEvent.information}</p>
            <p>${sportEvent.attendees.size()} attendees</p>
        </div>
    </div>
</div>
        <style>
            .button-container {
                display: flex;
                flex-direction: column;
            }

            .info-container{
                border: solid black 1px;
                padding: 10px;
                flex: 1;
            }

            .buttonStyle{
                width: 200px;
                height: 100px;
                margin: 10px;
            }

        </style>
    <img class="image" style="width: 400px; height: 300px; position: absolute; left: 700px; bottom: 480px " src="../img/map.PNG"/>
</div>
<div style="margin: 20px">
    <c:if test="${sportEvent.creator.id == user.id}"><a class="btn btn-dark" href="/event/${sportEvent.id}/edit" >Edit Event</a> </c:if>
    <c:if test="${sportEvent.creator.id == user.id}"><a class="btn btn-dark" href="/event/${sportEvent.id}/delete" >Delete Event</a> </c:if>
</div>
<div class="message">
    <div style="border: solid black 1px; width: 30%; margin: 20px">
        <h4 style="padding: 10px">Messages: </h4>
        <div style="padding: 10px">
            <c:forEach var="message" items="${message}">
                <p>${message.user.firstName} : ${message.message}</p>
            </c:forEach>
        </div>
    </div>
    <%--@elvariable id="newMessage" type="java"--%>
    <form:form action="/event/${sportEvent.id}" method="post" modelAttribute="newMessage">
        <div style="margin: 20px;">
            <form:label path="message">Message: </form:label>
            <form:input path="message" />
            <form:errors path="message" class="text-danger"/>
        </div>
        <button style="margin: 20px;" type="submit" class="btn btn-dark">Submit</button>
    </form:form>
</div>
</body>
</html>