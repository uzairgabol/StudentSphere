<?php

include '../dbconnection.php';

$student_id = $_POST['student_id'];
$teacher_id = $_POST['teacher_id'];
$section = $_POST['section'];
$course_id = $_POST['course_id'];
$admin_id = $_POST['admin_id'];

$conn->begin_transaction();

try {
    // Check if student exists
    $checkStudentSql = "SELECT id FROM student_details WHERE id = ?";
    $checkStudentStmt = $conn->prepare($checkStudentSql);
    $checkStudentStmt->bind_param("s", $student_id);
    $checkStudentStmt->execute();
    $checkStudentResult = $checkStudentStmt->get_result();

    if ($checkStudentResult->num_rows == 0) {
        throw new Exception("Student not found.");
    }

    // Check if teacher exists
    $checkTeacherSql = "SELECT teacher_id FROM teacher_details WHERE teacher_id = ?";
    $checkTeacherStmt = $conn->prepare($checkTeacherSql);
    $checkTeacherStmt->bind_param("s", $teacher_id);
    $checkTeacherStmt->execute();
    $checkTeacherResult = $checkTeacherStmt->get_result();

    if ($checkTeacherResult->num_rows == 0) {
        throw new Exception("Teacher not found.");
    }

    $checkCourseSql = "SELECT courseid FROM courses WHERE courseid = ?";
    $checkCourseStmt = $conn->prepare($checkCourseSql);
    $checkCourseStmt->bind_param("s", $course_id);
    $checkCourseStmt->execute();
    $checkCourseResult = $checkCourseStmt->get_result();

    if ($checkCourseResult->num_rows == 0) {
        throw new Exception("Course not found.");
    }

    // Check if section exists
    $checkSectionSql = "SELECT section_id FROM section WHERE section_id = ?";
    $checkSectionStmt = $conn->prepare($checkSectionSql);
    $checkSectionStmt->bind_param("s", $section);
    $checkSectionStmt->execute();
    $checkSectionResult = $checkSectionStmt->get_result();

    if ($checkSectionResult->num_rows == 0) {
        throw new Exception("Section not found.");
    }

    // Check if enrollment already exists
    $checkEnrollmentSql = "SELECT * FROM enrollment WHERE student_id = ? AND teacher_id = ? AND course_id = ?";
    $checkEnrollmentStmt = $conn->prepare($checkEnrollmentSql);
    $checkEnrollmentStmt->bind_param("sss", $student_id, $teacher_id, $course_id);
    $checkEnrollmentStmt->execute();
    $checkEnrollmentResult = $checkEnrollmentStmt->get_result();

    if ($checkEnrollmentResult->num_rows > 0) {
        throw new Exception("Enrollment already exists.");
    }

    // Insert enrollment
    $insertEnrollmentSql = "INSERT INTO enrollment (student_id, course_id, teacher_id, section, admin_id) VALUES (?, ?, ?, ?, ?)";
    $insertEnrollmentStmt = $conn->prepare($insertEnrollmentSql);
    $insertEnrollmentStmt->bind_param("sssss", $student_id, $course_id, $teacher_id, $section, $admin_id);

    if (!$insertEnrollmentStmt->execute()) {
        throw new Exception("Error inserting enrollment: " . $conn->error);
    }

    $conn->commit();

    echo "Enrollment registered successfully.";

} catch (Exception $e) {
    $conn->rollback();
    echo "Error: " . $e->getMessage();
} finally {
    $conn->close();
}

?>
