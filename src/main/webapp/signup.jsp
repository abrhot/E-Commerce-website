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
            position: relative;
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
            transition: border-color 0.3s ease;
        }
        input:focus, select:focus {
            outline: none;
            border-color: #4CAF50;
        }
        input.error, select.error {
            border-color: #ff0000;
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
        .phone-group {
            display: flex;
            gap: 10px;
        }
        .country-code {
            width: 80px !important;
            background: #f9f9f9;
        }
        .input-status {
            font-size: 0.85em;
            margin-top: 5px;
            min-height: 20px;
        }
        .valid {
            color: #4CAF50;
        }
        .invalid {
            color: #ff0000;
        }
        .checking {
            color: #666;
            font-style: italic;
        }
        .error-message {
            color: #ff0000;
            background-color: #ffe6e6;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
            text-align: center;
        }
        .form-requirements {
            font-size: 0.8em;
            color: #666;
            margin-top: 4px;
        }
        .input-icon {
            position: absolute;
            right: 10px;
            top: 35px;
            color: #ccc;
        }
        .password-requirements {
            display: none;
            position: absolute;
            background: white;
            padding: 10px;
            border-radius: 4px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            font-size: 0.8em;
            z-index: 100;
            width: 200px;
            right: 0;
        }
        .requirement {
            margin: 5px 0;
            color: #666;
        }
        .requirement.met {
            color: #4CAF50;
        }
        .password-toggle {
            position: absolute;
            right: 10px;
            top: 38px;
            cursor: pointer;
            color: #666;
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
                <input type="text" name="fullName" id="fullName" required minlength="2"
                       oninput="validateFullName(this)">
                <div class="input-status" id="fullNameStatus"></div>
                <div class="form-requirements">Minimum 2 characters, letters and spaces only</div>
            </div>

            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" id="username" required minlength="4"
                       onkeyup="debounceUsername(this.value)">
                <div class="input-status" id="usernameStatus"></div>
                <div class="form-requirements">4-20 characters, letters, numbers and underscores only</div>
            </div>

            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" id="email" required onblur="checkEmail(this.value)">
                <div class="input-status" id="emailStatus"></div>
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
                    <input type="tel" name="phoneNumber" id="phoneNumber" required
                           oninput="validatePhoneNumber(this)">
                </div>
                <div class="input-status" id="phoneStatus"></div>
                <div class="form-requirements">10 digits only</div>
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" id="password" required minlength="8"
                       oninput="validatePassword(this)">
                <span class="password-toggle" onclick="togglePassword('password')">👁️</span>
                <div class="input-status" id="passwordStatus"></div>
                <div class="password-requirements" id="passwordRequirements">
                    <div class="requirement" id="lengthReq">✗ At least 8 characters</div>
                    <div class="requirement" id="upperReq">✗ One uppercase letter</div>
                    <div class="requirement" id="lowerReq">✗ One lowercase letter</div>
                    <div class="requirement" id="numberReq">✗ One number</div>
                    <div class="requirement" id="specialReq">✗ One special character</div>
                </div>
            </div>

            <div class="form-group">
                <label>Confirm Password</label>
                <input type="password" name="confirmPassword" id="confirmPassword" required
                       oninput="validateConfirmPassword()">
                <span class="password-toggle" onclick="togglePassword('confirmPassword')">👁️</span>
                <div class="input-status" id="confirmPasswordStatus"></div>
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
        let emailValid = false;
        let passwordValid = false;

        // Full Name Validation
        function validateFullName(input) {
            const fullNameRegex = /^[A-Za-z\s]{2,}$/;
            const isValid = fullNameRegex.test(input.value);
            const status = document.getElementById('fullNameStatus');

            if (isValid) {
                input.classList.remove('error');
                status.textContent = 'Valid name';
                status.className = 'input-status valid';
                return true;
            } else {
                input.classList.add('error');
                status.textContent = 'Please enter a valid name (letters and spaces only)';
                status.className = 'input-status invalid';
                return false;
            }
        }

        // Phone Number Validation
        function validatePhoneNumber(input) {
            const phoneRegex = /^\d{10}$/;
            const isValid = phoneRegex.test(input.value);
            const status = document.getElementById('phoneStatus');

            if (isValid) {
                input.classList.remove('error');
                status.textContent = 'Valid phone number';
                status.className = 'input-status valid';
                return true;
            } else {
                input.classList.add('error');
                status.textContent = 'Please enter a valid 10-digit phone number';
                status.className = 'input-status invalid';
                return false;
            }
        }

        // Password Validation
        function validatePassword(input) {
            const password = input.value;
            const lengthReq = document.getElementById('lengthReq');
            const upperReq = document.getElementById('upperReq');
            const lowerReq = document.getElementById('lowerReq');
            const numberReq = document.getElementById('numberReq');
            const specialReq = document.getElementById('specialReq');

            // Show requirements on focus
            input.onfocus = function() {
                document.getElementById('passwordRequirements').style.display = 'block';
            }

            input.onblur = function() {
                document.getElementById('passwordRequirements').style.display = 'none';
            }

            // Check each requirement
            const hasLength = password.length >= 8;
            const hasUpper = /[A-Z]/.test(password);
            const hasLower = /[a-z]/.test(password);
            const hasNumber = /\d/.test(password);
            const hasSpecial = /[!@#$%^&*]/.test(password);

            lengthReq.className = 'requirement' + (hasLength ? ' met' : '');
            upperReq.className = 'requirement' + (hasUpper ? ' met' : '');
            lowerReq.className = 'requirement' + (hasLower ? ' met' : '');
            numberReq.className = 'requirement' + (hasNumber ? ' met' : '');
            specialReq.className = 'requirement' + (hasSpecial ? ' met' : '');

            passwordValid = hasLength && hasUpper && hasLower && hasNumber && hasSpecial;

            const status = document.getElementById('passwordStatus');
            if (passwordValid) {
                input.classList.remove('error');
                status.textContent = 'Strong password';
                status.className = 'input-status valid';
            } else {
                input.classList.add('error');
                status.textContent = 'Password does not meet requirements';
                status.className = 'input-status invalid';
            }

            validateConfirmPassword();
            return passwordValid;
        }

        // Confirm Password Validation
        function validateConfirmPassword() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword');
            const status = document.getElementById('confirmPasswordStatus');

            if (confirmPassword.value === password && passwordValid) {
                confirmPassword.classList.remove('error');
                status.textContent = 'Passwords match';
                status.className = 'input-status valid';
                return true;
            } else {
                confirmPassword.classList.add('error');
                status.textContent = 'Passwords do not match';
                status.className = 'input-status invalid';
                return false;
            }
        }

        // Toggle Password Visibility
        function togglePassword(inputId) {
            const input = document.getElementById(inputId);
            input.type = input.type === 'password' ? 'text' : 'password';
        }

        // Username Check
        function debounceUsername(username) {
            document.getElementById('usernameStatus').className = 'input-status checking';
            document.getElementById('usernameStatus').textContent = 'Checking...';

            clearTimeout(usernameTimer);
            usernameTimer = setTimeout(() => checkUsername(username), 500);
        }

        function checkUsername(username) {
            const usernameRegex = /^[a-zA-Z0-9_]{4,20}$/;
            if (!usernameRegex.test(username)) {
                document.getElementById('usernameStatus').className = 'input-status invalid';
                document.getElementById('usernameStatus').textContent = 'Invalid username format';
                document.getElementById('username').classList.add('error');
                usernameValid = false;
                return;
            }

            fetch('${pageContext.request.contextPath}/check-username?username=' + encodeURIComponent(username))
                .then(response => response.text())
                .then(data => {
                    const input = document.getElementById('username');
                    if (data === 'available') {
                        document.getElementById('usernameStatus').className = 'input-status valid';
                        document.getElementById('usernameStatus').textContent = 'Username is available';
                        input.classList.remove('error');
                        usernameValid = true;
                    } else {
                        document.getElementById('usernameStatus').className = 'input-status invalid';
                        document.getElementById('usernameStatus').textContent = 'Username is already taken';
                        input.classList.add('error');
                        usernameValid = false;
                    }
                })
                .catch(error => {
                    document.getElementById('usernameStatus').className = 'input-status invalid';
                    document.getElementById('usernameStatus').textContent = 'Error checking username';
                    document.getElementById('username').classList.add('error');
                    usernameValid = false;
                });
        }

        // Email Check
        function checkEmail(email) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                document.getElementById('emailStatus').className = 'input-status invalid';
                document.getElementById('emailStatus').textContent = 'Invalid email format';
                document.getElementById('email').classList.add('error');
                emailValid = false;
                return;
            }

            fetch('${pageContext.request.contextPath}/check-email?email=' + encodeURIComponent(email))
                .then(response => response.text())
                .then(data => {
                    const input = document.getElementById('email');
                    if (data === 'available') {
                        document.getElementById('emailStatus').className = 'input-status valid';
                        document.getElementById('emailStatus').textContent = 'Email is available';
                        input.classList.remove('error');
                        emailValid = true;
                    } else {
                        document.getElementById('emailStatus').className = 'input-status invalid';
                        document.getElementById('emailStatus').textContent = 'Email is already taken';
                        input.classList.add('error');
                        emailValid = false;
                    }
                });
        }

        // Form Validation
        function validateForm() {
            let isValid = true;

            // Validate Full Name
            if (!validateFullName(document.getElementById('fullName'))) {
                isValid = false;
            }

            // Check Username
            if (!usernameValid) {
                document.getElementById('username').classList.add('error');
                isValid = false;
            }

            // Check Email
            if (!emailValid) {
                document.getElementById('email').classList.add('error');
                isValid = false;
            }

            // Validate Phone Number
            if (!validatePhoneNumber(document.getElementById('phoneNumber'))) {
                isValid = false;
            }

            // Check Password
            if (!passwordValid) {
                document.getElementById('password').classList.add('error');
                isValid = false;
            }

            // Check Confirm Password
            if (!validateConfirmPassword()) {
                isValid = false;
            }

            if (!isValid) {
                alert('Please fix the errors in the form before submitting.');
                return false;
            }

            return true;
        }

        // Countries data and related functions remain the same
        const countries = [
                { name: "Afghanistan", code: "+93" },
                { name: "Albania", code: "+355" },
                { name: "Algeria", code: "+213" },
                { name: "Andorra", code: "+376" },
                { name: "Angola", code: "+244" },
                { name: "Argentina", code: "+54" },
                { name: "Armenia", code: "+374" },
                { name: "Australia", code: "+61" },
                { name: "Austria", code: "+43" },
                { name: "Azerbaijan", code: "+994" },
                { name: "Bahamas", code: "+1" },
                { name: "Bahrain", code: "+973" },
                { name: "Bangladesh", code: "+880" },
                { name: "Barbados", code: "+1" },
                { name: "Belarus", code: "+375" },
                { name: "Belgium", code: "+32" },
                { name: "Belize", code: "+501" },
                { name: "Benin", code: "+229" },
                { name: "Bhutan", code: "+975" },
                { name: "Bolivia", code: "+591" },
                { name: "Bosnia and Herzegovina", code: "+387" },
                { name: "Botswana", code: "+267" },
                { name: "Brazil", code: "+55" },
                { name: "Brunei", code: "+673" },
                { name: "Bulgaria", code: "+359" },
                { name: "Burkina Faso", code: "+226" },
                { name: "Burundi", code: "+257" },
                { name: "Cambodia", code: "+855" },
                { name: "Cameroon", code: "+237" },
                { name: "Canada", code: "+1" },
                { name: "Cape Verde", code: "+238" },
                { name: "Central African Republic", code: "+236" },
                { name: "Chad", code: "+235" },
                { name: "Chile", code: "+56" },
                { name: "China", code: "+86" },
                { name: "Colombia", code: "+57" },
                { name: "Comoros", code: "+269" },
                { name: "Congo", code: "+242" },
                { name: "Costa Rica", code: "+506" },
                { name: "Croatia", code: "+385" },
                { name: "Cuba", code: "+53" },
                { name: "Cyprus", code: "+357" },
                { name: "Czech Republic", code: "+420" },
                { name: "Denmark", code: "+45" },
                { name: "Djibouti", code: "+253" },
                { name: "Dominican Republic", code: "+1" },
                { name: "Ecuador", code: "+593" },
                { name: "Egypt", code: "+20" },
                { name: "El Salvador", code: "+503" },
                { name: "Equatorial Guinea", code: "+240" },
                { name: "Eritrea", code: "+291" },
                { name: "Estonia", code: "+372" },
                { name: "Ethiopia", code: "+251" },
                { name: "Fiji", code: "+679" },
                { name: "Finland", code: "+358" },
                { name: "France", code: "+33" },
                { name: "Gabon", code: "+241" },
                { name: "Gambia", code: "+220" },
                { name: "Georgia", code: "+995" },
                { name: "Germany", code: "+49" },
                { name: "Ghana", code: "+233" },
                { name: "Greece", code: "+30" },
                { name: "Greenland", code: "+299" },
                { name: "Guatemala", code: "+502" },
                { name: "Guinea", code: "+224" },
                { name: "Guinea-Bissau", code: "+245" },
                { name: "Guyana", code: "+592" },
                { name: "Haiti", code: "+509" },
                { name: "Honduras", code: "+504" },
                { name: "Hong Kong", code: "+852" },
                { name: "Hungary", code: "+36" },
                { name: "Iceland", code: "+354" },
                { name: "India", code: "+91" },
                { name: "Indonesia", code: "+62" },
                { name: "Iran", code: "+98" },
                { name: "Iraq", code: "+964" },
                { name: "Ireland", code: "+353" },
                { name: "Israel", code: "+972" },
                { name: "Italy", code: "+39" },
                { name: "Jamaica", code: "+1" },
                { name: "Japan", code: "+81" },
                { name: "Jordan", code: "+962" },
                { name: "Kazakhstan", code: "+7" },
                { name: "Kenya", code: "+254" },
                { name: "Kuwait", code: "+965" },
                { name: "Kyrgyzstan", code: "+996" },
                { name: "Laos", code: "+856" },
                { name: "Latvia", code: "+371" },
                { name: "Lebanon", code: "+961" },
                { name: "Lesotho", code: "+266" },
                { name: "Liberia", code: "+231" },
                { name: "Libya", code: "+218" },
                { name: "Liechtenstein", code: "+423" },
                { name: "Lithuania", code: "+370" },
                { name: "Luxembourg", code: "+352" },
                { name: "Madagascar", code: "+261" },
                { name: "Malawi", code: "+265" },
                { name: "Malaysia", code: "+60" },
                { name: "Maldives", code: "+960" },
                { name: "Mali", code: "+223" },
                { name: "Malta", code: "+356" },
                { name: "Mauritania", code: "+222" },
                { name: "Mauritius", code: "+230" },
                { name: "Mexico", code: "+52" },
                { name: "Moldova", code: "+373" },
                { name: "Monaco", code: "+377" },
                { name: "Mongolia", code: "+976" },
                { name: "Montenegro", code: "+382" },
                { name: "Morocco", code: "+212" },
                { name: "Mozambique", code: "+258" },
                { name: "Myanmar", code: "+95" },
                { name: "Namibia", code: "+264" },
                { name: "Nepal", code: "+977" },
                { name: "Netherlands", code: "+31" },
                { name: "New Zealand", code: "+64" },
                { name: "Nicaragua", code: "+505" },
                { name: "Niger", code: "+227" },
                { name: "Nigeria", code: "+234" },
                { name: "North Korea", code: "+850" },
                { name: "Norway", code: "+47" },
                { name: "Oman", code: "+968" },
                { name: "Pakistan", code: "+92" },
                { name: "Palestine", code: "+970" },
                { name: "Panama", code: "+507" },
                { name: "Papua New Guinea", code: "+675" },
                { name: "Paraguay", code: "+595" },
                { name: "Peru", code: "+51" },
                { name: "Philippines", code: "+63" },
                { name: "Poland", code: "+48" },
                { name: "Portugal", code: "+351" },
                { name: "Qatar", code: "+974" },
                { name: "Romania", code: "+40" },
                { name: "Russia", code: "+7" },
                { name: "Rwanda", code: "+250" },
                { name: "Saudi Arabia", code: "+966" },
                { name: "Senegal", code: "+221" },
                { name: "Serbia", code: "+381" },
                { name: "Seychelles", code: "+248" },
                { name: "Sierra Leone", code: "+232" },
                { name: "Singapore", code: "+65" },
                { name: "Slovakia", code: "+421" },
                { name: "Slovenia", code: "+386" },
                { name: "Somalia", code: "+252" },
                { name: "South Africa", code: "+27" },
                { name: "South Korea", code: "+82" },
                { name: "South Sudan", code: "+211" },
                { name: "Spain", code: "+34" },
                { name: "Sri Lanka", code: "+94" },
                { name: "Sudan", code: "+249" },
                { name: "Sweden", code: "+46" },
                { name: "Switzerland", code: "+41" },
                { name: "Syria", code: "+963" },
                { name: "Taiwan", code: "+886" },
                { name: "Tajikistan", code: "+992" },
                { name: "Tanzania", code: "+255" },
                { name: "Thailand", code: "+66" },
                { name: "Togo", code: "+228" },
                { name: "Tunisia", code: "+216" },
                { name: "Turkey", code: "+90" },
                { name: "Turkmenistan", code: "+993" },
                { name: "Uganda", code: "+256" },
                { name: "Ukraine", code: "+380" },
                { name: "United Arab Emirates", code: "+971" },
                { name: "United Kingdom", code: "+44" },
                { name: "United States", code: "+1" },
                { name: "Uruguay", code: "+598" },
                { name: "Uzbekistan", code: "+998" },
                { name: "Vatican City", code: "+379" },
                { name: "Venezuela", code: "+58" },
                { name: "Vietnam", code: "+84" },
                { name: "Yemen", code: "+967" },
                { name: "Zambia", code: "+260" },
                { name: "Zimbabwe", code: "+263" }
            ];


        // Populate country dropdown
        const countrySelect = document.getElementById('country');
        countries.sort((a, b) => a.name.localeCompare(b.name)).forEach(country => {
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