<?php

include '../../dbconnection.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $status = $_POST['status'];
    $date = $_POST['date'];
    $courseId = $_POST['course_id'];
    $teacherid = $_POST['teacher_id'];
    $studentId = $_POST['student_id'];

    $conn->begin_transaction();

    try {
        $enrollId = getEnrollId($conn, $studentId, $courseId, $teacherid);

        if ($enrollId) {
            $checkSql = "SELECT * FROM Attendances WHERE enroll_id = ? AND dates = ?";
            $checkStmt = $conn->prepare($checkSql);
            $checkStmt->bind_param("ss", $enrollId, $date);
            $checkStmt->execute();
            $checkResult = $checkStmt->get_result();

            if ($checkResult->num_rows > 0) {
                // Update the status if the record exists
                $updateSql = "UPDATE Attendances SET status = ? WHERE enroll_id = ? AND dates = ?";
                $updateStmt = $conn->prepare($updateSql);
                $updateStmt->bind_param("sss", $status, $enrollId, $date);

                if (!$updateStmt->execute()) {
                    throw new Exception("Error updating record: " . $conn->error);
                }
            } else {
                // Insert a new record if it doesn't exist
                $insertSql = "INSERT INTO Attendances (enroll_id, dates, duration, status) 
                              VALUES (?, ?, '1', ?)";
                $insertStmt = $conn->prepare($insertSql);
                $insertStmt->bind_param("sss", $enrollId, $date, $status);

                if (!$insertStmt->execute()) {
                    throw new Exception("Error inserting record: " . $conn->error);
                }
            }
        } else {
            echo "Enrollment not found for the given student, course, and teacher.";
        }

        $conn->commit();
        echo "Attendance data processed successfully";
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
        return null;
    }
}


// include '../../dbconnection.php'; // Include the database connection script

// if ($_SERVER['REQUEST_METHOD'] === 'POST') {
//     // Retrieve data from the request
//     $status = $_POST['status'];
//     $date = $_POST['date'];
//     $courseId = $_POST['course_id'];
//     $teacherid = $_POST['teacher_id'];
//     $studentId = $_POST['student_id'];

//     // Update or insert data into the Attendance table
//     $enrollId = getEnrollId($conn, $studentId, $courseId, $teacherid);

//     if ($enrollId) {
//         // Check if attendance record already exists for the given date
//         $checkSql = "SELECT * FROM Attendances WHERE enroll_id = '$enrollId' AND dates = '$date'";
//         $checkResult = $conn->query($checkSql);

//         if ($checkResult->num_rows > 0) {
//             // Update the status if the record exists
//             $updateSql = "UPDATE Attendances SET status = '$status' WHERE enroll_id = '$enrollId' AND dates = '$date'";
//             if ($conn->query($updateSql) === TRUE) {
//                 echo "Attendance data updated successfully";
//             } else {
//                 echo "Error updating record: " . $conn->error;
//             }
//         } else {
//             // Insert a new record if it doesn't exist
//             $insertSql = "INSERT INTO Attendance (enroll_id, dates, duration, status) 
//                           VALUES ('$enrollId', '$date', '1', '$status')";
//             if ($conn->query($insertSql) === TRUE) {
//                 echo "Attendance data inserted successfully";
//             } else {
//                 echo "Error inserting record: " . $conn->error;
//             }
//         }
//     } else {
//         echo "Enrollment not found for the given student, course, and teacher.";
//     }
// } else {
//     echo "Invalid request method. Only POST requests are allowed.";
// }

// // Function to get enroll_id based on student_id, course_id, and teacher_id
// function getEnrollId($conn, $studentId, $courseId, $teacherid) {
//     $sql = "SELECT enroll_id FROM Enrollment 
//             WHERE student_id = '$studentId' AND course_id = '$courseId' AND teacher_id = '$teacherid'";

//     $result = $conn->query($sql);

//     if ($result->num_rows > 0) {
//         $row = $result->fetch_assoc();
//         return $row['enroll_id'];
//     } else {
//         return null;
//     }
// }
?>
