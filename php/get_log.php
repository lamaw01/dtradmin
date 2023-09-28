<?php
require '../db_connect.php';
header('Content-Type: application/json; charset=utf-8');

// make input json
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE);

// if not put id die
if($_SERVER['REQUEST_METHOD'] == 'POST'){
    $id = $input['id'];

    $sql_no_id = "SELECT id,employee_id,log_type,device_id,address,latlng,(case tbl_logs.is_selfie when 0 then tbl_logs.time_stamp when 1 then tbl_logs.selfie_timestamp end) as time_stamp,team,is_selfie,app,version FROM tbl_logs ORDER BY id DESC LIMIT 100;";

    $sql_with_id = "SELECT id,employee_id,log_type,device_id,address,latlng,(case tbl_logs.is_selfie when 0 then tbl_logs.time_stamp when 1 then tbl_logs.selfie_timestamp end) as time_stamp,team,is_selfie,app,version FROM tbl_logs WHERE id < :id ORDER BY id DESC LIMIT 100;";

    try {
        if($id == null){
            $get_sql = $conn->prepare($sql_no_id);
        }else{
            $get_sql = $conn->prepare($sql_with_id);
        }
        if($id != null){
            $get_sql->bindParam(':id', $id, PDO::PARAM_STR);
        }
        $get_sql->execute();
        $result_get_sql = $get_sql->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($result_get_sql);
    } catch (PDOException $e) {
        echo json_encode(array('success'=>false,'message'=>$e->getMessage()));
    } finally{
        // Closing the connection.
        $conn = null;
    }
}
else{
    echo json_encode(array('success'=>false,'message'=>'Error input'));
    die();
}
?>