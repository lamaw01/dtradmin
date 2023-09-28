<?php
require '../db_connect.php';
header('Content-Type: application/json; charset=utf-8');

// make input json
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE);


if($_SERVER['REQUEST_METHOD'] == 'POST' && array_key_exists('branch_id', $input)){
    $branch_id = $input['branch_id'];
    $device_id = $input['device_id'];
    $description = $input['description'];

    $sql = 'INSERT INTO tbl_device(branch_id, device_id, description)
    VALUES (:branch_id,:device_id,:description)';

    try {
        $sql_insert = $conn->prepare($sql);
        $sql_insert->bindParam(':branch_id', $branch_id, PDO::PARAM_STR);
        $sql_insert->bindParam(':device_id', $device_id, PDO::PARAM_STR);
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