<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Add Product</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            background-color: #f4f4f4;
        }

        .nav-buttons {
            display: flex;
            justify-content: space-between;
            padding: 15px 30px;
            background-color: #333;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .nav-button {
            padding: 10px 25px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            background-color: #007bff;
            color: white;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .nav-button:hover {
            background-color: #0056b3;
        }

        .user-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #6c757d;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .user-icon:hover {
            background-color: #5a6268;
        }

        .dashboard-container {
            width: 90%;
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0,123,255,0.3);
        }

        .specs-container {
            padding: 20px;
            border: 1px solid #ddd;
            margin-top: 20px;
            border-radius: 8px;
            background-color: #f8f9fa;
        }

        .specs-container h3 {
            margin-bottom: 15px;
            color: #333;
            border-bottom: 2px solid #007bff;
            padding-bottom: 5px;
        }

        .button {
            background-color: #28a745;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .button:hover {
            background-color: #218838;
        }

        .success-message {
            color: #28a745;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 4px;
            display: none;
        }

        .error-message {
            color: #dc3545;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 4px;
            display: none;
        }
    </style>
</head>
<body>
    <div class="nav-buttons">
        <button class="nav-button" onclick="showSection('add')">Add</button>
        <button class="nav-button" onclick="showSection('orders')">Orders</button>
        <button class="nav-button" onclick="showSection('analysis')">Analysis</button>
        <div class="user-icon" onclick="logout()">👤</div>
    </div>

    <div class="dashboard-container">
        <div id="success-message" class="success-message">Product added successfully!</div>
        <div id="error-message" class="error-message">Error adding product. Please try again.</div>

        <h2>Add New Product</h2>
        <form action="${pageContext.request.contextPath}/addProduct" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label>Category</label>
                <select name="category" id="category" onchange="showSpecifications()" required>
                    <option value="">Select Category</option>
                    <option value="mobile">Mobile Phone</option>
                    <option value="pc">PC/Laptop</option>
                </select>
            </div>

            <div class="form-group">
                <label>Product Name</label>
                <input type="text" name="name" required>
            </div>

            <div class="form-group">
                <label>Company</label>
                <input type="text" name="company" required>
            </div>

            <div class="form-group">
                <label>Price</label>
                <input type="number" name="price" step="0.01" required>
            </div>

            <div class="form-group">
                <label>Description</label>
                <textarea name="description" rows="4" required></textarea>
            </div>

            <div class="form-group">
                <label>Product Image</label>
                <input type="file" name="image" accept="image/*" required>
            </div>

            <!-- Mobile Phone Specifications -->
            <div id="mobileSpecs" class="specs-container" style="display: none;">
                <h3>Mobile Phone Specifications</h3>
                <div class="form-group">
                    <label>Brand</label>
                    <input type="text" name="mobile_brand">
                </div>
                <div class="form-group">
                    <label>Operating System</label>
                    <input type="text" name="mobile_os">
                </div>
                <div class="form-group">
                    <label>RAM (GB)</label>
                    <input type="text" name="mobile_ram">
                </div>
                <div class="form-group">
                    <label>Storage (GB)</label>
                    <input type="text" name="mobile_storage">
                </div>
                <div class="form-group">
                    <label>Main Camera (MP)</label>
                    <input type="text" name="mobile_main_camera">
                </div>
                <div class="form-group">
                    <label>Rear Camera (MP)</label>
                    <input type="text" name="mobile_rear_camera">
                </div>
                <div class="form-group">
                    <label>Network Technology</label>
                    <input type="text" name="mobile_network">
                </div>
                <div class="form-group">
                    <label>Screen Technology</label>
                    <input type="text" name="mobile_screen">
                </div>
                <div class="form-group">
                    <label>Weight (g)</label>
                    <input type="text" name="mobile_weight">
                </div>
                <div class="form-group">
                    <label>Launch Date</label>
                    <input type="date" name="mobile_launch_date">
                </div>
                <div class="form-group">
                    <label>Battery Capacity (mAh)</label>
                    <input type="text" name="mobile_battery">
                </div>
                <div class="form-group">
                    <label>Charging Specifications</label>
                    <input type="text" name="mobile_charging">
                </div>
            </div>

            <!-- PC/Laptop Specifications -->
            <div id="pcSpecs" class="specs-container" style="display: none;">
                <h3>PC/Laptop Specifications</h3>
                <div class="form-group">
                    <label>Brand</label>
                    <input type="text" name="pc_brand">
                </div>
                <div class="form-group">
                    <label>Processor Speed</label>
                    <input type="text" name="pc_processor">
                </div>
                <div class="form-group">
                    <label>RAM (GB)</label>
                    <input type="text" name="pc_ram">
                </div>
                <div class="form-group">
                    <label>Storage (GB)</label>
                    <input type="text" name="pc_storage">
                </div>
                <div class="form-group">
                    <label>Display Size (inches)</label>
                    <input type="text" name="pc_display">
                </div>
                <div class="form-group">
                    <label>Graphics Card</label>
                    <input type="text" name="pc_graphics">
                </div>
                <div class="form-group">
                    <label>Operating System</label>
                    <input type="text" name="pc_os">
                </div>
                <div class="form-group">
                    <label>Battery Capacity (Wh)</label>
                    <input type="text" name="pc_battery">
                </div>
                <div class="form-group">
                    <label>Charging Specifications</label>
                    <input type="text" name="pc_charging">
                </div>
                <div class="form-group">
                    <label>Touch Sensor</label>
                    <select name="pc_touch">
                        <option value="false">No</option>
                        <option value="true">Yes</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Keyboard Backlight</label>
                    <select name="pc_keyboard_light">
                        <option value="false">No</option>
                        <option value="true">Yes</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Number of Fans</label>
                    <input type="number" name="pc_fans" min="0">
                </div>
            </div>

            <button type="submit" class="button">Add Product</button>
        </form>
    </div>

    <script>
        function showSpecifications() {
            const category = document.getElementById('category').value;
            document.getElementById('mobileSpecs').style.display = 'none';
            document.getElementById('pcSpecs').style.display = 'none';

            if (category === 'mobile') {
                document.getElementById('mobileSpecs').style.display = 'block';
            } else if (category === 'pc') {
                document.getElementById('pcSpecs').style.display = 'block';
            }
        }

        function showSection(section) {
            // Implementation for section switching
            console.log('Switching to section:', section);
        }

        function logout() {
            // Implementation for logout
            window.location.href = '${pageContext.request.contextPath}/logout';
        }

        // Show success/error message based on URL parameters
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('success') === 'true') {
                document.getElementById('success-message').style.display = 'block';
                setTimeout(() => {
                    document.getElementById('success-message').style.display = 'none';
                }, 3000);
            }
            if (urlParams.get('error') === 'true') {
                document.getElementById('error-message').style.display = 'block';
                setTimeout(() => {
                    document.getElementById('error-message').style.display = 'none';
                }, 3000);
            }
        }
    </script>
</body>
</html>