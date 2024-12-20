<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Search Results - Genuine Electronics</title>
    <!-- Include your CSS -->
</head>
<body>
    <!-- Include navigation -->

    <div class="search-results">
        <h2>Search Results</h2>
        <div class="products-grid">
            <c:forEach items="${searchResults}" var="product">
                <div class="product-card">
                    <img src="${product.imagePath}" alt="${product.name}">
                    <h3>${product.name}</h3>
                    <p>${product.company}</p>
                    <p class="price">$${product.price}</p>
                    <button onclick="viewProduct(${product.productId})">View Details</button>
                </div>
            </c:forEach>
        </div>
    </div>

    <script>
        function viewProduct(productId) {
            window.location.href = 'product?id=' + productId;
        }
    </script>
</body>
</html>