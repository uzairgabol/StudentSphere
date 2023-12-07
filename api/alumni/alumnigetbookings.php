<?php

include '../dbconnection.php';

// Function to run the SQL query
function getBookedSlots($studentId, $conn) {
    $sql = "SELECT Al.alumni_id, A.alumni_name, Al.date, Al.time 
            FROM alumnidates Al
            JOIN alumni A ON A.alumni_id = Al.alumni_id
            WHERE Al.status = 'Booked' AND Al.student_id = '$studentId'";

    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $bookedSlots = array();

        while($row = $result->fetch_assoc()) {
            $bookedSlots[] = array(
                'alumni_id' => $row['alumni_id'],
                'alumni_name' => $row['alumni_name'],
                'date' => $row['date'],
                'time' => $row['time']
            );
        }

        return $bookedSlots;
    } else {
        return array();
    }
}

// Check if the student_id parameter is provided
if (isset($_POST['student_id'])) {
    $studentId = $_POST['student_id'];

    // Call the function with the provided student_id
    $bookedSlots = getBookedSlots($studentId, $conn);

    // Output the result as JSON
    header('Content-Type: application/json');
    echo json_encode($bookedSlots);
} else {
    // Return an error message if student_id is not provided
    echo "Error: 'student_id' parameter is missing.";
}

// Close the database connection
$conn->close();

?>
