<?php
require '../db_connect.php';
header('Content-Type: application/json; charset=utf-8');

// make input json
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE);

// if not put id die
if($_SERVER['REQUEST_METHOD'] == 'POST' && array_key_exists('employee_id', $input)){
    $employee_id = $input['employee_id'];

    $sql = "SELECT tbl_company.id, tbl_company.company_id, tbl_company.company_name FROM tbl_employee_company 
    INNER JOIN tbl_employee ON tbl_employee.employee_id = tbl_employee_company.employee_id 
    INNER JOIN tbl_company ON tbl_company.company_id = tbl_employee_company.company_id WHERE tbl_employee.employee_id = :employee_id;";
    
    try {
        $get_sql = $conn->prepare($sql);
        $get_sql->bindParam(':employee_id', $employee_id, PDO::PARAM_STR);
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