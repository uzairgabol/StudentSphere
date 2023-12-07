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
    if(isset($_POST["first_name"])){
        $first_name=$_POST["first_name"];
    }
    else{
        return;
    }
    if(isset($_POST["last_name"])){
        $last_name=$_POST["last_name"];
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
    $query = "INSERT INTO `student_details` (`id`, `password`, `first_name`, `last_name`) VALUES ('$id','$password','$first_name','$last_name')";
    $query_run = mysqli_query($conn,$query);
    $arr=[];

    if($query_run){
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