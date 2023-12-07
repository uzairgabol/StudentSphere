<?php

include '../dbconnection.php';

$courseId = $_POST['course_id'];
$courseName = $_POST['course_name'];

$conn->begin_transaction();

try {
    $insertCourseSql = "INSERT INTO courses (courseid, coursename)
                        VALUES (?, ?)";
    $insertCourseStmt = $conn->prepare($insertCourseSql);
    $insertCourseStmt->bind_param("ss", $courseId, $courseName);

    if (!$insertCourseStmt->execute()) {
        throw new Exception("Error inserting course data: " . $conn->error);
    }

    $conn->commit();

    echo "Course data inserted successfully.";

} catch (Exception $e) {
    $conn->rollback();
    echo "Transaction failed: " . $e->getMessage();
} finally {
    $conn->close();
}

?>
