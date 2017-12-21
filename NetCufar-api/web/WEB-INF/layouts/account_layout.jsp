<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>

<html>
<head>
    <title>Title</title>
    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${contextPath}/resources/css/account.css"/>
    <link rel="stylesheet" href="../../resources/css/bootstrap.min.css">
</head>
<body>

<div class="row">
    <div class="col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
        <div class="well profile">
            <div class="col-sm-12">
                <div class="col-xs-12 col-sm-8">
                    <h2>${user.username}</h2>
                    <p><strong><spring:message code="full_name"/>: </strong>${user.fio!=null && !user.fio.equals("") ? user.fio : "--"}</p>
                    <p><strong><spring:message code="from"/>: </strong>${user.city!=null && !user.city.equals("") ? user.city : "--"}</p>
                    <p><strong><spring:message code="email"/>: </strong>${user.email!=null && !user.email.equals("") ? user.email : "--"}</p>
                    <p><strong><spring:message code="telephone_number"/>: </strong>${user.telephone!=null && !user.telephone.equals("") ? user.telephone : "--"}</p>
                    <p><strong><spring:message code="sex"/>: </strong>${user.sex!=null && !user.sex.equals("") ? user.sex : "--"}</p>
                    <p><strong><spring:message code="date_of_birth"/>: </strong>${user.dateOfBirth!=null && !user.dateOfBirth.equals("") ? user.dateOfBirth : "--"}</p>
                    <%--<p><strong><spring:message code="rating"/>: </strong>${user.rating!=null && !user.rating.equals("") ? user.rating : "--"}</p>--%>
                </div>
                <div class="col-xs-12 col-sm-4 text-center">
                    <figure>
                        <img src="${user.photo}" alt="user" class="img-circle img-responsive">
                        <security:authorize access="(hasAnyRole('ROLE_ADMIN','ROLE_USER')) and principal.username != '${user.username}'">
                          <%--<figcaption class="ratings">--%>
                            <%--<p><spring:message code="rating"/></p>--%>
                                <%--<a href="#">--%>
                                    <%--<img src="${contextPath}/resources/img/star.png">--%>
                                <%--</a>--%>
                                <%--<a href="#">--%>
                                    <%--<img src="${contextPath}/resources/img/star.png">--%>
                                <%--</a>--%>
                                <%--<a href="#">--%>
                                    <%--<img src="${contextPath}/resources/img/star.png">--%>
                                <%--</a>--%>
                                <%--<a href="#">--%>
                                    <%--<img src="${contextPath}/resources/img/star.png">--%>
                                <%--</a>--%>
                                <%--<a href="#">--%>
                                    <%--<img src="${contextPath}/resources/img/star.png">--%>
                                <%--</a>--%>
                          <%--</figcaption>--%>
                        </security:authorize>
                    </figure>
                </div>
            </div>
            <div class="col-xs-12 divider text-center">
                <div class="col-xs-8 col-sm-8 emphasis">
                    <h2><strong>${user.userProductList.size()}</strong></h2>
                    <p>
                        <small><spring:message code="ad"/></small>
                    </p>
                    <a href="${contextPath}/catalog/${user.username}" class="btn btn-success btn-block" role="button">
                        <spring:message code="look"/>
                    </a>
                </div>
                <div class="col-xs-4 col-sm-4 emphasis">
                    <security:authorize access="(hasAnyRole('ROLE_ADMIN','ROLE_USER')) and principal.username=='${user.username}'">
                        <form method="post" class="col-xs-12">
                            <sec:csrfInput/>
                            <div class="col-xs-6 product-icons">
                                <a href="${contextPath}/feedback" class="icon">
                                    <img src="${contextPath}/resources/img/feedback_button.png">
                                </a>
                            </div>
                            <div class="col-xs-6 product-icons">
                                <a href="${contextPath}/profiles" class="icon">
                                    <img src="${contextPath}/resources/img/pencil.png">
                                </a>
                            </div>
                        </form>
                    </security:authorize>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>