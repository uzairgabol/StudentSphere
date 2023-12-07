<?php

include '../dbconnection.php';

// Get alumni_id from the request, replace this with your actual method of getting input
$alumni_id = isset($_POST['alumni_id']) ? $_POST['alumni_id'] : null;

// Check if alumni_id is provided
if ($alumni_id !== null) {
    // Escape alumni_id to prevent SQL injection
    $alumni_id = $conn->real_escape_string($alumni_id);

    // SQL query
    $query = "SELECT date, time FROM alumnidates WHERE alumni_id = '$alumni_id' AND status = 'Not Booked'";

    // Execute the query
    $result = $conn->query($query);

    // Check if the query was successful
    if ($result) {
        // Fetch the result as an associative array
        $data = $result->fetch_all(MYSQLI_ASSOC);

        // Convert data to JSON and send the response
        header('Content-Type: application/json');
        echo json_encode($data, JSON_PRETTY_PRINT);

        // Close the database connection
        $conn->close();
    } else {
        // If the query fails, return an error response
        header('HTTP/1.1 500 Internal Server Error');
        echo json_encode(['error' => 'Unable to fetch data from the alumnidates table.']);
    }
} else {
    // If alumni_id is not provided, return an error response
    header('HTTP/1.1 400 Bad Request');
    echo json_encode(['error' => 'Alumni ID not provided.']);
}

// include '../dbconnection.php';

// // Get alumni_id from the request, replace this with your actual method of getting input
// $alumni_id = isset($_POST['alumni_id']) ? $_POST['alumni_id'] : null;

// // Check if alumni_id is provided
// if ($alumni_id !== null) {
//     // Escape alumni_id to prevent SQL injection
//     $alumni_id = $conn->real_escape_string($alumni_id);

//     // SQL query to read data from the available_dates_alumni_view view
//     $query = "SELECT date, time FROM available_dates_alumni_view WHERE alumni_id = '$alumni_id'";

//     // Execute the query
//     $result = $conn->query($query);

//     // Check if the query was successful
//     if ($result) {
//         // Fetch the result as an associative array
//         $data = $result->fetch_all(MYSQLI_ASSOC);

//         // Convert data to JSON and send the response
//         header('Content-Type: application/json');
//         echo json_encode($data, JSON_PRETTY_PRINT);

//         // Close the database connection
//         $conn->close();
//     } else {
//         // If the query fails, return an error response
//         header('HTTP/1.1 500 Internal Server Error');
//         echo json_encode(['error' => 'Unable to fetch data from the available_dates_alumni_view view.']);
//     }
// } else {
//     // If alumni_id is not provided, return an error response
//     header('HTTP/1.1 400 Bad Request');
//     echo json_encode(['error' => 'Alumni ID not provided.']);
// }

?>
