<?php 

// formate for connection
// $con = mysqli_connect("hostname","username","password","databasename");

$con =  mysqli_connect("localhost","id18927791_kelawala","Krutikkelawala@1810","id18927791_krutik");

$temp = array();

if($con)
{
	$temp['connection'] = 1;
}
else 
{
	$temp['connection'] = 0;
}

$username = $_REQUEST['Userlogin'];
$userpass = $_REQUEST['Userpassword'];


$qry = "Select * from register where email = '$username' or contact = '$username' and password = '$userpass'";
$sql = mysqli_query($con,$qry);
$cnt = mysqli_num_rows($sql);

if($cnt==1)
{
	$temp['result'] = 1;
	$arr = mysqli_fetch_assoc($sql);
	$temp['userdata'] = $arr; 
} 
else 
{
	$temp['result'] = 0;
}

echo json_encode($temp);


 ?>