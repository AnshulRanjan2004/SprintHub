<!DOCTYPE html>
<html>

<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body {
            background-color: #f5f5f5;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .header {
            background-color: #f5f5f5;
            color: #fff;
            text-align: center;
            padding: 20px 0;
        }

        .container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            padding: 30px;
            text-align: center;
            margin: 20px auto;
            max-width: 800px;
        }

        h1 {
            color: #660066;
            font-size: 36px;
        }

        p {
            color: #333;
            font-size: 18px;
            line-height: 1.6;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #660066;
            color: #fff;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #330033;
        }

        footer {
            background-color: #660066;
            color: #fff;
            text-align: center;
            padding: 10px 0;
        }

        a {
            text-decoration: none;
        }
        
        /* Styled Boxes */
        .feature-box {
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 20px;
            margin: 20px 0;
        }

        /* Logo Styling */
        .logo {
            display: block;
            margin: 0 auto;
            max-width: 200px;
            height: auto;
        }

    </style>
</head>

<body>
    <div class="header">
        <img src="templates/logo.jpg" alt="Sprint Hub Logo" class="logo">
        <h1>Welcome to Sprint Hub</h1>
    </div>

    <div class="container">
        <p>Sprint Hub is a powerful Agile project management tool designed to streamline your software development projects. With features tailored for Scrum, Kanban, and Agile methodologies, Sprint Hub empowers teams to plan, execute, and optimize their projects with ease.</p>
        <a href="login.php" class="btn">Login</a>
    </div>

    <!-- Styled Feature Boxes -->
    <div class="container">
        <div class="feature-box">
            <h2>Agile Project Management</h2>
            <p>Efficiently manage your software development projects using Agile methodologies.</p>
        </div>

        <div class="feature-box">
            <h2>Scrum & Kanban Support</h2>
            <p>Customize your workflow with support for Scrum and Kanban methodologies.</p>
        </div>

        <div class="feature-box">
            <h2>Optimize Your Projects</h2>
            <p>Optimize your project execution and improve team collaboration.</p>
        </div>
    </div>

    <?php include('templates/footer.php'); ?>

</body>

</html>