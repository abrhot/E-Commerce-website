<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.genuine.dao.ProductDAO"%>
<%@ page import="com.genuine.model.Product"%>
<%@ page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Main container for category-wise products display -->
<div class="category-products-wrapper">
    <%
        ProductDAO productDAO = new ProductDAO();
        // Updated categories to match your database
        String[] categories = {"Mobile", "pc", "watch", "Headset", "TV"};

        for(String category : categories) {
            List<Product> products = productDAO.getProductsByCategory(category);
            if(products != null && !products.isEmpty()) {
                request.setAttribute("products", products);
                request.setAttribute("category", category);
    %>
    <div class="category-section">
        <h2 class="category-title"><%= category.toUpperCase() %></h2>
        <div class="products-container">
            <c:forEach items="${products}" var="product">
                <div class="product-card">
                    <img src="${product.imagePath}" alt="${product.name}" class="product-image">
                    <div class="product-details">
                        <div class="product-name">${product.name}</div>
                        <div class="product-company">${product.company}</div>
                        <div class="product-price">$${product.price}</div>
                        <div class="quantity-controls">
                            <button class="qty-btn" onclick="decreaseQty(${product.productId})">-</button>
                            <input type="number" id="qty-${product.productId}" class="qty-input" value="1" min="1" max="10">
                            <button class="qty-btn" onclick="increaseQty(${product.productId})">+</button>
                        </div>
                        <button class="add-to-cart-btn" onclick="addToCart(${product.productId})">Add to Cart</button>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <%
            }
        }
    %>
</div>