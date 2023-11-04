<?php
session_start();

// Initialize variables
$welcomeMessage = $loginMessage = $adminButton = $userButton = $roleSelectionMessage = $roleSelectionForm = '';
$roleNotDefinedMessage = $roleAssignmentMessage = $roleAssignmentForm = '';

// Check if the user is logged in (you can adjust the condition based on your login logic)
if (isset($_SESSION['user_id'])) {
    // User is logged in
    $welcomeMessage = "Welcome, User!";

    // Check the user's role if it is set
    if (isset($_SESSION['Role'])) {
        if ($_SESSION['Role'] === 'Admin') {
            $adminButton = '<a href="admin.php" class="btn brand z-depth-0">Admin</a>';
        } elseif ($_SESSION['Role'] === 'User') {
            $userButton = '<a href="user.php" class="btn brand z-depth-0">User</a>';
        } else {
            // Role is not NULL, but not Admin or User
            $roleSelectionMessage = "Please select a role: ";
            $roleSelectionForm = '
                <form action="index.php" method="post">
                    <select name="role">
                        <option value="Admin">Admin</option>
                        <option value="User">User</option>
                    </select>
                    <button type="submit" name="select_role">Submit</button>
                </form>';
        }
    } else {
        // Handle the case where the user's role is not defined
        $roleNotDefinedMessage = "You are not assigned any role. Choose between Admin and User.";
    }
} else {
    // User is not logged in
    $loginMessage = "Please log in to access the content.";
}

// Handle the role selection and password form
if (isset($_POST['Role'])) {
    // Check the selected role and entered password
    $selectedRole = $_POST['Role'];

    if ($selectedRole === 'Admin') {
        // User selected Admin, ask for the password
        $roleAssignmentForm = true;
    } elseif ($selectedRole === 'User') {
        // User selected User, assign the role and update the database if needed
        // You should update the user's role in the database here.
        $_SESSION['Role'] = 'User';
        $roleAssignmentMessage = "User role assigned successfully.";
    }
}

if (isset($_POST['assign_admin_role'])) {
    $enteredPassword = $_POST['admin_password'];

    if ($enteredPassword === 'Anshul@2004') {
        // Correct password, assign the Admin role and update the database if needed
        // You should update the user's role in the database here.
        $_SESSION['user_role'] = 'Admin';
        $roleAssignmentMessage = "Admin role assigned successfully.";
    } else {
        // Incorrect password
        $roleAssignmentMessage = "Role assignment failed. Please make sure you entered the correct password for Admin.";
    }
}
?>

<!DOCTYPE html>
<html>
<?php include('templates/header.php'); ?>

<section class="container grey-text">
    <h4 class="center">Main Page</h4>
    <?php if (isset($welcomeMessage)) : ?>
        <p><?php echo $welcomeMessage; ?></p>

        <?php if (isset($adminButton)) : ?>
            <?php echo $adminButton; ?>
        <?php elseif (isset($userButton)) : ?>
            <?php echo $userButton; ?>
        <?php else : ?>
            <?php if (isset($roleNotDefinedMessage)) : ?>
                <p><?php echo $roleNotDefinedMessage; ?></p>
                <?php echo $roleSelectionMessage; ?>
                <?php echo $roleSelectionForm; ?>
            <?php endif; ?>
        <?php endif; ?>

        <?php if (isset($roleAssignmentMessage)) : ?>
            <p><?php echo $roleAssignmentMessage; ?></p>
        <?php endif; ?>

        <?php if (isset($roleAssignmentForm)) : ?>
            <form action="index.php" method="post">
                <label>Password: </label>
                <input type="password" name="admin_password">
                <button type="submit" name="assign_admin_role">Submit</button>
            </form>
        <?php endif; ?>

    <?php else : ?>
        <p><?php echo $loginMessage; ?></p>
        <a href="login.php" class="btn brand z-depth-0">Login</a>
    <?php endif; ?>
</section>

<?php include('templates/footer.php'); ?>

</html>
