<?php

include '../dbconnection.php';

$alumniId = $_POST['alumni_id'];
$studentId = $_POST['student_id'];
$date = $_POST['date'];
$time = $_POST['time'];

$conn->begin_transaction();

try {
    $updateSql = "UPDATE alumnidates SET status = 'Booked', student_id = ? WHERE alumni_id = ? AND date = ? AND time = ?";
    $updateStmt = $conn->prepare($updateSql);
    $updateStmt->bind_param("ssss", $studentId, $alumniId, $date, $time);
    
    if (!$updateStmt->execute()) {
        throw new Exception("Error updating booking: " . $conn->error);
    }

    $deleteSql = "DELETE FROM available_dates_alumni_view WHERE alumni_id = ? AND date = ? AND time = ?";
    $deleteStmt = $conn->prepare($deleteSql);
    $deleteStmt->bind_param("sss", $alumniId, $date, $time);
    
    if (!$deleteStmt->execute()) {
        throw new Exception("Error deleting record: " . $conn->error);
    }

    $conn->commit();
    
    echo "Booking updated successfully";
} catch (Exception $e) {
    $conn->rollback();
    echo "Transaction failed: " . $e->getMessage();
} finally {
    $conn->close();
}













// include '../dbconnection.php';

// $alumniId = $_POST['alumni_id'];
// $studentId = $_POST['student_id'];
// $date = $_POST['date'];
// $time = $_POST['time'];


// $sql = "UPDATE alumnidates SET status = 'Booked', student_id = '$studentId' WHERE alumni_id = $alumniId AND date = '$date' AND time = '$time'";

// if ($conn->query($sql) === TRUE) {
//     echo "Booking updated successfully";
// } else {
//     echo "Error updating booking: " . $conn->error;
// }

// // Close connection
// $conn->close();

// include '../dbconnection.php';

// if ($_SERVER['REQUEST_METHOD'] === 'POST') {
//     $alumniId = $_POST['alumni_id'];
//     $studentId = $_POST['student_id'];
//     $date = $_POST['date'];
//     $time = $_POST['time'];


//     // Now, delete from the view (my_view)
//     $deleteQuery = "DELETE FROM available_dates_alumni_view WHERE alumni_id = '$alumniId' AND date = '$date' AND time = '$time'";
//     $res = $conn->query($deleteQuery);
//     if(!$res){
//         echo "No record exists";
//         conn->close();
//         return;
//     }

//     $updateQuery = "UPDATE alumnidates SET status = 'Booked', student_id = '$studentId' WHERE alumni_id = '$alumniId' AND date = '$date' AND time = '$time'";
//     $result = $conn->query($updateQuery);

//     // Check if the deletion was successful
//     if ($result) {
//         echo "Booking updated successfully";
//     } else {
//         echo "Error updating booking: " . $conn->error;
//     }

//     // Close connection
//     $conn->close();
// }
?>