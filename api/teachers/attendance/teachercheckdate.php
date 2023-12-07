<?php

include '../../dbconnection.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve data from the request
    $date = $_POST['date'];
    $courseId = $_POST['course_id'];
    $teacherid = $_POST['teacher_id'];
    $section = $_POST['section'];

    // Get enroll_id based on the provided parameters
    $enrollId = getEnrollId($conn, $section, $courseId, $teacherid);

    // Check if attendance record exists
    $sql = "SELECT * FROM attendances WHERE enroll_id = '$enrollId' AND dates = '$date'";
    $result = $conn->query($sql);

    if ($result !== false && $result->num_rows > 0) {
        // Attendance record exists
        echo json_encode(array('result' => true));
    } else {
        // Attendance record does not exist
        echo json_encode(array('result' => false));
    }
} else {
    echo "Invalid request method. Only POST requests are allowed.";
}

// Function to get enroll_id based on student_id and course_id
function getEnrollId($conn, $section, $courseId, $teacherid) {
    $sql = "SELECT * FROM enrollment WHERE teacher_id = '$teacherid' AND course_id = '$courseId' AND section = '$section' LIMIT 1";
    $result = $conn->query($sql);

    if ($result !== false && $result->num_rows > 0) {
        $row = $result->fetch_assoc();
        return $row['enroll_id'];
    } else {
        echo "Enrollment not found for the given student and course.";
        exit();
    }
}

?>
