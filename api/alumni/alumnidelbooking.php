<?php



include '../dbconnection.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $alumni_id = $_POST["alumni_id"];
    $date = $_POST["date"];
    $time = $_POST["time"];

    $conn->begin_transaction();

    try {
        $updateSql = "UPDATE alumnidates SET status = 'Not Booked', student_id = NULL WHERE alumni_id = ? AND date = ? AND time = ?";
        $updateStmt = $conn->prepare($updateSql);
        $updateStmt->bind_param("sss", $alumni_id, $date, $time);

        if (!$updateStmt->execute()) {
            throw new Exception("Error updating record: " . $conn->error);
        }

        $conn->commit();
        echo "Record updated successfully";
    } catch (Exception $e) {
        $conn->rollback();
        echo "Transaction failed: " . $e->getMessage();
    } finally {
        $conn->close();
    }
} else {
    echo "Invalid request method";
}


// include '../dbconnection.php';

// // Handle POST request
// if ($_SERVER["REQUEST_METHOD"] == "POST") {
//     $alumni_id = $_POST["alumni_id"];
//     $date = $_POST["date"];
//     $time = $_POST["time"];

//     // Update query
//     $sql = "UPDATE alumnidates SET status = 'Not Booked', student_id = NULL WHERE alumni_id = $alumni_id AND date = '$date' AND time = '$time'";

//     if ($conn->query($sql) === TRUE) {
//         echo "Record updated successfully";
//     } else {
//         echo "Error updating record: " . $conn->error;
//     }
// } else {
//     echo "Invalid request method";
// }

// $conn->close();

?>
