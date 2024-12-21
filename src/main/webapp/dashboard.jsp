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

        /* Popular Section Styles */
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
            scrollbar-width: none;
        }

        .popular-container::-webkit-scrollbar {
            display: none;
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
            margin-bottom: 1rem;
        }

        /* Product Actions Styles */
        .product-actions {
            margin-top: 1rem;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            background: #f5f5f5;
            padding: 0.3rem;
            border-radius: 4px;
        }

        .qty-btn {
            background: #000;
            color: white;
            border: none;
            width: 25px;
            height: 25px;
            border-radius: 4px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background-color 0.3s ease;
        }

        .qty-btn:hover {
            background: #333;
        }

        .qty-input {
            width: 40px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 0.2rem;
        }

        .add-to-cart-btn {
            background: #2ecc71;
            color: white;
            border: none;
            padding: 0.8rem;
            border-radius: 4px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            transition: background-color 0.3s ease;
        }

        .add-to-cart-btn:hover {
            background: #27ae60;
        }