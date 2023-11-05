<?php
session_start();

$username = $password = '';
$errors = array('username' => '', 'password' => '');

if (isset($_POST['submit'])) {
    // Check username
    if (empty($_POST['username'])) {
        $errors['username'] = 'Username is required';
    } else {
        $username = $_POST['username'];
    }

    // Check password
    if (empty($_POST['password'])) {
        $errors['password'] = 'Password is required';
    } else {
        $password = $_POST['password'];
        // You can add additional validation for the password as needed.
    }

    if (array_filter($errors)) {
        // There are errors in the form
    } else {
        // Form is valid; proceed with login logic here.
        // Establish a database connection
        $conn = mysqli_connect('localhost', 'root', 'Anshul@2004', 'sprinthub');

        if (!$conn) {
            echo 'Connection error: ' . mysqli_connect_error();
        } else {
            // Prepare and execute a SQL query to retrieve the user's data by username
            $username = mysqli_real_escape_string($conn, $username);
            $sql = "SELECT * FROM user WHERE Username='$username'";
            $result = mysqli_query($conn, $sql);

            if ($result) {
                if (mysqli_num_rows($result) === 1) {
                    // User with provided username exists; fetch the stored password
                    $row = mysqli_fetch_assoc($result);
                    $storedPassword = $row['Password'];

                    // Verify the provided password against the stored password in plain text
                    if ($password === $storedPassword) {
                        // Passwords match; user can log in
                        // Set a session variable to track the user's login state
                        $_SESSION['user_id'] = $row['User_ID'];

                        // Fetch the user's role from the database
                        $role = $row['Role'];

                        if ($role === 'Admin') {
                            // User is an admin, redirect to admin.php
                            header('Location: admin.php');
                        } else {
                            // User is not an admin, redirect to user.php
                            header('Location: user.php');
                        }
                    } else {
                        echo 'Incorrect username or password. Please sign up or try again.';
                    }
                } else {
                    echo 'Username not found. Please sign up or try again.';
                }

                mysqli_free_result($result);
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
    <h4 class="center">Login</h4>
    <form class="white" action="login.php" method="POST">
        <label>Username</label>
        <input type="text" name="username" value="<?php echo htmlspecialchars($username) ?>">
        <div class="red-text"><?php echo $errors['username']; ?></div>
        <label>Password</label>
        <input type="password" name="password" value="<?php echo htmlspecialchars($password) ?>">
        <div class="red-text"><?php echo $errors['password']; ?></div>
        <div class="center">
            <input type="submit" name="submit" value="Login" class="btn brand z-depth-0">
        </div>
    </form>
</section>

<?php include('templates/footer.php'); ?>

</html>