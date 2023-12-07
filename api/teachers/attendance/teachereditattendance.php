<?php

include '../../dbconnection.php';

// Check if "id" is set in the POST request
if (isset($_POST['teacher_id']) && isset($_POST['course_id']) && isset($_POST['section'])) {
    // Assuming you're sending the student_id as a POST parameter
    $teacherID = $_POST['teacher_id'];
    $courseID = $_POST['course_id'];
    $sectionID = $_POST['section'];
    $date = $_POST['date'];

    // Sanitize the input to prevent SQL injection
    $teacherID = mysqli_real_escape_string($conn, $teacherID);
    $courseID = mysqli_real_escape_string($conn, $courseID);
    $sectionID = mysqli_real_escape_string($conn, $sectionID);

    $query = "SELECT E.student_id, A.status FROM attendances A JOIN enrollment E ON E.enroll_id = A.enroll_id where E.teacher_id = '$teacherID' AND E.course_id = '$courseID' AND E.section = '$sectionID' AND A.dates = '$date'";

    $result = $conn->query($query);

    if ($result->num_rows > 0) {
        // Fetch result rows as associative array
        $studentData = array();
        while ($row = $result->fetch_assoc()) {
            $studentData[] = $row;
        }

        // Return the JSON response
        echo json_encode($studentData);
    } else {
        echo json_encode(['error' => 'Failed to fetch student records']);
    }
} else {
    echo json_encode(['error' => 'Missing "id" parameter']);
}

$conn->close();

?>