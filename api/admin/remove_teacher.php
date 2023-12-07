<?php

include '../dbconnection.php';

$teacherId = $_POST['teacher_id'];

$conn->begin_transaction();

try {
    $deleteTeacherSql = "DELETE FROM teacher_details WHERE teacher_id = ?";
    $deleteTeacherStmt = $conn->prepare($deleteTeacherSql);
    $deleteTeacherStmt->bind_param("s", $teacherId);

    if (!$deleteTeacherStmt->execute()) {
        throw new Exception("Error removing teacher: " . $conn->error);
    }

    $conn->commit();

    echo "Teacher removed successfully.";

} catch (Exception $e) {
    $conn->rollback();
    echo "Transaction failed: " . $e->getMessage();
} finally {
    $conn->close();
}

?>
