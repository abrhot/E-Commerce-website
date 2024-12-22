<%@ page import="com.genuine.model.Product" %>
<%@ page import="com.genuine.dao.ProductDAO" %>
<%@ page import="java.util.List" %>
<%
    ProductDAO productDAO = new ProductDAO();
    List<Product> popularProducts = productDAO.getRandomProducts(10);
%>
<section class="popular-section">
    <h2 class="section-title">Popular Products</h2>
    <div class="popular-container">
        <div class="popular-grid">
            <% if (popularProducts.isEmpty()) { %>
                <div class="popular-item">No products available</div>
            <% } else {
                for (Product product : popularProducts) { %>
                    <div class="popular-item">
                        <img src="<%= product.getImagePath() %>" alt="<%= product.getName() %>" class="product-image">
                        <div class="product-name"><%= product.getName() %></div>
                        <div class="product-category"><%= product.getCategory() %></div>
                        <div class="product-company"><%= product.getCompany() %></div>
                        <div class="product-price">$<%= String.format("%.2f", product.getPrice()) %></div>
                    </div>
                <% }
            } %>
        </div>
    </div>
</section>