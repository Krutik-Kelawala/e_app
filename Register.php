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

$name = $_POST['Name'];
$mobileno = $_POST['Contact'];
$email = $_POST['Email'];
$password = $_POST['Password'];
$imagedata = $_POST['Imagedata'];

$realimage = base64_decode($imagedata);

$imagename = "Userimage/".$name.rand(0,10000).".jpg";

file_put_contents($imagename, $realimage);

$checkqry = "Select * from register where email = '$email' or contact = '$mobileno' ";
$checksql = mysqli_query($con,$checkqry);
$cnt = mysqli_num_rows($checksql);

if($cnt==0)
{
	$qry = "insert into register (name,contact,email,password,imagename) values ('$name','$mobileno','$email','$password','$imagename')";



$sql = mysqli_query($con,$qry);

if($sql)
{
	$temp['result'] = 1;
}
else
{
	$temp['result'] = 0;
}

}
else
{
	$temp['result'] = 2;
}


echo json_encode($temp);


 ?>