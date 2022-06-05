<?php 

$con = mysqli_connect("localhost","id18927791_kelawala","Krutikkelawala@1810","id18927791_krutik");

$temp = array();

if($con)
{
	$temp['connetion'] = 1;
}
else
{
	$temp['connetion'] = 0;
}

$Productid = $_POST['productid'];
$Productname = $_POST['productname'];
$Productprice = $_POST['productprice'];
$Productdetail = $_POST['productdetail'];
$Productimg = $_POST['imageofproduct'];   // old imagepath
$imgdata = $_POST['productdata'];  // new update image name

$realimg = base64_decode($imgdata);

file_put_contents($Productimg, $realimg);



$qry = "Update addproduct set productname = '$Productname' , productprice = '$Productprice' , productdetail = '$Productdetail' , productimage = '$Productimg' where productid = '$Productid'";
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