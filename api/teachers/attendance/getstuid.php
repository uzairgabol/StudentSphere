<?php

include '../../dbconnection.php';

// Set the content type to JSON
header('Content-Type: application/json');

// Check if teacher_id and subject_id are provided in the request
if (isset($_POST['teacher_id']) && isset($_POST['course_id']) && isset($_POST['section'])) {
    $teacher_id = $_POST['teacher_id'];
    $course_id = $_POST['course_id'];
    $section = $_POST['section'];

    // Query to retrieve attendance records for the specified student and subject
    $sql = "SELECT DISTINCT(student_id) FROM enrollment E WHERE teacher_id = '$teacher_id' AND section = '$section' AND course_id = '$course_id'";

    $result = $conn->query($sql);

    if ($result) {
        // Fetch result rows as associative array
        $studentiddata = array();
        while ($row = $result->fetch_assoc()) {
            $studentiddata[] = $row;
        }

        // Return the JSON response
        echo json_encode($studentiddata);
    } else {
        // No attendance records found or an error occurred
        echo json_encode(array('message' => 'Error: ' . $conn->error));
    }
} else {
    // Missing parameters
    echo json_encode(array('message' => 'Missing parameters. Please provide teacher_id, course_id, and section.'));
}

// Close the database connection
$conn->close();
?>
