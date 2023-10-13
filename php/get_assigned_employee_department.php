<?php
require '../db_connect.php';
header('Content-Type: application/json; charset=utf-8');

// make input json
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE);

// if not put id die
if($_SERVER['REQUEST_METHOD'] == 'POST' && array_key_exists('department_id', $input)){
    $department_id = $input['department_id'];

    $sql = "SELECT DISTINCT(tbl_employee.employee_id), tbl_employee.first_name, tbl_employee.last_name, tbl_employee.middle_name FROM tbl_employee 
    INNER JOIN tbl_employee_department ON tbl_employee_department.employee_id = tbl_employee.employee_id 
    WHERE tbl_employee_department.department_id = :department_id ORDER BY tbl_employee.last_name ASC;";
    
    try {
        $get_sql = $conn->prepare($sql);
        $get_sql->bindParam(':department_id', $department_id, PDO::PARAM_INT);
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