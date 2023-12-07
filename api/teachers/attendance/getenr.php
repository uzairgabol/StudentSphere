<?php

include '../../dbconnection.php';

// Set the content type to JSON
header('Content-Type: application/json');

// Check if teacher_id, course_id, and student_id are provided in the request
if (isset($_POST['teacher_id']) && isset($_POST['course_id']) && isset($_POST['student_id'])) {
    $teacher_id = $_POST['teacher_id'];
    $course_id = $_POST['course_id'];
    $student_id = $_POST['student_id'];

    // Call the stored procedure to get enroll_id
    $sql = "CALL GetEnrollId(?, ?, ?, @enroll_id)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param('sss', $student_id, $course_id, $teacher_id);
    $stmt->execute();
    $stmt->close();

    // Retrieve the output parameter
    $result = $conn->query("SELECT @enroll_id AS enroll_id");
    $row = $result->fetch_assoc();
    $enroll_id = $row['enroll_id'];

    // Return the JSON response with enroll_id
    echo json_encode(array('enroll_id' => $enroll_id));
} else {
    // Missing parameters
    echo json_encode(array('message' => 'Missing parameters. Please provide teacher_id, course_id, and student_id.'));
}

// Close the database connection
$conn->close();
?>
