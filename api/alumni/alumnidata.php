<?php

include '../dbconnection.php';

// Fetch all data from the "alumni" table
$query = "SELECT * FROM alumni";
$result = $conn->query($query);

// Check if the query was successful
if ($result) {
    // Fetch data as an associative array
    $alumniData = $result->fetch_all(MYSQLI_ASSOC);

    // Convert data to JSON and send the response
    header('Content-Type: application/json');
    echo json_encode($alumniData, JSON_PRETTY_PRINT);

    // Close the database connection
    $conn->close();
} else {
    // If the query fails, return an error response
    header('HTTP/1.1 500 Internal Server Error');
    echo json_encode(['error' => 'Unable to fetch data from the alumni table.']);
}

?>
