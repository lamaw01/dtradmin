<?php
require '../db_connect.php';
header('Content-Type: application/json; charset=utf-8');

// make input json
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE);


if($_SERVER['REQUEST_METHOD'] == 'POST' && array_key_exists('week_sched_id', $input)){
    $week_sched_id = $input['week_sched_id'];
    $monday = $input['monday'];
    $tuesday = $input['tuesday'];
    $wednesday = $input['wednesday'];
    $thursday = $input['thursday'];
    $friday = $input['friday'];
    $saturday = $input['saturday'];
    $sunday = $input['sunday'];
    $description = $input['description'];

    $sql = 'INSERT INTO tbl_week_schedule(week_sched_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday, description)
    VALUES (:week_sched_id,:monday,:tuesday,:wednesday,:thursday,:friday,:saturday,:sunday,:description)';

    try {
        $sql_insert = $conn->prepare($sql);
        $sql_insert->bindParam(':week_sched_id', $week_sched_id, PDO::PARAM_STR);
        $sql_insert->bindParam(':monday', $monday, PDO::PARAM_STR);
        $sql_insert->bindParam(':tuesday', $tuesday, PDO::PARAM_STR);
        $sql_insert->bindParam(':wednesday', $wednesday, PDO::PARAM_STR);
        $sql_insert->bindParam(':thursday', $thursday, PDO::PARAM_STR);
        $sql_insert->bindParam(':friday', $friday, PDO::PARAM_STR);
        $sql_insert->bindParam(':saturday', $saturday, PDO::PARAM_STR);
        $sql_insert->bindParam(':sunday', $sunday, PDO::PARAM_STR);
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