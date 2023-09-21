<?php
require '../db_connect.php';
header('Content-Type: application/json; charset=utf-8');

// make input json
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE);


if($_SERVER['REQUEST_METHOD'] == 'POST' && array_key_exists('employee_id', $input)){
    $employee_id = $input['employee_id'];
    $first_name = $input['first_name'];
    $last_name = $input['last_name'];
    $middle_name = $input['middle_name'];
    $week_sched_id = $input['week_sched_id'];
    $active = $input['active'];

    $sql = 'INSERT INTO tbl_employee(employee_id, first_name, last_name, middle_name, week_sched_id, active)
    VALUES (:employee_id,:first_name,:last_name,:middle_name,:week_sched_id,:active)';

    try {
        $sql_insert = $conn->prepare($sql);
        $sql_insert->bindParam(':employee_id', $employee_id, PDO::PARAM_STR);
        $sql_insert->bindParam(':first_name', $first_name, PDO::PARAM_STR);
        $sql_insert->bindParam(':last_name', $last_name, PDO::PARAM_STR);
        $sql_insert->bindParam(':middle_name', $middle_name, PDO::PARAM_STR);
        $sql_insert->bindParam(':week_sched_id', $week_sched_id, PDO::PARAM_STR);
        $sql_insert->bindParam(':active', $active, PDO::PARAM_STR);
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