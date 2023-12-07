<?php

include '../../dbconnection.php';

// Set the content type to JSON
header('Content-Type: application/json');

// Check if teacher_id and subject_id are provided in the request
if (isset($_POST['teacher_id']) && isset($_POST['course_id']) && isset($_POST['section'])) {
    $teacher_id = $_POST['teacher_id'];
    $course_id = $_POST['course_id'];
    $section = $_POST['section'];

    // Query to retrieve attendance records for the specified student and subject
    $sql = "SELECT DISTINCT DATE_FORMAT(dates, '%d-%b-%Y') AS dates 
        FROM attendances A 
        JOIN enrollment E ON E.enroll_id = A.enroll_id 
        WHERE E.teacher_id = '$teacher_id' AND E.course_id = '$course_id' AND E.section = '$section' 
        ORDER BY dates";

    $result = $conn->query($sql);

    if ($result) {
        // Fetch result rows as associative array
        $attendanceData = array();
        while ($row = $result->fetch_assoc()) {
            $attendanceData[] = $row;
        }

        // Return the JSON response
        echo json_encode($attendanceData);
    } else {
        // No attendance records found or an error occurred
        echo json_encode(array('message' => 'Error: ' . $conn->error));
    }
} else {
    // Missing parameters
    echo json_encode(array('message' => 'Missing parameters. Please provide teacher_id, course_id, and section.'));
}

// Close the database connection
$conn->close();


// include '../../dbconnection.php';

// // Set the content type to JSON
// header('Content-Type: application/json');


// // Check if teacher_id and subject_id are provided in the request
// if (isset($_POST['teacher_id']) && isset($_POST['course_id']) && isset($_POST['section'])) {
//     $teacher_id = $_POST['teacher_id'];
//     $course_id = $_POST['course_id'];
//     $section = $_POST['section'];

//     // Query to retrieve attendance records for the specified student and subject
    
//     $sql = "SELECT DISTINCT(DATE_FORMAT(dates, '%d-%b-%Y')) AS dates FROM attendance A JOIN enrollment E ON E.enroll_id = A.enroll_id WHERE E.teacher_id = '$teacher_id' AND E.course_id = '$course_id' AND E.section = '$section' ORDER BY A.dates";

//     $result = $conn->query($sql);

//     if ($result->num_rows > 0) {
//         // Fetch result rows as associative array
//         $attendanceData = array();
//         while ($row = $result->fetch_assoc()) {
//             $attendanceData[] = $row;
//         }

//         // Return the JSON response
//         echo json_encode($attendanceData);
//     } else {
//         // No attendance records found
//         echo json_encode(array('message' => 'No attendance records found for the specified student and subject.'));
//     }
// } else {
//     // Missing parameters
//     echo json_encode(array('message' => 'Missing parameters. Please provide teacher_id and subject_id.'));
// }

// // Close the database connection
// $conn->close();
?>
