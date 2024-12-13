<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Employee Management</title>
</head>
<body>
<h1>Add New Employee</h1>
<form action="employee" method="post">
    <label for="first_name">First Name:</label>
    <input type="text" id="first_name" name="first_name" required><br><br>

    <label for="last_name">Last Name:</label>
    <input type="text" id="last_name" name="last_name" required><br><br>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required><br><br>

    <label for="salary of employe">Salary:</label>
    <input type="number" step="0.01" id="salary" name="salary" required><br><br>

    <button type="submit">Add Employee</button>
</form>

<h1>Employee List</h1>
<a href="employee">View All Employees</a>
</body>
</html>
