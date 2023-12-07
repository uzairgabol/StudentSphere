<?php


include '../dbconnection.php';

header('Content-Type: application/json');

if (isset($_POST['student_id']) && isset($_POST['course_id'])) {
    $student_id = $_POST['student_id'];
    $course_id = $_POST['course_id'];

    $sql = "SELECT DATE_FORMAT(dates, '%d-%b-%Y') AS dates, A.status FROM attendances A JOIN enrollment E ON E.enroll_id = A.enroll_id WHERE E.student_id = '$student_id' AND E.course_id = '$course_id' ORDER BY A.dates";

    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        
        $attendanceData = array();
        while ($row = $result->fetch_assoc()) {
            $attendanceData[] = $row;
        }

        
        echo json_encode($attendanceData);
    } else {
        
        echo json_encode(array('message' => 'No attendance records found for the specified student and subject.'));
    }
} else {
    // Missing parameters
    echo json_encode(array('message' => 'Missing parameters. Please provide student_id and subject_id.'));
}

// Close the database connection
$conn->close();

// include '../dbconnection.php';

// // Set the content type to JSON
// header('Content-Type: application/json');


// // Check if student_id and subject_id are provided in the request
// if (isset($_POST['student_id'])) {
//     $student_id = $_POST['student_id'];
//     //$course_id = $_POST['course_id'];

//     // Query to retrieve attendance records for the specified student and subject
//     $sql = "SELECT E.course_id, DATE_FORMAT(dates, '%d-%b-%Y') AS dates, A.status FROM attendance A JOIN enrollment E ON E.enroll_id = A.enroll_id WHERE E.student_id = '$student_id' ORDER BY A.dates";

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
//     echo json_encode(array('message' => 'Missing parameters. Please provide student_id and subject_id.'));
// }

// // Close the database connection
// $conn->close();
?>
