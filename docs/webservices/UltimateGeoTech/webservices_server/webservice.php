<?php
	session_start();
	//$link = mysql_connect('68.178.136.205', 'zeenweb', 'Zeen#321!');
	$link = mysql_connect('localhost', 'root', 'root');

	if($link)
	{
		if(!mysql_select_db("utlimate_geo_tech"))
		{
			 die('Could not select DB: ' . mysql_error());
		}
	}
	else
	{
		 die('Could not connect: ' . mysql_error());
	}

	require_once("classes/JSON.php");
	
	/*SERVER
	$IMAGE_SERVER_URL_PATH = "http://doublesixdev.com/zeen_web/uploads/";
	$VIDEO_SERVER_URL_PATH = "http://doublesixdev.com/zeen_web/mfiles/";
	*/
	
	$IMAGE_SERVER_URL_PATH = "http://192.168.3.14:8888/zeen_web/uploads/";
	$VIDEO_SERVER_URL_PATH = "http://192.168.3.14:8888/zeen_web/mfiles/";
	
	/*
	$myFile = "testFile.txt";
	$fh = fopen($myFile, 'a') or die("can't open file");
	$stringData = "\n user agent = ".print_r($_SERVER);
	
	foreach ($_SERVER as $k => $v) 
	{
    	$stringData .= "\$a[$k] => $v.\n";
	}
	
	fwrite($fh, $stringData);

	fclose($fh);
	*/
	
	

	$json 	= new Services_JSON();
	
	$data 	= stripcslashes($_REQUEST["data"]);
	$decodedData = $json->decode($data);
	$action =  $decodedData->action;
	
	/*
	echo "this is test".$action;
	exit;
	*/
	$myFile = "responce.txt";
	$fh = fopen($myFile, 'w') or die("can't open file");
/*		foreach($_GET as $key=>$value) {
			$stringData .= $key. "=>".$value."\r\n";
		}
		fwrite($fh, $stringData);*/
		

	//For getting Manage Region/Subregion
	
	switch($action)
	{
		
	
		
	
		
		case "user_registration":
		{
			$sql = "SELECT * FROM tbl_user WHERE  email = '".$decodedData->email."'";
			$result = mysql_query($sql);
			if(mysql_num_rows($result)>0)
			{
				$resultArray['STATUS'] = "0";
				$resultArray['MESSAGE'] = "Username is already taken.Please choose another one.";
				print_r($json->encode($resultArray));
				
				break;
			}
			
			
			$sql = "INSERT INTO tbl_user
			(
			full_name,
			user_name,
			email,
			password,
			city
			
			) 
			VALUES
			(
			'".$decodedData->full_name."',
			'".$decodedData->user_name."',
			'".$decodedData->email."',
			'".$decodedData->password."',
			'".$decodedData->city."'
			)";
			
			
			$result = mysql_query($sql);
			
			$resultArray['STATUS'] = "1";
			$resultArray['MESSAGE'] = "Registration successful";
			print_r($json->encode($resultArray));
			
			
			
			
			break;
		}
		
		case "login":
		{
			
			if($decodedData->registration_type==2)
			{
			
				$sql = "SELECT * FROM tbl_user WHERE user_name = '".$decodedData->email."' AND BINARY password ='".$decodedData->password."'";
				$result = mysql_query($sql);
				if(mysql_num_rows($result)==0)
				{
					$resultArray['STATUS'] = "0";
					$resultArray['MESSAGE'] = "Invalid username or password";
				}
				else 
				{	
					$row = mysql_fetch_array($result);
					
					$resultArray['user_name'] = $row["user_name"];
					$resultArray['email'] = $row["email"];
					$resultArray['password'] = $row["password"];
					$resultArray['full_name'] = $row["full_name"];
					$resultArray['city'] = $row["city"];
					$resultArray['race_completed'] = $row["race_completed"];
					$resultArray['race_created'] = $row["race_created"];
					$resultArray['gps_rank'] = $row["gps_rank"];
					$resultArray['STATUS'] = "1";
					$resultArray['MESSAGE'] = "Sucessfully Logged In.";

					
					
				}
				
				
				print_r($json->encode($resultArray));
			}
			
	
			
			break;
		}
		
		
		case "forgotpassword":
		{
			$sql = "SELECT * FROM users WHERE username = '".$decodedData->username."'";
			
			$result = mysql_query($sql);
			if(mysql_num_rows($result)==0)
			{
				$resultArray['STATUS'] = "0";
				$resultArray['MESSAGE'] = "No such user name";
				print_r($json->encode($resultArray));
				
				break;
			}
			
			$row = mysql_fetch_assoc($result);
			//password 	
			
			$to = $row["email"];
			//$to = "chirag.purohit@sunshineinfotech.com";
			$subject = "Forgot Password";
			
			$message = "
			<html>
			<body>
			<table width=\"320px\">
			<tr>
			<td>Hello: ".$row["first_name"]."</td>
			</tr>
			<tr>
			<td>Your password is :".$row["password"]."</td>
			</tr>
			</table>
			</body>
			</html>
			";
			
			// Always set content-type when sending HTML email
			$headers = "MIME-Version: 1.0" . "\r\n";
			$headers .= "Content-type:text/html;charset=iso-8859-1" . "\r\n";
			
			// More headers
			$headers .= 'From: <admin@sweetshop.com>' . "\r\n";
			
			
			if(mail($to,$subject,$message,$headers))
			{
				//echo "1";
				$resultArray['STATUS'] = "1";
				$resultArray['MESSAGE'] = "Email has been sent to your registered email address";
				
				
						
			}
			else
			{
				$resultArray['STATUS'] = "0";
				$resultArray['MESSAGE'] = "Somethign went wrong please try again later.";
				
			}
			print_r($json->encode($resultArray));



			
			
			
			
			break;
		}
		
		
		
		
	
		
	
		
	
		
		
		
	}
	
	
	
?>