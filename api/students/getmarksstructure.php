<?php

include '../dbconnection.php';// Include the database connection script

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve data from the request
    $courseId = $_POST['course_id'];
    $studentId = $_POST['student_id'];

    $enrollId = getEnrollIdStudent($conn, $studentId, $courseId);

    $sql = "SELECT DISTINCT(main_label) FROM marks M JOIN enrollment E on E.enroll_id = M.enroll_id where E.enroll_id = '$enrollId'";
    
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $labels = [];
        while ($row = $result->fetch_assoc()) {
            $labels[] = $row['main_label'];
        }
        
        echo json_encode([$courseId => $labels]);
    } else {
        echo "No labels found for the given student and course.";
    }
}

// Function to get enroll_id based on student_id and course_id
// function getEnrollId($conn, $studentId, $courseId) {
//     $sql = "SELECT enroll_id FROM Enrollment 
//             WHERE student_id = '$studentId' AND course_id = '$courseId'";

//     $result = $conn->query($sql);

//     if ($result->num_rows > 0) {
//         $row = $result->fetch_assoc();
//         return $row['enroll_id'];
//     } else {
//         echo "Enrollment not found for the given student and course.";
//         exit();
//     }
// }
function getEnrollIdStudent($conn, $studentId, $courseId) {
    $stmt = $conn->prepare("CALL getEnrollIdStudent(?, ?, @enrollId)");
    $stmt->bind_param("ss", $studentId, $courseId);
    $stmt->execute();

    // Fetch the result from the stored procedure
    $result = $conn->query("SELECT @enrollId as enrollId");
    $row = $result->fetch_assoc();

    // Return the value of enrollId
    return $row['enrollId'];
}

?>
