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

$userloginid = $_POST['userid'];
$productname = $_POST['nameofproduct'];
$productprice = $_POST['priceofprodut'];
$productdetail = $_POST['detailofproduct'];
$productimg = $_POST['imageofproduct'];

$originimage = base64_decode($productimg);
$productimgname = "Addproduct/".$productname.rand(0,10000).".jpg";
file_put_contents($productimgname, $originimage);

$qry = "Insert into addproduct (userid,productname,productprice,productdetail,productimage) Values ('$userloginid','$productname','$productprice','$productdetail','$productimgname')";

$sql = mysqli_query($con,$qry);

if($sql)
{
	$temp['result'] = 1;
}
else
{
	$temp['result'] = 0;
}

echo json_encode($temp);


 ?>