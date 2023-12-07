<?php

include '../../dbconnection.php';

// Check if "id" is set in the POST request
if (isset($_POST['teacher_id'])) {
    // Assuming you're sending the student_id as a POST parameter
    $teacherID = $_POST['teacher_id'];

    // Sanitize the input to prevent SQL injection
    $teacherID = mysqli_real_escape_string($conn, $teacherID);

    $query = "SELECT DISTINCT(course_id) FROM enrollment E where E.teacher_id = '$teacherID'";

    $result = $conn->query($query);

    if ($result) {
        $courses = array();
        while ($row = $result->fetch_assoc()) {
            $courses[] = $row['course_id'];
        }
        echo json_encode($courses);
    } else {
        echo json_encode(['error' => 'Failed to fetch courses']);
    }
} else {
    echo json_encode(['error' => 'Missing "id" parameter']);
}

$conn->close();

?>
