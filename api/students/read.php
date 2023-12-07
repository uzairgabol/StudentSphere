<?php

header('Access-Control-Allow-Origin:*');
header('Content-Type: application/json');
header('Access-Control-Allow-Method: POST');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-headers, Authorization, X-Request-With');

require '../dbcon.php';

include('function.php');

global $conn;

$requestMethod = $_SERVER["REQUEST_METHOD"];

if($requestMethod == "POST"){
    if(isset($_POST["id"])){
        $id=$_POST["id"];
    }
    else{
        return;
    }
    $query = "SELECT * FROM student_details as S,parent_details as P WHERE S.id = '$id'";
    $query_run = mysqli_query($conn,$query);
    if($query_run){
        if(mysqli_num_rows($query_run) > 0){
            $res = mysqli_fetch_all($query_run, MYSQLI_ASSOC);

            // $data = [
            //     'status' => 200,
            //     'message' => 'Student List Fetched Successfully',
            //     'data' => $res,
            // ];
            // header("HTTP/1.0 200 OK");
            echo json_encode($res);
        }
        else{
            $data = [
                'status' => 404,
                'message' => $requestMethod. 'No Student Found',
            ];
            header("HTTP/1.0 404 No Student Found");
            return json_encode($data);
        }
    }
    else{
        $data = [
            'status' => 500,
            'message' => $requestMethod. 'Internal Server Error',
        ];
        header("HTTP/1.0 500 Internal Server Error");
        return json_encode($data);
    }
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