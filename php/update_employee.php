<?php
require '../db_connect.php';
header('Content-Type: application/json; charset=utf-8');

// make input json
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE);


if($_SERVER['REQUEST_METHOD'] == 'POST' && array_key_exists('id', $input)){
    $employee_id = $input['employee_id'];
    $first_name = $input['first_name'];
    $last_name = $input['last_name'];
    $middle_name = $input['middle_name'];
    $week_sched_id = $input['week_sched_id'];
    $active = $input['active'];
    $id = $input['id'];

    $sql = 'UPDATE tbl_employee SET  employee_id=:employee_id, first_name=:first_name, last_name=:last_name, middle_name=:middle_name, week_sched_id=:week_sched_id, active=:active WHERE id=:id';

    try {
        $sql_update = $conn->prepare($sql);
        $sql_update->bindParam(':employee_id', $employee_id, PDO::PARAM_STR);
        $sql_update->bindParam(':first_name', $first_name, PDO::PARAM_STR);
        $sql_update->bindParam(':last_name', $last_name, PDO::PARAM_STR);
        $sql_update->bindParam(':middle_name', $middle_name, PDO::PARAM_STR);
        $sql_update->bindParam(':week_sched_id', $week_sched_id, PDO::PARAM_STR);
        $sql_update->bindParam(':active', $active, PDO::PARAM_STR);
        $sql_update->bindParam(':id', $id, PDO::PARAM_INT);
        $sql_update->execute();
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