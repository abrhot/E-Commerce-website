
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


