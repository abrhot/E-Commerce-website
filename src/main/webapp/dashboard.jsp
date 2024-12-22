<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.genuine.model.User" %>
<%@ page import="com.genuine.model.Product" %>
<%@ page import="com.genuine.dao.ProductDAO" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if(user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Get random products
    ProductDAO productDAO = new ProductDAO();
    List<Product> popularProducts = productDAO.getRandomProducts(10);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Genuine - Electronics Store</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        :root {
            --primary-color: #000000;
            --secondary-color: #ffffff;
            --accent-color: #333333;
            --hover-color: #555555;
        }

        body {
            background-color: var(--secondary-color);
        }

        /* Navigation Bar */
        .navbar {
            background-color: var(--primary-color);
            padding: 1rem 2rem;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
        }

        .nav-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
        }

        .logo {
            color: var(--secondary-color);
            font-size: 1.5rem;
            font-weight: bold;
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 2rem;
        }

        .nav-links a {
            color: var(--secondary-color);
            text-decoration: none;
            font-size: 1rem;
            transition: color 0.3s ease;
        }

        .nav-links a:hover {
            color: #cccccc;
        }

        .user-icon {
            font-size: 1.2rem;
        }

        /* Search Bar */
        .search-container {
            margin-top: 80px;
            padding: 1rem 2rem;
            display: flex;
            justify-content: center;
        }

        .search-bar {
            max-width: 600px;
            width: 100%;
            display: flex;
            gap: 0.5rem;
        }

        .search-input {
            flex: 1;
            padding: 0.8rem;
            border: 2px solid var(--primary-color);
            border-radius: 5px;
            font-size: 1rem;
        }

        .search-button {
            padding: 0.8rem 1.5rem;
            background-color: var(--primary-color);
            color: var(--secondary-color);
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .search-button:hover {
            background-color: var(--hover-color);
        }

        /* Popular Section */
        .popular-section {
                padding: 2rem;
                max-width: 1200px;
                margin: 0 auto;
                overflow: hidden;
            }

            .popular-container {
                overflow-x: auto;
                white-space: nowrap;
                padding: 1rem 0;
                -webkit-overflow-scrolling: touch;
                scrollbar-width: none; /* Firefox */
            }

            .popular-container::-webkit-scrollbar {
                display: none; /* Chrome, Safari, Edge */
            }

            .popular-grid {
                display: inline-flex;
                gap: 1.5rem;
                padding: 0.5rem;
            }

            .popular-item {
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                width: 250px;
                padding: 1rem;
                transition: transform 0.3s ease;
                cursor: pointer;
                white-space: normal;
            }

            .popular-item:hover {
                transform: translateY(-5px);
            }

            .product-image {
                width: 100%;
                height: 180px;
                object-fit: cover;
                border-radius: 8px;
                margin-bottom: 1rem;
            }

            .product-name {
                font-size: 1.1rem;
                font-weight: bold;
                margin-bottom: 0.5rem;
                color: var(--primary-color);
            }

            .product-category {
                color: #666;
                font-size: 0.9rem;
                margin-bottom: 0.5rem;
            }

            .product-company {
                color: #888;
                font-size: 0.9rem;
                margin-bottom: 0.5rem;
            }

            .product-price {
                color: #2ecc71;
                font-weight: bold;
                font-size: 1.2rem;
            }



        /* Cart Styles */
            .cart-container {
                position: fixed;
                top: 80px; /* Matches navbar height */
                right: 0;
                width: 350px;
                height: calc(100vh - 80px);
                background-color: #ffffff;
                box-shadow: -2px 0 10px rgba(0,0,0,0.1);
                z-index: 999;
                display: flex;
                flex-direction: column;
                transition: transform 0.3s ease;
                transform: translateX(100%);
            }

            .cart-container.open {
                transform: translateX(0);
            }

            .cart-toggle {
                position: fixed;
                top: 50%;
                right: 350px;
                transform: translateY(-50%);
                background-color: var(--primary-color);
                color: white;
                padding: 1rem 0.5rem;
                border-radius: 8px 0 0 8px;
                cursor: pointer;
                box-shadow: -2px 0 10px rgba(0,0,0,0.1);
                z-index: 1000;
            }

            .cart-header {
                padding: 1rem;
                background-color: var(--primary-color);
                color: white;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .cart-title {
                font-size: 1.2rem;
                font-weight: bold;
            }

            .cart-count {
                background-color: #e74c3c;
                color: white;
                padding: 0.2rem 0.6rem;
                border-radius: 12px;
                font-size: 0.9rem;
            }

            .cart-items {
                flex: 1;
                overflow-y: auto;
                padding: 1rem;
            }

            .cart-item {
                display: flex;
                gap: 1rem;
                padding: 1rem;
                border-bottom: 1px solid #eee;
                animation: slideIn 0.3s ease;
            }

            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateX(20px);
                }
                to {
                    opacity: 1;
                    transform: translateX(0);
                }
            }

            .cart-item-image {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 8px;
            }

            .cart-item-details {
                flex: 1;
            }

            .cart-item-name {
                font-weight: bold;
                margin-bottom: 0.3rem;
            }

            .cart-item-price {
                color: #2ecc71;
                font-weight: bold;
            }

            .cart-item-actions {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                margin-top: 0.5rem;
            }

            .quantity-btn {
                background-color: #f1f1f1;
                border: none;
                padding: 0.2rem 0.5rem;
                border-radius: 4px;
                cursor: pointer;
            }

            .remove-btn {
                color: #e74c3c;
                cursor: pointer;
            }

            .cart-footer {
                padding: 1rem;
                border-top: 1px solid #eee;
                background-color: #f9f9f9;
            }

            .cart-total {
                display: flex;
                justify-content: space-between;
                margin-bottom: 1rem;
                font-weight: bold;
            }

            .checkout-btn {
                width: 100%;
                padding: 1rem;
                background-color: #2ecc71;
                color: white;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-weight: bold;
                transition: background-color 0.3s ease;
            }

            .checkout-btn:hover {
                background-color: #27ae60;
            }

            .empty-cart {
                text-align: center;
                padding: 2rem;
                color: #888;
            }

            .empty-cart i {
                font-size: 3rem;
                margin-bottom: 1rem;
            }

            /* Adjust main content margin */
            .main-content {
                margin-right: 350px; /* Width of cart */
                transition: margin-right 0.3s ease;
            }

            .main-content.cart-closed {
                margin-right: 0;
            }

            /* Responsive Design */
            @media (max-width: 1024px) {
                .cart-container {
                    width: 300px;
                }
                .cart-toggle {
                    right: 300px;
                }
                .main-content {
                    margin-right: 300px;
                }
            }

            @media (max-width: 768px) {
                .cart-container {
                    width: 100%;
                }
                .cart-toggle {
                    right: 0;
                }
                .main-content {
                    margin-right: 0;
                }
            }

    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="nav-container">
            <a href="#" class="logo">Genuine</a>
            <div class="nav-links">
                <a href="#"><i class="fas fa-home"></i> Home</a>
                <a href="#"><i class="fas fa-shopping-bag"></i> Orders</a>
                <a href="#"><i class="fas fa-wallet"></i> Balance</a>
                <a href="#"><i class="fas fa-info-circle"></i> About</a>
                <a href="#" class="user-icon"><i class="fas fa-user-circle"></i></a>
            </div>
        </div>
    </nav>

    <!-- Search Bar -->
    <div class="search-container">
        <div class="search-bar">
            <input type="text" class="search-input" placeholder="Search for products...">
            <button class="search-button"><i class="fas fa-search"></i> Search</button>
        </div>
    </div>

    <!-- Cart Toggle Button -->
    <div class="cart-toggle">
        <i class="fas fa-shopping-cart"></i>
    </div>

    <!-- Cart Container -->
    <div class="cart-container">
        <div class="cart-header">
            <div class="cart-title">Shopping Cart</div>
            <div class="cart-count">0</div>
        </div>
        <div class="cart-items">
            <div class="empty-cart">
                <i class="fas fa-shopping-cart"></i>
                <p>Your cart is empty</p>
            </div>
        </div>
        <div class="cart-footer">
            <div class="cart-total">
                <span>Total:</span>
                <span>$0.00</span>
            </div>
            <button class="checkout-btn">Proceed to Checkout</button>
        </div>
    </div>

    <!-- Wrap all main content in a container -->
    <div class="main-content cart-closed">
        <!-- Previous search-container, popular-section, and categories-section remain here -->
    </div>

    <!-- Popular Section -->
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
    <!-- Include the category products section -->
        <jsp:include page="category-products.jsp" />

    </section>



    <script>


        // Add search functionality
        document.querySelector('.search-button').addEventListener('click', () => {
            const searchTerm = document.querySelector('.search-input').value;
            // Add your search logic here
            console.log(`Searching for: ${searchTerm}`);
        });


        // Auto-scroll for popular products
            const popularContainer = document.querySelector('.popular-container');
            let scrollAmount = 0;
            const scrollSpeed = 1;
            const scrollPause = 3000; // 3 seconds pause at each end
            let scrollDirection = 1;
            let isPaused = false;

            function autoScroll() {
                if (!isPaused) {
                    scrollAmount += scrollSpeed * scrollDirection;
                    popularContainer.scrollLeft = scrollAmount;

                    // Check if reached the end
                    if (scrollAmount >= (popularContainer.scrollWidth - popularContainer.clientWidth)) {
                        isPaused = true;
                        setTimeout(() => {
                            scrollDirection = -1;
                            isPaused = false;
                        }, scrollPause);
                    }
                    // Check if reached the start
                    else if (scrollAmount <= 0) {
                        isPaused = true;
                        setTimeout(() => {
                            scrollDirection = 1;
                            isPaused = false;
                        }, scrollPause);
                    }
                }
                requestAnimationFrame(autoScroll);
            }

            // Start auto-scroll
            autoScroll();

            // Pause auto-scroll on hover
            popularContainer.addEventListener('mouseenter', () => isPaused = true);
            popularContainer.addEventListener('mouseleave', () => isPaused = false);

        // Cart functionality
                const cartToggle = document.querySelector('.cart-toggle');
                const cartContainer = document.querySelector('.cart-container');
                const mainContent = document.querySelector('.main-content');
                let isCartOpen = false;

                cartToggle.addEventListener('click', () => {
                    isCartOpen = !isCartOpen;
                    cartContainer.classList.toggle('open');
                    mainContent.classList.toggle('cart-closed');
                });

                // Sample function to add item to cart
                function addToCart(product) {
                    const cartItems = document.querySelector('.cart-items');

                    // Remove empty cart message if it exists
                    const emptyCart = cartItems.querySelector('.empty-cart');
                    if (emptyCart) {
                        emptyCart.remove();
                    }

                    // Create cart item
                    const cartItem = document.createElement('div');
                    cartItem.className = 'cart-item';
                    cartItem.innerHTML = `
                        <img src="${product.image}" alt="${product.name}" class="cart-item-image">
                        <div class="cart-item-details">
                            <div class="cart-item-name">${product.name}</div>
                            <div class="cart-item-price">$${product.price}</div>
                            <div class="cart-item-actions">
                                <button class="quantity-btn minus">-</button>
                                <span class="quantity">1</span>
                                <button class="quantity-btn plus">+</button>
                                <i class="fas fa-trash remove-btn"></i>
                            </div>
                        </div>
                    `;

                    cartItems.appendChild(cartItem);
                    updateCartCount();
                    updateCartTotal();
                }

                function updateCartCount() {
                    const cartCount = document.querySelector('.cart-count');
                    const itemCount = document.querySelectorAll('.cart-item').length;
                    cartCount.textContent = itemCount;
                }

                function updateCartTotal() {
                    // Add logic to calculate total
                    // This is a placeholder
                    const total = 0.00;
                    document.querySelector('.cart-total span:last-child').textContent = `$${total.toFixed(2)}`;
                }

                // Add click event listeners to popular items
                document.querySelectorAll('.popular-item').forEach(item => {
                    item.addEventListener('click', () => {
                        // Example product data
                        const product = {
                            name: item.querySelector('.product-name').textContent,
                            price: parseFloat(item.querySelector('.product-price').textContent.replace('$', '')),
                            image: item.querySelector('.product-image').src
                        };
                        addToCart(product);
                    });
              });
    </script>
</body>
</html>