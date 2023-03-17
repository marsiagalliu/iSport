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
<div class="navbar" style="background-color: #e3f2fd;">
    <a style="color: black" href="/dashboard">Home</a>
    <a href="/event/new">New</a>
    <a href="/search">Search</a>
    <a href="/users/${user.id}">Account</a>
</div>
<h1 style="margin-top: 50px; margin-bottom: 50px">Welcome,<span style="color: darkgreen">${user.firstName}!</span> </h1>
<div class="table-wrapper-scroll-y my-custom-scrollbar">
    <table class="table table-bordered table-striped mb-0">
        <thead>
        <tr>
            <th scope="col">Event Name</th>
            <th scope="col">Location Name</th>
            <th scope="col">Attendees</th>
            <th scope="col">Date</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="event" items="${event}">
            <tr>
                <td> <a href="event/${event.id}"><c:out value="${event.eventName}"></c:out> </a> </td>
                <td> <c:out value="${event.eventLocation}"></c:out> </td>
                <td> <c:out value="${event.attendees.size()} / ${event.maxAttendees}"></c:out> </td>
                <td><fmt:formatDate value="${event.date}" type="date" pattern="dd/MM/yyyy hhaa"
                                    dateStyle="long" />  </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>