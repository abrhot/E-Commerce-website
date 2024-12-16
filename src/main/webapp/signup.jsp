<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sign Up</title>
    <style>
        /* Previous CSS remains the same */
        .phone-group {
            display: flex;
            gap: 10px;
        }
        .phone-group select {
            width: 200px;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .phone-group input[type="tel"] {
            flex: 1;
        }
        .country-code {
            width: 80px !important;
            background: #f9f9f9;
            color: #666;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
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
    </style>
</head>
<body>
    <div class="signup-container">
        <h2>Sign Up</h2>
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
                <div id="emailStatus" class="input-status"></div>
            </div>
            <!-- Rest of the form fields remain the same -->
            <!-- Country, phone, password fields... -->
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

        // Debounce function for username checking
        function debounceUsername(username) {
            document.getElementById('usernameStatus').className = 'input-status checking';
            document.getElementById('usernameStatus').textContent = 'Checking...';

            clearTimeout(usernameTimer);
            usernameTimer = setTimeout(() => checkUsername(username), 500);
        }

        // Username check function
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

        // Form validation
        function validateForm() {
            const password = document.querySelector('input[name="password"]').value;
            const confirmPassword = document.querySelector('input[name="confirmPassword"]').value;
            const email = document.getElementById('email').value;

            if (!usernameValid) {
                alert('Please choose a valid username.');
                return false;
            }

            if (password !== confirmPassword) {
                alert('Passwords do not match!');
                return false;
            }

            // Submit form data using fetch to check email before final submission
            const formData = new FormData(document.getElementById('signupForm'));

            // Prevent default form submission
            event.preventDefault();

            // Check email availability
            fetch('${pageContext.request.contextPath}/check-email?email=' + encodeURIComponent(email))
                .then(response => response.text())
                .then(data => {
                    if (data === 'available') {
                        // If email is available, submit the form
                        document.getElementById('signupForm').submit();
                    } else {
                        // If email is taken, show error message
                        document.getElementById('emailStatus').className = 'input-status invalid';
                        document.getElementById('emailStatus').textContent = 'This email is already registered';
                        document.getElementById('email').focus();
                    }
                })
                .catch(error => {
                    alert('An error occurred while checking email availability. Please try again.');
                });

            return false;
        }

        // Country code handling remains the same
        const countries = [
            { name: "United States", code: "+1" },
            { name: "India", code: "+91" },
            { name: "United Kingdom", code: "+44" },
            // Add more countries as needed
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
    </script>
</body>
</html>