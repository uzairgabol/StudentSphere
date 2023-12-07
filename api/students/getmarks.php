<?php

// include '../dbconnection.php'; // Include the database connection script

// if ($_SERVER['REQUEST_METHOD'] === 'POST') {
//     // Retrieve data from the request
//     $courseId = $_POST['course_id'];
//     $studentId = $_POST['student_id'];

//     // Insert data into the Attendance table
//     $enrollId = getEnrollId($conn, $studentId, $courseId);

//     $sql = "SELECT main_label, label_index, weightage, obtained_marks, total_marks FROM marks M JOIN enrollment E ON E.enroll_id = M.enroll_id WHERE E.enroll_id = '$enrollId'";
    
//     $result = $conn->query($sql);

//     if ($result->num_rows > 0) {
//         $marksData = array();
//         while ($row = $result->fetch_assoc()) {
//             $marksData[] = $row;
//         }

//         echo json_encode($marksData);
//     } else {
//         echo "No marks found for the given student and course.";
//     }
// }

// // Function to get enroll_id based on student_id and course_id
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

include '../dbconnection.php'; // Include the database connection script

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve data from the request
    $courseId = $_POST['course_id'];
    $studentId = $_POST['student_id'];

    // Call the stored procedure to get enroll_id
    $enrollId = getEnrollIdStudent($conn, $studentId, $courseId);
    

    // Check if the stored procedure was successful
    if ($enrollId !== null) {
        // Continue with your existing code
        $sql = "SELECT main_label, label_index, weightage, obtained_marks, total_marks FROM marks M JOIN enrollment E ON E.enroll_id = M.enroll_id WHERE E.enroll_id = '$enrollId'";
        
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $marksData = array();
            while ($row = $result->fetch_assoc()) {
                $marksData[] = $row;
            }

            echo json_encode($marksData);
        } else {
            echo "No marks found for the given student and course.";
        }
    }
}

// Function to call the stored procedure getEnrollIdStudent
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