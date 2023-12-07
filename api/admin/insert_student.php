<?php

include '../dbconnection.php';

$studentId = $_POST['student_id'];
$firstName = $_POST['first_name'];
$lastName = $_POST['last_name'];
$section = $_POST['section'];
$degree = $_POST['degree'];
$campus = $_POST['campus'];
$status = $_POST['status'];
$gender = $_POST['gender'];
$dob = $_POST['dob'];
$email = $_POST['email'];
$nationality = $_POST['nationality'];
$phone = $_POST['phone'];
$hashedPassword = $_POST['hashed_password'];

$conn->begin_transaction();

try {
    $insertStudentSql = "INSERT INTO student_details (id, first_name, last_name, section, degree, campus, status, gender, dob, email, nationality, phone, hashed_password)
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    $insertStudentStmt = $conn->prepare($insertStudentSql);
    $insertStudentStmt->bind_param("sssssssssssss", $studentId, $firstName, $lastName, $section, $degree, $campus, $status, $gender, $dob, $email, $nationality, $phone, $hashedPassword);

    if (!$insertStudentStmt->execute()) {
        throw new Exception("Error inserting student data: " . $conn->error);
    }

    $conn->commit();

    echo "Student data inserted successfully.";

} catch (Exception $e) {
    $conn->rollback();
    echo "Transaction failed: " . $e->getMessage();
} finally {
    $conn->close();
}

?>
