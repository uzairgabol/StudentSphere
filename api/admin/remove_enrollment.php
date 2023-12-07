<?php

include '../dbconnection.php';

$student_id = $_POST['student_id'];
$course_id = $_POST['course_id'];

// Begin transaction
$conn->begin_transaction();

try {
    // First, check if the enrollment record exists
    $checkQuery = "SELECT * FROM enrollment WHERE student_id = '$student_id' AND course_id = '$course_id'";
    $checkResult = $conn->query($checkQuery);

    if ($checkResult->num_rows === 0) {
        throw new Exception("Enrollment record not found.");
    }

    // If the record exists, proceed with deletion
    $deleteQuery = "DELETE FROM enrollment WHERE student_id = '$student_id' AND course_id = '$course_id'";
    $deleteResult = $conn->query($deleteQuery);

    if (!$deleteResult) {
        throw new Exception("Error deleting enrollment record: " . $conn->error);
    }

    // Commit the transaction
    $conn->commit();
    echo "Success";
} catch (Exception $e) {
    // An error occurred, rollback the transaction
    $conn->rollback();
    echo "Error: " . $e->getMessage(); // Send an error message to the client
}

// Close connection
$conn->close();

?>
