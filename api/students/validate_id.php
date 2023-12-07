<?php

header('Access-Control-Allow-Origin:*');
header('Content-Type: application/json');
header('Access-Control-Allow-Method: POST');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-headers, Authorization, X-Request-With');

include('function.php');

$requestMethod = $_SERVER["REQUEST_METHOD"];

if($requestMethod == 'POST'){
    if(isset($_POST["id"])){
        $id=$_POST["id"];
    }
    else{
        return;
    }
    $query = "SELECT * FROM student_details WHERE id = '$id' ";

    $query_run = mysqli_query($conn,$query);

    $arr=[];

    if(mysqli_num_rows($query_run) > 0){
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