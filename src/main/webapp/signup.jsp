<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sign Up</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        .signup-container {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 500px;
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
        }
        input, select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-top: 5px;
        }
        .button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
        }
        .button:hover {
            background-color: #45a049;
        }
        .login-link {
            text-align: center;
            margin-top: 20px;
        }
        .login-link a {
            color: #4CAF50;
            text-decoration: none;
        }
        .phone-group {
            display: flex;
            gap: 10px;
        }
        .phone-group select {
            width: 200px;
        }
        .phone-group input[type="tel"] {
            flex: 1;
        }
        .country-code {
            width: 80px !important;
            background: #f9f9f9;
        }
        .input-status {
            font-size: 0.9em;
            margin-top: 5px;
        }
        .valid {
            color: green;
        }
        .invalid {
            color: red;
        }
        .checking {
            color: #666;
            font-style: italic;
        }
        .error-message {
            color: red;
            margin-bottom: 15px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <h2>Sign Up</h2>
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message"><%= request.getAttribute("error") %></div>
        <% } %>
        <form id="signupForm" action="${pageContext.request.contextPath}/signup" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="fullName" required minlength="2">
            </div>
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" id="username" required minlength="4"
                       onkeyup="debounceUsername(this.value)">
                <div id="usernameStatus" class="input-status"></div>
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" id="email" required>
            </div>
            <div class="form-group">
                <label>Country</label>
                <select name="country" id="country" required onchange="updateCountryCode()">
                    <option value="">Select Country</option>
                </select>
            </div>
            <div class="form-group">
                <label>Phone Number</label>
                <div class="phone-group">
                    <input type="text" id="countryCode" name="countryCode" class="country-code" readonly>
                    <input type="tel" name="phoneNumber" required pattern="[0-9]{10}">
                </div>
            </div>

            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" id="email" required onblur="checkEmail(this.value)">
                <div id="emailStatus" class="input-status"></div>
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required minlength="8">
            </div>
            <div class="form-group">
                <label>Confirm Password</label>
                <input type="password" name="confirmPassword" required minlength="8">
            </div>
            <div class="form-group">
                <button type="submit" class="button" id="submitButton">Sign Up</button>
            </div>
        </form>

        <div class="login-link">
            Already have an account? <a href="${pageContext.request.contextPath}/login.jsp">Login</a>
        </div>
    </div>

    <script>
        let usernameTimer;
        let usernameValid = false;
        // Add this to your existing JavaScript in signup.jsp
        let emailValid = false;

        function checkEmail(email) {
            fetch('${pageContext.request.contextPath}/check-email?email=' + encodeURIComponent(email))
                .then(response => response.text())
                .then(data => {
                    if (data === 'available') {
                        document.getElementById('emailStatus').className = 'input-status valid';
                        document.getElementById('emailStatus').textContent = 'Email is available';
                        emailValid = true;
                    } else {
                        document.getElementById('emailStatus').className = 'input-status invalid';
                        document.getElementById('emailStatus').textContent = 'Email is already taken';
                        emailValid = false;
                    }
                });
        }

        // Update validateForm to include email check
        function validateForm() {
            // ... existing validation code ...

            if (!emailValid) {
                alert('Please use a different email address.');
                return false;
            }

            return true;
        }

        function debounceUsername(username) {
            document.getElementById('usernameStatus').className = 'input-status checking';
            document.getElementById('usernameStatus').textContent = 'Checking...';

            clearTimeout(usernameTimer);
            usernameTimer = setTimeout(() => checkUsername(username), 500);
        }

        function checkUsername(username) {
            if (username.length < 4) {
                document.getElementById('usernameStatus').className = 'input-status invalid';
                document.getElementById('usernameStatus').textContent = 'Username must be at least 4 characters';
                usernameValid = false;
                return;
            }

            fetch('${pageContext.request.contextPath}/check-username?username=' + encodeURIComponent(username))
                .then(response => response.text())
                .then(data => {
                    if (data === 'available') {
                        document.getElementById('usernameStatus').className = 'input-status valid';
                        document.getElementById('usernameStatus').textContent = 'Username is available';
                        usernameValid = true;
                    } else {
                        document.getElementById('usernameStatus').className = 'input-status invalid';
                        document.getElementById('usernameStatus').textContent = 'Username is already taken';
                        usernameValid = false;
                    }
                })
                .catch(error => {
                    document.getElementById('usernameStatus').className = 'input-status invalid';
                    document.getElementById('usernameStatus').textContent = 'Error checking username';
                    usernameValid = false;
                });
        }

        function validateForm() {
            const password = document.querySelector('input[name="password"]').value;
            const confirmPassword = document.querySelector('input[name="confirmPassword"]').value;
            const phoneNumber = document.querySelector('input[name="phoneNumber"]').value;

            if (!usernameValid) {
                alert('Please choose a valid username.');
                return false;
            }

            if (password !== confirmPassword) {
                alert('Passwords do not match!');
                return false;
            }

            if (!/^\d{10}$/.test(phoneNumber)) {
                alert('Please enter a valid 10-digit phone number.');
                return false;
            }

            return true;
        }

        const countries = [
            { name: "United States", code: "+1" },
            { name: "India", code: "+91" },
            { name: "United Kingdom", code: "+44" },
            { name: "Canada", code: "+1" },
            { name: "Australia", code: "+61" },
            { name: "Germany", code: "+49" },
            { name: "France", code: "+33" },
            { name: "Italy", code: "+39" },
            { name: "Spain", code: "+34" },
            { name: "Japan", code: "+81" }
        ];

        // Populate country dropdown
        const countrySelect = document.getElementById('country');
        countries.forEach(country => {
            const option = document.createElement('option');
            option.value = country.name;
            option.textContent = country.name;
            countrySelect.appendChild(option);
        });

        function updateCountryCode() {
            const selectedCountry = document.getElementById('country').value;
            const country = countries.find(c => c.name === selectedCountry);
            if (country) {
                document.getElementById('countryCode').value = country.code;
            }
        }


        // Set initial country code
        updateCountryCode();
    </script>
</body>
</html>