<?php

include '../../dbconnection.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve data from the request
    $teacher_id = $_POST['teacher_id'];
    $course_id = $_POST['course_id'];
    $section = $_POST['section'];

    $enrollId = getEnrollId($conn, $teacher_id, $section, $course_id);

    $sql = "SELECT DISTINCT(main_label) FROM marks WHERE enroll_id = '$enrollId'";
    
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $labels = [];
        while ($row = $result->fetch_assoc()) {
            $labels[] = $row['main_label'];
        }
        
        echo json_encode($labels);
    } else {
        echo "No labels found for the given teacher and section.";
    }
}

// Function to get enroll_id based on student_id and course_id
function getEnrollId($conn, $teacher_id, $section, $course_id) {
    $sql = "SELECT enroll_id FROM enrollment WHERE teacher_id = '$teacher_id' AND course_id = '$course_id' AND section = '$section' LIMIT 1";

    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        return $row['enroll_id'];
    } else {
        echo "Enrollment not found for the given student and course.";
        exit();
    }
}

?>
