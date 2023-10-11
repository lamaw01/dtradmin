<?php
require '../db_connect.php';
header('Content-Type: application/json; charset=utf-8');

// make input json
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE);

// if not put id die
if($_SERVER['REQUEST_METHOD'] == 'GET'){

    $sql = "SELECT tbl_device_logs.id, tbl_device_logs.device_id, tbl_device_logs.address,tbl_device_logs.latlng,tbl_device_logs.app_name,tbl_device_logs.version,tbl_device_logs.log_time,tbl_device_logs.time_stamp, 
    CASE WHEN tbl_device.description IS NULL AND tbl_device_logs.app_name = 'sirius' THEN 'unathorized' WHEN tbl_device.description IS NULL AND tbl_device_logs.app_name = 'orion' THEN 'unknown' ELSE tbl_device.description END as description
    FROM tbl_device_logs LEFT JOIN tbl_device ON tbl_device.device_id = tbl_device_logs.device_id ORDER BY id DESC LIMIT 100;";

    try {
        $get_sql = $conn->prepare($sql);
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