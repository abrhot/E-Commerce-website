<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Add Product</title>
    <style>
        .dashboard-container {
            width: 80%;
            margin: 20px auto;
            padding: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .specs-container {
            padding: 15px;
            border: 1px solid #ddd;
            margin-top: 15px;
            border-radius: 4px;
        }
        .button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <h2>Add New Product</h2>
        <form action="${pageContext.request.contextPath}/addProduct" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label>Category</label>
                <select name="category" id="category" onchange="showSpecifications()" required>
                    <option value="">Select Category</option>
                    <option value="mobile">Mobile</option>
                    <option value="laptop">Laptop</option>
                    <option value="watch">Watch</option>
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

            <!-- Dynamic specifications based on category -->
            <div id="mobileSpecs" class="specs-container" style="display: none;">
                <h3>Mobile Specifications</h3>
                <div class="form-group">
                    <label>Storage</label>
                    <input type="text" name="mobile_storage">
                </div>
                <div class="form-group">
                    <label>RAM</label>
                    <input type="text" name="mobile_ram">
                </div>
                <div class="form-group">
                    <label>Battery</label>
                    <input type="text" name="mobile_battery">
                </div>
                <div class="form-group">
                    <label>Camera Specifications</label>
                    <textarea name="mobile_camera"></textarea>
                </div>
                <!-- Add more mobile-specific fields -->
            </div>

            <!-- Similar containers for laptop and watch specifications -->

            <button type="submit" class="button">Add Product</button>
        </form>
    </div>

    <script>
        function showSpecifications() {
            const category = document.getElementById('category').value;
            document.getElementById('mobileSpecs').style.display = 'none';
            document.getElementById('laptopSpecs').style.display = 'none';
            document.getElementById('watchSpecs').style.display = 'none';

            if (category) {
                document.getElementById(category + 'Specs').style.display = 'block';
            }
        }
    </script>
</body>
</html>