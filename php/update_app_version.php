<?php
require '../db_connect.php';
header('Content-Type: application/json; charset=utf-8');

// make input json
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE);


if($_SERVER['REQUEST_METHOD'] == 'POST' && array_key_exists('id', $input)){
    $name = $input['name'];
    $version = $input['version'];
    $id = $input['id'];

    $sql = 'UPDATE tbl_app_version SET name=:name,version=:version WHERE id=:id';

    try {
        $sql_update = $conn->prepare($sql);
        $sql_update->bindParam(':name', $name, PDO::PARAM_STR);
        $sql_update->bindParam(':version', $version, PDO::PARAM_STR);
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