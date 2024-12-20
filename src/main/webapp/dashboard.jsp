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
    <style>
        /* Previous styles remain... */

        /* Shopping Cart Styles */
        .cart-container {
            position: fixed;
            top: 80px;
            right: -300px;
            width: 300px;
            height: calc(100vh - 80px);
            background-color: var(--secondary-color);
            box-shadow: -2px 0 5px rgba(0,0,0,0.1);
            transition: right 0.3s ease;
            z-index: 999;
        }

        .cart-container.active {
            right: 0;
        }

        .cart-header {
            padding: 1rem;
            background-color: var(--primary-color);
            color: var(--secondary-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .cart-items {
            padding: 1rem;
            overflow-y: auto;
            height: calc(100% - 140px);
        }

        .cart-item {
            display: flex;
            padding: 0.5rem;
            border-bottom: 1px solid #eee;
            gap: 1rem;
        }

        .cart-total {
            padding: 1rem;
            border-top: 1px solid #eee;
            position: absolute;
            bottom: 0;
            width: 100%;
            background-color: var(--secondary-color);
        }

        .cart-toggle {
            position: fixed;
            top: 90px;
            right: 20px;
            background-color: var(--primary-color);
            color: var(--secondary-color);
            padding: 0.5rem;
            border-radius: 50%;
            cursor: pointer;
            z-index: 1000;
        }

        /* Product View Styles */
        .view-controls {
            display: flex;
            gap: 1rem;
            padding: 1rem 2rem;
            background-color: #f5f5f5;
            margin-bottom: 1rem;
        }

        .view-button {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            background-color: var(--secondary-color);
        }

        .view-button.active {
            background-color: var(--primary-color);
            color: var(--secondary-color);
        }

        .product-section {
            padding: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .product-category {
            margin-bottom: 2rem;
        }

        .product-list {
            display: flex;
            overflow-x: auto;
            gap: 1rem;
            padding: 1rem 0;
            scrollbar-width: thin;
        }

        .product-card {
            min-width: 250px;
            background-color: var(--secondary-color);
            border: 1px solid #eee;
            border-radius: 8px;
            padding: 1rem;
            cursor: pointer;
            transition: transform 0.3s ease;
        }

        .product-card:hover {
            transform: translateY(-5px);
        }

        .product-image {
            height: 150px;
            background-color: #f5f5f5;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .product-details {
            text-align: center;
        }

        .add-to-cart {
            background-color: var(--primary-color);
            color: var(--secondary-color);
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 0.5rem;
        }
    </style>
</head>
<body>
    <!-- Previous navigation and search bar code remains... -->

    <!-- Cart Toggle Button -->
    <div class="cart-toggle">
        <i class="fas fa-shopping-cart"></i>
    </div>

    <!-- Shopping Cart -->
    <div class="cart-container">
        <div class="cart-header">
            <h3>Shopping Cart</h3>
            <i class="fas fa-times" id="close-cart"></i>
        </div>
        <div class="cart-items">
            <!-- Cart items will be dynamically added here -->
        </div>
        <div class="cart-total">
            <p>Total: $0.00</p>
            <button class="checkout-button">Checkout</button>
        </div>
    </div>

    <!-- View Controls -->
    <div class="view-controls">
        <button class="view-button active" data-view="all">All Products</button>
        <button class="view-button" data-view="classified">Classified View</button>
    </div>

    <!-- Product Section -->
    <section class="product-section">
        <div id="all-products">
            <!-- All products will be displayed here -->
        </div>

        <div id="classified-products" style="display: none;">
            <div class="product-category">
                <h2>Mobile Phones</h2>
                <div class="product-list">
                    <!-- Mobile phones will be dynamically added here -->
                </div>
            </div>

            <div class="product-category">
                <h2>Laptops & PCs</h2>
                <div class="product-list">
                    <!-- Laptops and PCs will be dynamically added here -->
                </div>
            </div>

            <!-- Add similar sections for other categories -->
        </div>
    </section>

    <script>
        // Cart functionality
        const cartToggle = document.querySelector('.cart-toggle');
        const cartContainer = document.querySelector('.cart-container');
        const closeCart = document.querySelector('#close-cart');

        cartToggle.addEventListener('click', () => {
            cartContainer.classList.add('active');
        });

        closeCart.addEventListener('click', () => {
            cartContainer.classList.remove('active');
        });

        // View controls
        const viewButtons = document.querySelectorAll('.view-button');
        const allProducts = document.querySelector('#all-products');
        const classifiedProducts = document.querySelector('#classified-products');

        viewButtons.forEach(button => {
            button.addEventListener('click', () => {
                viewButtons.forEach(btn => btn.classList.remove('active'));
                button.classList.add('active');

                const view = button.dataset.view;
                if (view === 'all') {
                    allProducts.style.display = 'block';
                    classifiedProducts.style.display = 'none';
                } else {
                    allProducts.style.display = 'none';
                    classifiedProducts.style.display = 'block';
                }
            });
        });

        // Add to cart functionality
        function addToCart(product) {
            const cartItems = document.querySelector('.cart-items');
            const cartItem = document.createElement('div');
            cartItem.classList.add('cart-item');
            cartItem.innerHTML = `
                <div class="item-details">
                    <h4>${product.name}</h4>
                    <p>$${product.price}</p>
                </div>
                <button class="remove-item">Remove</button>
            `;
            cartItems.appendChild(cartItem);
            updateCartTotal();
        }

        function updateCartTotal() {
            // Add logic to update cart total
        }
    </script>
</body>
</html>