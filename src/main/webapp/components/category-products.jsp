<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.genuine.dao.ProductDAO"%>
<%@ page import="com.genuine.model.Product"%>
<%@ page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Add this section where you want to display category-wise products in your existing dashboard -->

<style>
    .category-section {
        margin: 20px 0;
    }

    .category-title {
        font-size: 24px;
        margin-bottom: 15px;
        color: #333;
    }

    .products-container {
        overflow-x: auto;
        white-space: nowrap;
        padding: 10px 0;
    }

    .product-card {
        display: inline-block;
        width: 250px;
        margin-right: 15px;
        vertical-align: top;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        padding: 15px;
        white-space: normal;
    }

    .product-image {
        width: 100%;
        height: 200px;
        object-fit: cover;
        border-radius: 4px;
    }

    .product-details {
        margin-top: 10px;
    }

    .product-name {
        font-weight: bold;
        margin: 5px 0;
    }

    .product-company {
        color: #666;
        font-size: 0.9em;
    }

    .product-price {
        color: #2ecc71;
        font-weight: bold;
        margin: 5px 0;
    }

    .quantity-controls {
        display: flex;
        align-items: center;
        margin: 10px 0;
    }

    .qty-btn {
        padding: 5px 10px;
        border: none;
        background: #f1f1f1;
        cursor: pointer;
    }

    .qty-input {
        width: 40px;
        text-align: center;
        margin: 0 10px;
    }

    .add-to-cart-btn {
        width: 100%;
        padding: 8px;
        background: #3498db;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    .add-to-cart-btn:hover {
        background: #2980b9;
    }
</style>

<%
    ProductDAO productDAO = new ProductDAO();
    String[] categories = {"mobile", "pc & laptop", "watch", "headset", "tv"};

    for(String category : categories) {
        List<Product> products = productDAO.getProductsByCategory(category);
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

<% } %>

<script>
function decreaseQty(productId) {
    const input = document.getElementById(`qty-${productId}`);
    if(input.value > 1) {
        input.value = parseInt(input.value) - 1;
    }
}

function increaseQty(productId) {
    const input = document.getElementById(`qty-${productId}`);
    if(input.value < 10) {
        input.value = parseInt(input.value) + 1;
    }
}

function addToCart(productId) {
    const qty = document.getElementById(`qty-${productId}`).value;
    // Add your cart functionality here
    // You can make an AJAX call to your server to add the item to cart
    console.log(`Adding product ${productId} with quantity ${qty} to cart`);
}
</script>