<?php

include '../dbconnection.php';

$courseId = $_POST['course_id'];

$conn->begin_transaction();

try {
    $deleteCourseSql = "DELETE FROM courses WHERE courseid = ?";
    $deleteCourseStmt = $conn->prepare($deleteCourseSql);
    $deleteCourseStmt->bind_param("s", $courseId);

    if (!$deleteCourseStmt->execute()) {
        throw new Exception("Error removing course: " . $conn->error);
    }

    $conn->commit();

    echo "Course removed successfully.";

} catch (Exception $e) {
    $conn->rollback();
    echo "Transaction failed: " . $e->getMessage();
} finally {
    $conn->close();
}

?>
