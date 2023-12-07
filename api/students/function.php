<?php

require '../dbcon.php';

function getStudentList(){
    global $conn;

    $query = "SELECT * FROM student_details as S,parent_details as P WHERE id = '21K-0000' AND P.student_id = S.id";
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
            return json_encode($res);
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
};

?>