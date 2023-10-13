<?php
require '../db_connect.php';
header('Content-Type: application/json; charset=utf-8');

// make input json
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE);


if($_SERVER['REQUEST_METHOD'] == 'POST' && array_key_exists('employee_id', $input)){
    $employee_id = $input['employee_id'];
    $department_id = $input['department_id'];

    $sql = 'DELETE FROM tbl_employee_department WHERE employee_id=:employee_id AND department_id=:department_id';

    try {
        foreach ($employee_id as $id) {
            $sql_insert = $conn->prepare($sql);
            $sql_insert->bindParam(':employee_id', $id, PDO::PARAM_STR);
            $sql_insert->bindParam(':department_id', $department_id, PDO::PARAM_STR);
            $sql_insert->execute();
        }
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