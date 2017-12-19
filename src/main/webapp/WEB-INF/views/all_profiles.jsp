<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content=" width=device-width, initial-scale=1.0">

    <title>Netcufar | Products</title>

</head>

<body>

<%@include file="../layouts/preloader.jsp"%>
<%@include file="../layouts/high_menu_bar.jsp"%>
<link href="${contextPath}/resources/css/catalog.css" rel="stylesheet">
<link rel="stylesheet" href="${contextPath}/resources/css/account.css"/>

<script type="text/JavaScript"
        src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js">
</script>


<form method="post" action="${pageContext.request.contextPath}/all_profiles" commandName="User" acceptCharset="utf-8">
    <div class="container content">
        <div class="col-lg-10 products">
            <c:forEach items="${profiles}" var="profiles">
                <div class="col-sm-10">
                    <div class="well profile">
                        <div class="col-sm-12">
                            <div class="col-xs-12 col-sm-8">
                                <h2>${profiles.username}</h2>
                                <p><strong>ФИО: </strong>${profiles.fio!=null ? profiles.fio : "Не установлено"}</p>
                                <p><strong>Место проживания: </strong>${profiles.city!=null ? profiles.city : "Не установлено"}</p>
                                <p><strong>email: </strong>${profiles.email!=null ? profiles.email : "Не установлено"}</p>
                                <p><strong>Телефон: </strong>${profiles.telephone!=null ? profiles.telephone : "Не установлено"}</p>
                                <p><strong>Пол: </strong>${profiles.sex!=null ? profiles.sex : "Не установлено"}</p>
                                <p><strong>Дата рождения: </strong>${profiles.dateOfBirth!=null ? profiles.dateOfBirth : "Не установлено"}</p>
                                <div class="btn-group">
                                    <c:if test="${profiles.status.equals('BLOCKED')}">
                                        <button name="${profiles.id}" id="status" type="button" class="btn btn-primary btn-accept"><spring:message
                                                code="profileButtonUnblocked"/></button>
                                    </c:if>
                                    <c:if test="${profiles.status.equals('UNBLOCKED')}">
                                        <button name="${profiles.id}"  id="status" type="button" class="btn btn-primary btn-accept" onclick="changeStatus()"><spring:message
                                                code="profileButtonBlocked"/></button>
                                    </c:if>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-4 text-center">
                                <figure>
                                    <div class="wrapper-for-img">
                                        <img src="https://drive.google.com/uc?export=download&confirm=no_antivirus&id=${profiles.photo}"
                                             onerror="this.src='${contextPath}/resources/img/placeholder-image.png'"/>
                                    </div>
                                    <figcaption class="ratings">
                                        <p>Рейтинг
                                            <a href="#">
                                                <span class="fa fa-star"></span>
                                            </a>
                                            <a href="#">
                                                <span class="fa fa-star"></span>
                                            </a>
                                            <a href="#">
                                                <span class="fa fa-star"></span>
                                            </a>
                                            <a href="#">
                                                <span class="fa fa-star"></span>
                                            </a>
                                            <a href="#">
                                                <span class="fa fa-star-o"></span>
                                            </a>
                                        </p>
                                    </figcaption>
                                </figure>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</form>
</body>

