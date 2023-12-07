<?php


include '../../dbconnection.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $date = $_POST['date'];
    $courseId = $_POST['course_id'];
    $teacherid = $_POST['teacher_id'];
    $studentId = $_POST['student_id'];

    $conn->begin_transaction();

    try {
        $enrollId = getEnrollId($conn, $studentId, $courseId, $teacherid);

        $sql = "DELETE FROM attendances WHERE enroll_id = ? AND dates = ?";
        $deleteStmt = $conn->prepare($sql);
        $deleteStmt->bind_param("ss", $enrollId, $date);

        if (!$deleteStmt->execute()) {
            throw new Exception("Error deleting attendance data: " . $conn->error);
        }

        $conn->commit();
        echo "Attendance data deleted successfully";
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
        echo "Enrollment not found for the given student and course.";
        exit();
    }
}

    // include '../../dbconnection.php';// Include the database connection script

    // if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    //     // Retrieve data from the request
    //     $date = $_POST['date'];
    //     // $duration = $_POST['duration'];
    //     $courseId = $_POST['course_id'];
    //     $teacherid = $_POST['teacher_id'];
    //     $studentId = $_POST['student_id'];

    //     // Insert data into the Attendance table
    //     $enrollId = getEnrollId($conn, $studentId, $courseId, $teacherid);

    //     $sql = "DELETE FROM attendances WHERE enroll_id = '$enrollId' AND dates = '$date'";

    //     if ($conn->query($sql) === TRUE) {
    //         echo "Attendance data deleted successfully";
    //     } else {
    //         echo "Error: " . $sql . "<br>" . $conn->error;
    //     }
    // } else {
    //     echo "Invalid request method. Only POST requests are allowed.";
    // }

    // // Function to get enroll_id based on student_id and course_id
    // function getEnrollId($conn, $studentId, $courseId, $teacherid) {
    //     $sql = "SELECT enroll_id FROM Enrollment 
    //             WHERE student_id = '$studentId' AND course_id = '$courseId' AND teacher_id = '$teacherid'";

    //     $result = $conn->query($sql);

    //     if ($result->num_rows > 0) {
    //         $row = $result->fetch_assoc();
    //         return $row['enroll_id'];
    //     } else {
    //         echo "Enrollment not found for the given student and course.";
    //         exit();
    //     }
    // }

?>