<?php

include '../../dbconnection.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $date = $_POST['date'];
    $status = $_POST['status'];
    $courseId = $_POST['course_id'];
    $teacherid = $_POST['teacher_id'];
    $studentId = $_POST['student_id'];

    $conn->begin_transaction();

    try {
        $enrollId = getEnrollId($conn, $studentId, $courseId, $teacherid);

        $insertSql = "INSERT INTO Attendances (enroll_id, dates, status) VALUES (?, ?, ?)";
        $insertStmt = $conn->prepare($insertSql);
        $insertStmt->bind_param("sss", $enrollId, $date, $status);

        if (!$insertStmt->execute()) {
            throw new Exception("Error inserting attendance data: " . $conn->error);
        }

        $conn->commit();
        echo "Attendance data inserted successfully";
    } catch (Exception $e) {
        $conn->rollback();
        echo "Transaction failed: " . $e->getMessage();
    } finally {
        $conn->close();
    }
} else {
    echo "Invalid request method. Only POST requests are allowed.";
}

function getEnrollId($conn, $studentId, $courseId, $teacherid) {
    $sql = "SELECT enroll_id FROM Enrollment 
            WHERE student_id = ? AND course_id = ? AND teacher_id = ?";
    
    $selectStmt = $conn->prepare($sql);
    $selectStmt->bind_param("sss", $studentId, $courseId, $teacherid);
    $selectStmt->execute();

    $result = $selectStmt->get_result();

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        return $row['enroll_id'];
    } else {
        echo "Enrollment not found for the given student and course.";
        exit();
    }
}


    // include '../../dbconnection.php';// Include the database connection script

    // if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    //     // Retrieve data from the request
    //     $date = $_POST['date'];
    //     // $duration = $_POST['duration'];
    //     $status = $_POST['status'];
    //     $courseId = $_POST['course_id'];
    //     $teacherid = $_POST['teacher_id'];
    //     $studentId = $_POST['student_id'];

    //     // Insert data into the Attendance table
    //     $enrollId = getEnrollId($conn, $studentId, $courseId, $teacherid);

    //     $sql = "INSERT INTO Attendances (enroll_id, dates, status) 
    //             VALUES ('$enrollId', '$date', '$status')";

    //     if ($conn->query($sql) === TRUE) {
    //         echo "Attendance data inserted successfully";
    //     } else {
    //         echo "Error: " . $sql . "<br>" . $conn->error;
    //     }
    // } else {
    //     echo "Invalid request method. Only POST requests are allowed.";
    // }

    // // Function to get enroll_id based on student_id and course_id
    // function getEnrollId($conn, $studentId, $courseId, $teacherid) {
    //     $sql = "SELECT enroll_id FROM Enrollment 
    //             WHERE student_id = '$studentId' AND course_id = '$courseId' AND teacher_id = '$teacherid'";

    //     $result = $conn->query($sql);

    //     if ($result->num_rows > 0) {
    //         $row = $result->fetch_assoc();
    //         return $row['enroll_id'];
    //     } else {
    //         echo "Enrollment not found for the given student and course.";
    //         exit();
    //     }
    // }

?>