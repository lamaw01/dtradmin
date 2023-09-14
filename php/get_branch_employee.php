<?php
require '../db_connect.php';
header('Content-Type: application/json; charset=utf-8');

// make input json
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE);

// if not put id die
if($_SERVER['REQUEST_METHOD'] == 'GET'){

    $sql = "SELECT tbl_employee_branch.id, tbl_employee_branch.employee_id, tbl_employee.first_name, tbl_employee.last_name, tbl_employee.middle_name, tbl_employee_branch.branch_id, tbl_branch.branch_name
    FROM tbl_employee_branch 
    LEFT JOIN tbl_employee ON tbl_employee.employee_id = tbl_employee_branch.employee_id
    LEFT JOIN tbl_branch ON tbl_branch.branch_id = tbl_employee_branch.branch_id";
    
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