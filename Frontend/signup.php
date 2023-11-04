<?php
$name = $username = $password = $role = $sprint_id = '';
$errors = array('name' => '', 'username' => '', 'password' => '');

if (isset($_POST['submit'])) {
    // check name
    if (empty($_POST['name'])) {
        $errors['name'] = 'Name is required';
    } else {
        $name = $_POST['name'];
        if (!preg_match('/^[a-zA-Z\s]+$/', $name)) {
            $errors['name'] = 'Name must be letters and spaces only';
        }
    }

    // check username
    if (empty($_POST['username'])) {
        $errors['username'] = 'Username is required';
    } else {
        $username = $_POST['username'];
        // Additional validation for username (e.g., alphanumeric characters, minimum length):
        if (!preg_match('/^[a-zA-Z0-9_]{3,20}$/', $username)) {
            $errors['username'] = 'Username must be 3-20 characters and contain only letters, numbers, and underscores';
        }
    }

    // check password
    if (empty($_POST['password'])) {
        $errors['password'] = 'Password is required';
    } else {
        $password = $_POST['password'];
        // Additional validation for password (e.g., minimum length, complexity requirements):
        if (strlen($password) < 8) {
            $errors['password'] = 'Password must be at least 8 characters long';
        }
    }

    $role = $_POST['role'];
    $sprint_id = $_POST['sprint_id'];

    if (array_filter($errors)) {
        // Handle errors in the form
    } else {
        // Form is valid; you can proceed with registration logic here.
        // For now, I'm redirecting to the homepage.
        $conn = mysqli_connect('localhost', 'root', 'Anshul@2004', 'sprinthub');

        if (!$conn) {
            echo 'Connection error: ' . mysqli_connect_error();
        } else {
            // Prepare and execute the SQL INSERT statement
            $name = mysqli_real_escape_string($conn, $_POST['name']);
            $username = mysqli_real_escape_string($conn, $_POST['username']);
            $password = mysqli_real_escape_string($conn,$_POST['password']);

            // Role and sprint_id (optional)
            $role = mysqli_real_escape_string($conn, $_POST['role']);
            $sprint_id = mysqli_real_escape_string($conn, $_POST['sprint_id']);

            $sql = "INSERT INTO user (Name, Username, Password, Role, Sprint_ID) VALUES ('$name', '$username', '$password', '$role', '$sprint_id')";

            if (mysqli_query($conn, $sql)) {
                // Registration successful
                header('Location: index.php'); // Redirect to the homepage or a success page
            } else {
                echo 'Query error: ' . mysqli_error($conn);
            }

            mysqli_close($conn);
        }
    }
}
?>


<!DOCTYPE html>
<html>
    <?php include('templates/header.php'); ?>

    <section class="container grey-text">
        <h4 class="center">Signup</h4>
        <form class="white" action="signup.php" method="POST">
            <label>Name</label>
            <input type="text" name="name" value="<?php echo htmlspecialchars($name) ?>">
            <div class="red-text"><?php echo $errors['name']; ?></div>
            <label>Username</label>
            <input type="text" name="username" value="<?php echo htmlspecialchars($username) ?>">
            <div class="red-text"><?php echo $errors['username']; ?></div>
            <label>Password</label>
            <input type="password" name="password" value="<?php echo htmlspecialchars($password) ?>">
            <div class="red-text"><?php echo $errors['password']; ?></div>
            <!-- Additional fields for role and sprint_id -->
            <label>Role (optional)</label>
            <input type="text" name="role" value="<?php echo htmlspecialchars($role) ?>">
            <!-- You can add additional validation for the "role" field as needed. -->
            <label>Sprint ID (optional)</label>
            <input type="text" name="sprint_id" value="<?php echo htmlspecialchars($sprint_id) ?>">
            <!-- You can add additional validation for the "sprint_id" field as needed. -->
            <div class="center">
                <input type="submit" name="submit" value="Sign Up" class="btn brand z-depth-0">
            </div>
        </form>
    </section>

    <?php include('templates/footer.php'); ?>

</html>