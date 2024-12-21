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
        /* Your existing CSS */
        /* ... */
        .popular-item {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            width: 250px;
            padding: 1rem;
            transition: transform 0.3s ease;
            cursor: pointer;
            white-space: normal;
            position: relative; /* Add this line */
        }
        .quantity-input {
            width: 50px;
            margin-right: 10px;
        }
        .add-to-cart-btn {
            background-color: var(--primary-color);
            color: white;
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .add-to-cart-btn:hover {
            background-color: var(--hover-color);
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
                            <input type="number" value="1" min="1" class="quantity-input">
                            <button class="add-to-cart-btn">Add to Cart</button>
                        </div>
                    <% }
                } %>
            </div>
        </div>
    </section>

    <!-- Categories Section -->
    <section class="categories-section">
        <h2 class="section-title">Product Categories</h2>
        <div class="category-grid">
            <div class="category-card">
                <div class="category-icon"><i class="fas fa-mobile-alt"></i></div>
                <div class="category-name">Mobile Phones</div>
            </div>
            <div class="category-card">
                <div class="category-icon"><i class="fas fa-laptop"></i></div>
                <div class="category-name">Laptops & PCs</div>
            </div>
            <div class="category-card">
                <div class="category-icon"><i class="fas fa-watch"></i></div>
                <div class="category-name">Smart Watches</div>
            </div>
            <div class="category-card">
                <div class="category-icon"><i class="fas fa-headphones"></i></div>
                <div class="category-name">Headphones</div>
            </div>
            <div class="category-card">
                <div class="category-icon"><i class="fas fa-ear-listen"></i></div>
                <div class="category-name">Earpods</div>
            </div>
            <div class="category-card">
                <div class="category-icon"><i class="fas fa-tv"></i></div>
                <div class="category-name">TVs</div>
            </div>
        </div>
    </section>

    <script>
        // Add click handlers for category cards
        document.querySelectorAll('.category-card').forEach(card => {
            card.addEventListener('click', () => {
                const category = card.querySelector('.category-name').textContent;
                // Add your category navigation logic here
                console.log(`Navigating to ${category}`);
            });
        });

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

        // Function to add item to cart
        function addToCart(product, quantity) {
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
                    <div class="cart-item-price">$${(product.price * quantity).toFixed(2)}</div>
                    <div class="cart-item-actions">
                        <button class="quantity-btn minus">-</button>
                        <span class="quantity">${quantity}</span>
                        <button class="quantity-btn plus">+</button>
                        <i class="fas fa-trash remove-btn"></i>
                    </div>
                </div>
            `;

            cartItems.appendChild(cartItem);
            updateCartCount();
            updateCartTotal();

            // Add event listeners for quantity buttons and remove button
            cartItem.querySelector('.quantity-btn.minus').addEventListener('click', () => updateQuantity(cartItem, -1));
            cartItem.querySelector('.quantity-btn.plus').addEventListener('click', () => updateQuantity(cartItem, 1));
            cartItem.querySelector('.remove-btn').addEventListener('click', () => removeCartItem(cartItem));
        }

        function updateQuantity(cartItem, change) {
            const quantityElem = cartItem.querySelector('.quantity');
            let quantity = parseInt(quantityElem.textContent) + change;
            if (quantity < 1) quantity = 1;
            quantityElem.textContent = quantity;

            const priceElem = cartItem.querySelector('.cart-item-price');
            const productPrice = parseFloat(cartItem.querySelector('.cart-item-price').textContent.replace('$', ''));
            priceElem.textContent = `$${(productPrice * quantity).toFixed(2)}`;

            updateCartTotal();
        }

        function removeCartItem(cartItem) {
            cartItem.remove();
            updateCartCount();
            updateCartTotal();

            const cartItems = document.querySelector('.cart-items');
            if (cartItems.children.length === 0) {
                cartItems.innerHTML = `
                    <div class="empty-cart">
                        <i class="fas fa-shopping-cart"></i>
                        <p>Your cart is empty</p>
                    </div>
                `;
            }
        }

        function updateCartCount() {
            const cartCount = document.querySelector('.cart-count');
            const itemCount = document.querySelectorAll('.cart-item').length;
            cartCount.textContent = itemCount;
        }

        function updateCartTotal() {
            let total = 0.00;
            document.querySelectorAll('.cart-item').forEach(item => {
                const quantity = parseInt(item.querySelector('.quantity').textContent);
                const price = parseFloat(item.querySelector('.cart-item-price').textContent.replace('$', ''));
                total += price * quantity;
            });
            document.querySelector('.cart-total span:last-child').textContent = `$${total.toFixed(2)}`;
        }

        // Add click event listeners to popular items
        document.querySelectorAll('.popular-item').forEach(item => {
            const addToCartButton = document.createElement('button');
            addToCartButton.textContent = 'Add to Cart';
            addToCartButton.className = 'add-to-cart-btn';

            const quantityInput = document.createElement('input');
            quantityInput.type = 'number';
            quantityInput.value = 1;
            quantityInput.min = 1;
            quantityInput.className = 'quantity-input';

            item.appendChild(quantityInput);
            item.appendChild(addToCartButton);

            addToCartButton.addEventListener('click', () => {
                const product = {
                    name: item.querySelector('.product-name').textContent,
                    price: parseFloat(item.querySelector('.product-price').textContent.replace('$', '')),
                    image: item.querySelector('.product-image').src
                };
                const quantity = parseInt(quantityInput.value);
                addToCart(product, quantity);
            });
        });
    </script>
</body>
</html>