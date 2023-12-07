<?php

include '../dbconnection.php';

$requestMethod = $_SERVER["REQUEST_METHOD"];


if($requestMethod == 'POST'){
    if(isset($_POST["teacher_id"])){
        $id=$_POST["teacher_id"];
    }
    else{
        return;
    }
    if(isset($_POST["password"])){
        $password=$_POST["password"];
    }
    else{
        return;
    }
    $query = "SELECT `teacher_id`, `hashed_password` FROM `teacher_details` WHERE `teacher_id` = '$id' AND `hashed_password` = '$password'";

    $query_run = mysqli_query($conn,$query);
    $arr=[];

    if(mysqli_num_rows($query_run) > 0){
        // while($row=mysqli_fetch_array($query_run)){
        //     $arr = $row;
        // }
        $arr["success"] = "true";
    }
    else{
        $arr["success"] = "false";
    }

    echo json_encode($arr);

}
else{
    $data = [
        'status' => 405,
        'message' => $requestMethod. 'Method Not Allowed',
    ];
    header("HTTP/1.0 405 Method Not Allowed");
    echo json_encode($data);
}

?>