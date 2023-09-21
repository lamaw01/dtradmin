<?php
require '../db_connect.php';
header('Content-Type: application/json; charset=utf-8');

// make input json
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE);


if($_SERVER['REQUEST_METHOD'] == 'POST' && array_key_exists('id', $input)){
    $week_sched_id = $input['week_sched_id'];
    $monday = $input['monday'];
    $tuesday = $input['tuesday'];
    $wednesday = $input['wednesday'];
    $thursday = $input['thursday'];
    $friday = $input['friday'];
    $saturday = $input['saturday'];
    $sunday = $input['sunday'];
    $description = $input['description'];
    $id = $input['id'];

    $sql = 'UPDATE tbl_week_schedule SET week_sched_id=:week_sched_id, monday=:monday, tuesday=:tuesday, wednesday=:wednesday, thursday=:thursday, 
    friday=:friday, saturday=:saturday, sunday=:sunday, description=:description WHERE id=:id';

    try {
        $sql_update = $conn->prepare($sql);
        $sql_update->bindParam(':week_sched_id', $week_sched_id, PDO::PARAM_STR);
        $sql_update->bindParam(':monday', $monday, PDO::PARAM_STR);
        $sql_update->bindParam(':tuesday', $tuesday, PDO::PARAM_STR);
        $sql_update->bindParam(':wednesday', $wednesday, PDO::PARAM_STR);
        $sql_update->bindParam(':thursday', $thursday, PDO::PARAM_STR);
        $sql_update->bindParam(':friday', $friday, PDO::PARAM_STR);
        $sql_update->bindParam(':saturday', $saturday, PDO::PARAM_STR);
        $sql_update->bindParam(':sunday', $sunday, PDO::PARAM_STR);
        $sql_update->bindParam(':description', $description, PDO::PARAM_STR);
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