<?php
require '../db_connect.php';
header('Content-Type: application/json; charset=utf-8');

// make input json
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE);


if($_SERVER['REQUEST_METHOD'] == 'POST' && array_key_exists('company_id', $input)){
    $company_id = $input['company_id'];
    $company_name = $input['company_name'];

    $sql = 'INSERT INTO tbl_company(company_id, company_name)
    VALUES (:company_id,:company_name)';

    try {
        $sql_insert = $conn->prepare($sql);
        $sql_insert->bindParam(':company_id', $company_id, PDO::PARAM_STR);
        $sql_insert->bindParam(':company_name', $company_name, PDO::PARAM_STR);
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