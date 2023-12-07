<?php

include '../dbconnection.php';

// Check if the request is a POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get the 'id' parameter from the POST request
    $id = $_POST['teacher_id'];

    // Use a prepared statement to prevent SQL injection
    $sql = "SELECT * FROM teacher_details T WHERE T.teacher_id = ? LIMIT 1";
    $stmt = $conn->prepare($sql);

    // Bind the parameter
    $stmt->bind_param('s', $id);

    // Execute the query
    $stmt->execute();

    // Get the result
    $result = $stmt->get_result();

    // Check if the query was successful
    if ($result) {
        // Fetch the result as an associative array
        $data = $result->fetch_assoc();

        // Return the result as JSON
        echo json_encode($data);
    } else {
        // If the query failed, return an error message
        echo json_encode(['error' => 'Query failed']);
    }

    // Close the prepared statement
    $stmt->close();
} else {
    // If the request is not a POST request, return an error message
    echo json_encode(['error' => 'Invalid request method']);
}

// Close the database connection
$conn->close();

?>
