<?php

include '../dbconnection.php';

$teacherId = $_POST['teacher_id'];
$firstName = $_POST['first_name'];
$lastName = $_POST['last_name'];
$department = $_POST['department'];
$degree = $_POST['degree'];
$address = $_POST['address'];
$registrationNumber = $_POST['registerNumber'];
$dateOfBirth = $_POST['dateOfBirth'];
$email = $_POST['email'];
$phoneNumber = $_POST['phoneNumber'];
$hashedPassword = $_POST['hashed_password'];
$specialization = $_POST['specialization'];
$experience = $_POST['yearsOfExperience'];
$age = $_POST['age'];

$conn->begin_transaction();

try {
    $insertTeacherSql = "INSERT INTO teacher_details (teacher_id, first_name, last_name, department, degree, address, registerNumber, dateOfBirth, email, phoneNumber, hashed_password, specialization, yearsOfExperience, age)
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    $insertTeacherStmt = $conn->prepare($insertTeacherSql);
    $insertTeacherStmt->bind_param("ssssssssssssss", $teacherId, $firstName, $lastName, $department, $degree, $address, $registrationNumber, $dateOfBirth, $email, $phoneNumber, $hashedPassword, $specialization, $experience, $age);

    if (!$insertTeacherStmt->execute()) {
        throw new Exception("Error inserting teacher data: " . $conn->error);
    }

    $conn->commit();

    echo "Teacher data inserted successfully.";

} catch (Exception $e) {
    $conn->rollback();
    echo "Transaction failed: " . $e->getMessage();
} finally {
    $conn->close();
}
?>
