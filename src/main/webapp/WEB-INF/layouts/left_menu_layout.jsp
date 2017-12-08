<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>

<body>

    <div class="navbar navbar-left">
        <div class="list-group">
            <c:forEach var="category" items="${productCategory}">
                <a href="#" class="list-group-item" id="${category.title}"> <spring:message code="${category.title}"/></a>

                <%--<c:forEach var="subcategory" items="${sessionScope.categoryJSP.categoryList}">
                    <a href="#" class="list-group-item"> ${subcategory.title}  </a>
                </c:forEach>--%>

            </c:forEach>
        </div>
    </div>

    <script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js">
    </script>

    <script>

        $(document).on('click','.list-group-item',function(event){
            event.preventDefault();
            var supercategory = event.currentTarget.id;
            console.log(supercategory);
            $.ajax({
                url : '/get-products-by-supercategory',
                type: 'GET',
                dataType: 'json',
                contentType: 'application/json',
                data : ({
                    supercategory: supercategory
                }),
                success: function (data) {
                    $('.products').empty();
                    $.each(data, function(id, key){
                        var product = ///// spring:message missing
                                "<div class=\"col-sm-4\">\n" +
                                "   <div class=\"product\">\n" +
                                "       <div class=\"product-img\">\n" +
                                "           <a><img src=\"https://drive.google.com/uc?export=download&confirm=no_antivirus&id=" + key.photo + "\"/></a>\n" +
                                "           <div class=\"product-icons\">\n" +
                                "               <div class=\"product-icons-item\">\n" +
                                "                   <a href=\"#\" class=\"icon\">\n" +
                                "                       <img src=\"${contextPath}/resources/img/heart.png\">\n" +
                                "                   </a>\n" +
                                "               </div>\n" +
                                "           </div>\n" +
                                "       </div>\n" +
                                "       <p class=\"product-title\">\n" +
                                "           <a href=\"${contextPath}/product/" + key.id + "\"><strong>" + key.title + "</strong></a>\n" +
                                "       </p>\n" +
                                "       <p class=\"product-desc\">" + key.description + "</p>\n" +
                                "       <p class=\"product-category\">" + key.category + "</p>\n" +
                                "       <p class=\"product-price\">" + key.cost + "</p>\n" +
                                "   </div>\n" +
                                "</div>";
                        $('.products').append(product);
                    })
                }
            });
            return false;
        });
       /* $(document).ready(function($) {
            $(".list-group-item").click(function(event) {
                event.preventDefault();
                var category = event.currentTarget.id;
                console.log(category);

                /*$.ajax({
                    url : 'getCharNum',
                    type: 'GET',
                    //dataType: 'json',
                    //contentType: 'application/json',
                    data : ({
                        text: category
                    }),
                    success: function (data) {
                        console.log(data);
                        var result = data;
                        $("#result_text").text(result);
                    }
                });

            });
        });*/
    </script>

</body>