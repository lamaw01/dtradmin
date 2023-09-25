<?php
require '../db_connect.php';
header('Content-Type: application/json; charset=utf-8');

// make input json
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE);


if($_SERVER['REQUEST_METHOD'] == 'POST' && array_key_exists('sched_id', $input)){
    $sched_id = $input['sched_id'];
    $sched_type = $input['sched_type'];
    $sched_in = $input['sched_in'];
    $break_start = $input['break_start'];
    $break_end = $input['break_end'];
    $sched_out = $input['sched_out'];
    $description = $input['description'];
    $sql = 'INSERT INTO tbl_schedule(sched_id, sched_type, sched_in, break_start, break_end, sched_out, description)
    VALUES (:sched_id,:sched_type,:sched_in,:break_start,:break_end,:sched_out,:description)';

    try {
        $sql_insert = $conn->prepare($sql);
        $sql_insert->bindParam(':sched_id', $sched_id, PDO::PARAM_STR);
        $sql_insert->bindParam(':sched_type', $sched_type, PDO::PARAM_STR);
        $sql_insert->bindParam(':sched_in', $sched_in, PDO::PARAM_STR);
        $sql_insert->bindParam(':break_start', $break_start, PDO::PARAM_STR);
        $sql_insert->bindParam(':break_end', $break_end, PDO::PARAM_STR);
        $sql_insert->bindParam(':sched_out', $sched_out, PDO::PARAM_STR);
        $sql_insert->bindParam(':description', $description, PDO::PARAM_STR);
        $sql_insert->execute();
        echo json_encode(array('success'=>true,'message'=>'ok'));
    } catch (PDOException $e) {
        echo json_encode(array('success'=>false,'message'=>$e->getMessage()));
    } finally{
        // Closing the connection.
        $conn = null;
    }
}else{
    echo json_encode(array('success'=>false,'message'=>'error input'));
    die();
}
?>