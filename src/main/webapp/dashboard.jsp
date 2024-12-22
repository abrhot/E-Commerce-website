<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.genuine.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if(user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Genuine - Electronics Store</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="components/styles/common.css">
    <link rel="stylesheet" href="components/styles/navbar.css">
    <link rel="stylesheet" href="components/styles/search.css">
    <link rel="stylesheet" href="components/styles/cart.css">
    <link rel="stylesheet" href="components/styles/popular.css">
</head>
<body>
    <jsp:include page="components/navbar.jsp" />
    <jsp:include page="components/search.jsp" />
    <jsp:include page="components/cart.jsp" />

    <div class="main-content cart-closed">
        <jsp:include page="components/popular.jsp" />
    </div>

    <script src="js/cart.js"></script>
    <script src="js/popular.js"></script>


    <!-- Include the category products section -->
    <jsp:include page="components/category-products.jsp" />
</body>
</html>