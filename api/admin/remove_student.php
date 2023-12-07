<?php

include '../dbconnection.php';

$studentId = $_POST['student_id'];

$conn->begin_transaction();

try {
    $deleteStudentSql = "DELETE FROM student_details WHERE id = ?";
    $deleteStudentStmt = $conn->prepare($deleteStudentSql);
    $deleteStudentStmt->bind_param("s", $studentId);

    if (!$deleteStudentStmt->execute()) {
        throw new Exception("Error deleting student data: " . $conn->error);
    }

    $conn->commit();

    echo "Student data deleted successfully.";

} catch (Exception $e) {
    $conn->rollback();
    echo "Transaction failed: " . $e->getMessage();
} finally {
    $conn->close();
}

?>
