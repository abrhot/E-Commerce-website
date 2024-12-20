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

        /* Floating Cart */
        .cart-container {
            position: fixed;
            left: 10px;
            top: 80px;
            width: 300px;
            background-color: var(--secondary-color);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            padding: 1rem;
            border-radius: 8px;
            z-index: 999;
        }

        .cart-title {
            font-size: 1.2rem;
            margin-bottom: 1rem;
            color: var(--primary-color);
        }

        .cart-items {
            list-style: none;
            max-height: 300px;
            overflow-y: auto;
            padding: 0;
            margin: 0;
        }

        .cart-items li {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
        }

        .cart-item-name {
            font-size: 1rem;
        }

        .cart-item-remove {
            color: red;
            cursor: pointer;
        }

        /* Categories Section */
        .categories-section {
            padding: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .category-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
        }

        .category-card {
            background-color: var(--secondary-color);
            border: 1px solid #eee;
            border-radius: 8px;
            padding: 1rem;
            text-align: center;
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .category-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .category-name {
            font-size: 1.1rem;
            color: var(--primary-color);
        }

        /* Products Section */
        .products-section {
            padding: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1rem;
        }

        .product-item {
            background-color: #f5f5f5;
            padding: 1rem;
            border-radius: 8px;
            text-align: center;
        }

        .product-name {
            margin-bottom: 1rem;
        }

        .add-to-cart {
            background-color: var(--primary-color);
            color: var(--secondary-color);
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .add-to-cart:hover {
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
            </div>
        </div>
    </nav>

    <!-- Floating Cart -->
    <div class="cart-container">
        <div class="cart-title">Your Cart</div>
        <ul class="cart-items"></ul>
    </div>

    <!-- Categories Section -->
    <section class="categories-section">
        <h2>Product Categories</h2>
        <div class="category-grid">
            <div class="category-card" data-category="All">All Products</div>
            <div class="category-card" data-category="Mobile Phones">Mobile Phones</div>
            <div class="category-card" data-category="Laptops">Laptops</div>
        </div>
    </section>

    <!-- Products Section -->
    <section class="products-section">
        <h2>Products</h2>
        <div class="product-grid">
            <div class="product-item" data-category="Mobile Phones">
                <div class="product-name">iPhone</div>
                <button class="add-to-cart">Add to Cart</button>
            </div>
        </div>
    </section>

    <script>
        const cartItems = document.querySelector('.cart-items');

        document.querySelectorAll('.add-to-cart').forEach(button => {
            button.addEventListener('click', () => {
                const item = button.closest('.product-item').querySelector('.product-name').textContent;
                const listItem = document.createElement('li');
                listItem.innerHTML = `<span class="cart-item-name">${item}</span> <span class="cart-item-remove">Remove</span>`;
                cartItems.appendChild(listItem);
            });
        });

        document.querySelector('.cart-container').addEventListener('click', e => {
            if (e.target.classList.contains('cart-item-remove')) {
                e.target.closest('li').remove();
            }
        });
    </script>
</body>
</html>
