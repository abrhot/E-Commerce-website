<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.genuine.model.*" %>
<%@ page import="java.util.List" %>

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
        }

        .section-title {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: var(--primary-color);
        }

        .popular-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .popular-item {
            background-color: #f5f5f5;
            height: 200px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            color: #888;
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

        .category-icon {
            font-size: 2rem;
            margin-bottom: 1rem;
            color: var(--primary-color);
        }

        .category-name {
            font-size: 1.1rem;
            color: var(--primary-color);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .nav-container {
                flex-direction: column;
                gap: 1rem;
            }

            .nav-links {
                flex-wrap: wrap;
                justify-content: center;
            }

            .search-container {
                margin-top: 120px;
            }

            .popular-grid,
            .category-grid {
                grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
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

    <!-- Popular Section -->
    <section class="popular-section">
        <h2 class="section-title">Popular Products</h2>
        <div class="popular-grid">
            <c:forEach items="${popularProducts}" var="product">
                <div class="popular-item">
                    <img src="${product.imagePath}" alt="${product.name}">
                    <h3>${product.name}</h3>
                    <p>${product.company}</p>
                    <p class="price">$${product.price}</p>
                </div>
            </c:forEach>
        </div>
    </section>



   <!-- Categories Section -->
   <section class="categories-section">
       <h2 class="section-title">Product Categories</h2>
       <div class="category-grid">
           <c:forEach items="${categories}" var="category">
               <div class="category-card" data-category="${category}">
                   <div class="category-icon">
                       <i class="fas ${getCategoryIcon(category)}"></i>
                   </div>
                   <div class="category-name">${category}</div>
                   <div class="category-products">
                       <c:forEach items="${categoryProducts[category]}" var="product">
                           <div class="product-card">
                               <img src="${product.imagePath}" alt="${product.name}">
                               <h4>${product.name}</h4>
                               <p>${product.price}</p>
                           </div>
                       </c:forEach>
                   </div>
               </div>
           </c:forEach>
       </div>
   </section>

    <script>
        // Add click handlers for category cards
        document.querySelectorAll('.category-card').forEach(card => {
                card.addEventListener('click', () => {
                    const category = card.dataset.category;
                    window.location.href = 'products?category=' + category;
                });
            });

        // Add search functionality
        // Update search functionality
            document.querySelector('.search-button').addEventListener('click', () => {
                const searchTerm = document.querySelector('.search-input').value;
                if (searchTerm.trim()) {
                    document.querySelector('form').submit();
                }
            });
    </script>
</body>
</html>