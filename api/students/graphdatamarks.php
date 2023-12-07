<?php

include '../dbconnection.php';

// Check if the request method is POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Assuming you have 'student_id' and 'course_id' parameters in your POST request
    $studentId = $_POST['student_id'];
    $courseId = $_POST['course_id'];

    // Call the stored procedure to get enroll_id
    $stmtEnrollId = $conn->prepare("CALL getEnrollIdStudent(?, ?, @enrollId)");
    $stmtEnrollId->bind_param('ss', $studentId, $courseId);
    $stmtEnrollId->execute();
    $stmtEnrollId->close();

    // Retrieve the output parameter
    $resultEnrollId = $conn->query("SELECT @enrollId AS enrollId");
    $rowEnrollId = $resultEnrollId->fetch_assoc();

    // Get the enroll_id from the result
    $enrollId = $rowEnrollId['enrollId'];

    // Check if enroll_id is obtained successfully
    if (!$enrollId) {
        echo json_encode(['error' => 'Unable to retrieve enroll_id']);
        exit;
    }

    // Now, call the procedure to calculate total marks using the obtained enroll_id
    $stmtCalculateMarks = $conn->prepare("CALL CalculateMarksTotal(?, @totalTotal, @totalObtained)");
    $stmtCalculateMarks->bind_param('i', $enrollId);
    $stmtCalculateMarks->execute();
    $stmtCalculateMarks->close();

    // Retrieve the output parameters
    $result = $conn->query("SELECT @totalTotal AS totalTotalMarks, @totalObtained AS totalObtainedMarks");
    $row = $result->fetch_assoc();

    // Return the result as JSON
    echo json_encode($row);

    // Close connection
    $conn->close();
} else {
    // If the request method is not POST, return an error message
    echo json_encode(['error' => 'Invalid request method']);
}
