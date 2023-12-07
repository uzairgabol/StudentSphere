<?php
// include '../../dbconnection.php'; // Include the database connection script

// if ($_SERVER['REQUEST_METHOD'] === 'POST') {
//     // Retrieve data from the request
//     $weightage = $_POST['weightage'];
//     $totalMarks = $_POST['total_marks'];
//     $mainLabel = $_POST['main_label'];
//     $labelIndex = $_POST['label_index'];
//     $courseId = $_POST['course_id'];
//     $teacherid = $_POST['teacher_id'];
//     $studentId = $_POST['student_id'];
//     $obtainedMarks = $_POST['obtained_marks'];

//     // Update or insert data into the Attendance table
//     $enrollId = getEnrollId($conn, $studentId, $courseId, $teacherid);

//     if ($enrollId) {
//         // Check if attendance record already exists for the given date
//         $checkSql = "SELECT * FROM marks WHERE enroll_id = '$enrollId' AND main_label = '$mainLabel' AND label_index = '$labelIndex' AND weightage = '$weightage' AND total_marks = '$totalMarks'";
//         $checkResult = $conn->query($checkSql);

//         if ($checkResult->num_rows > 0) {
//             // Update the status if the record exists
//             $updateSql = "UPDATE marks SET obtained_marks = '$obtainedMarks' WHERE enroll_id = '$enrollId' AND main_label = '$mainLabel' AND label_index = '$labelIndex' AND weightage = '$weightage' AND total_marks = '$totalMarks'";
//             if ($conn->query($updateSql) === TRUE) {
//                 echo "Marks data updated successfully";
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
include '../../dbconnection.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve data from the request
    $weightage = $_POST['weightage'];
    $totalMarks = $_POST['total_marks'];
    $mainLabel = $_POST['main_label'];
    $labelIndex = $_POST['label_index'];
    $courseId = $_POST['course_id'];
    $teacherid = $_POST['teacher_id'];
    $studentId = $_POST['student_id'];
    $obtainedMarks = $_POST['obtained_marks'];

    $enrollId = getEnrollId($conn, $studentId, $courseId, $teacherid);

    if(!$enrollId){
        echo json_encode("No enrollments found");
        return;
    }

    // Start a transaction
    mysqli_begin_transaction($conn);


    $updateSql = "UPDATE marks SET obtained_marks = '$obtainedMarks' WHERE enroll_id = '$enrollId' AND main_label = '$mainLabel' AND label_index = '$labelIndex' AND weightage = '$weightage' AND total_marks = '$totalMarks'";
    $conn->query($updateSql);



    $errorCheckSql = "SELECT * FROM trigger_log";
    $errorCheckResult = $conn->query($errorCheckSql);
    if ($errorCheckResult->num_rows > 0) {
        echo json_encode("Incorrect Obtained Marks entered for $studentId");
        mysqli_rollback($conn);
    } else {
        mysqli_commit($conn);
        echo "Marks data updated successfully";
    }

} 
else 
{
    echo "Invalid request method. Only POST requests are allowed.";
}

function getEnrollId($conn, $studentId, $courseId, $teacherid) {
    $sql = "SELECT enroll_id FROM Enrollment 
            WHERE student_id = '$studentId' AND course_id = '$courseId' AND teacher_id = '$teacherid'";

    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        return $row['enroll_id'];
    } else {
        return null;
    }
}
?>