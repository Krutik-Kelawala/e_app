<?php 


$con = mysqli_connect("localhost","id18927791_kelawala","Krutikkelawala@1810","id18927791_krutik");

$temp = array();

if($con)
{
	$temp['connection'] = 1;
}
else
{
	$temp['connection'] = 0;
}


$userloginid = $_REQUEST['userid'];

$qry = "Select * from addproduct where userid = '$userloginid'";
$sql = mysqli_query($con,$qry);
$cnt = mysqli_num_rows($sql);
 
if($cnt>0)
{
	$temp['result'] = 1;
	$viewproductdata = array();
	while ($arr=mysqli_fetch_assoc($sql)) {

			$viewproductdata[] = $arr;
	
	}
	$temp['viewproduct'] = $viewproductdata;
}
else
{
	$temp['result'] = 0;
}

echo json_encode($temp);

 ?>