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
		
		case "get_race_detail":
		{
			
			
			
			$sql = "SELECT * FROM tbl_race_question WHERE race_id = ".$decodedData->race_id;
			
			/*
			echo $sql;
			
			exit;
			*/
			
			
			$result = mysql_query($sql);
			$resultArray = array();
			if(!$result)
			{
				$resultArray['STATUS'] = "0";
			}
			else
			{
				$i=0;
				while ($row = mysql_fetch_array($result, MYSQL_ASSOC)) 
				{
    				
					$resultArray[$i]['id'] = $row["id"];
					$resultArray[$i]['race_id'] = $row["race_id"];
					$resultArray[$i]['race_question_text'] = $row["race_question_text"];
					$resultArray[$i]['option_a'] = $row["option_a"];
					$resultArray[$i]['option_b'] = $row["option_b"];
					$resultArray[$i]['option_c'] = $row["option_d"];
					$resultArray[$i]['correct_answer'] = $row["correct_answer"];
					$resultArray[$i]['answer_is_true_false'] = $row["answer_is_true_false"];
					$resultArray[$i]['missing_letter_word'] = $row["missing_letter_word"];
					$resultArray[$i]['random_word'] = $row["random_word"];
					$resultArray[$i]['question_type '] = $row["question_type"];
					$resultArray[$i]['race_lat'] = $row["race_lat"];
					$resultArray[$i]['race_lon'] = $row["race_lon"];
					$i++;
				}
				print_r($json->encode($resultArray));
			}
			
			
			
			break;
		}
		
		case "create_race":
     {
     
	 /*
		 echo "<pre>";
		 
		 print_r($decodedData->user_id);
		 
		 echo "\n\n\n\n\n\n";
		 
		 print_r($decodedData->race_detail);
		 
		echo "\n\n\n\n\n\n";
		 
		 print_r($decodedData->race_question_array);
		 */
		 
		
		 
		 $sql = "INSERT INTO tbl_race
		 (
		 race_createdby,
		 race_name,
		 number_of_questions,
		 race_info,
		 race_latitude,
		 race_longitude
		 
		 )
		
		VALUES
		(
			".$decodedData->user_id.",
			'".$decodedData->race_detail->race_name."',
			".$decodedData->race_detail->number_of_question.",
			'".$decodedData->race_detail->race_detail."',
			".$decodedData->race_detail->race_latitude.",
			".$decodedData->race_detail->race_longitued."
			
		)";
		
		 
		 
		$result = mysql_query($sql);
		$resultArray = array();
		if(!$result)
		{
			$resultArray['STATUS'] = "0";
			$resultArray['STATUS'] = "Error";
		}
		else
		{
			
			$last_insert_id = mysql_insert_id();
			for($i=0;$i<count($decodedData->race_question_array);$i++)
			{
				
				
				if($decodedData->race_question_array[$i]->question_type==1)
				{
					
					
					$sql = "INSERT INTO tbl_race_question
					(
					race_id,
					race_question_text,
					option_a,
					option_b,
					option_c,
					option_d,
					correct_answer,
					question_type,
					race_lat,
					race_lon
					
					)
					
					VALUES
					(
					".$last_insert_id.",
					'".$decodedData->race_question_array[$i]->question."',
					'".$decodedData->race_question_array[$i]->option_a."',
					'".$decodedData->race_question_array[$i]->option_b."',
					'".$decodedData->race_question_array[$i]->option_c."',
					'".$decodedData->race_question_array[$i]->option_d."',
					".$decodedData->race_question_array[$i]->correct_answer.",
					".$decodedData->race_question_array[$i]->question_type.",
					".$decodedData->race_question_array[$i]->current_question_latitude.",
					".$decodedData->race_question_array[$i]->current_question_longitued."
					
					
					)";
					
					
					
				}
				else if($decodedData->race_question_array[$i]->question_type==2)
				{
					
					$sql = "INSERT INTO tbl_race_question
					(
					race_id,
					race_question_text,
					answer_is_true_false,
					question_type,
					race_lat,
					race_lon
					
					)
					
					VALUES
					(
					".$last_insert_id.",
					'".$decodedData->race_question_array[$i]->question."',
					".$decodedData->race_question_array[$i]->answer.",
					".$decodedData->race_question_array[$i]->question_type.",
					".$decodedData->race_question_array[$i]->current_question_latitude.",
					".$decodedData->race_question_array[$i]->current_question_longitued."
					
					
					)";
					
					
				}
				else if($decodedData->race_question_array[$i]->question_type==3)
				{
					
					
					$sql = "INSERT INTO tbl_race_question
					(
					race_id,
					race_question_text,
					missing_letter_word,
					number_of_character_to_show,
					question_type,
					race_lat,
					race_lon
					
					)
					
					VALUES
					(
					".$last_insert_id.",
					'".$decodedData->race_question_array[$i]->question."',
					'".$decodedData->race_question_array[$i]->answer."',
					".$decodedData->race_question_array[$i]->number_of_letters_to_show.",
					".$decodedData->race_question_array[$i]->question_type.",
					".$decodedData->race_question_array[$i]->current_question_latitude.",
					".$decodedData->race_question_array[$i]->current_question_longitued."
					
					
					)";
					
					
				}
				else if($decodedData->race_question_array[$i]->question_type==4)//Checkin.
				{
					
					
					$sql = "INSERT INTO tbl_race_question
					(
					race_id,
					race_question_text,
					question_type,
					race_lat,
					race_lon
					
					)
					
					VALUES
					(
					".$last_insert_id.",
					'".$decodedData->race_question_array[$i]->question."',
					".$decodedData->race_question_array[$i]->question_type.",
					".$decodedData->race_question_array[$i]->current_question_latitude.",
					".$decodedData->race_question_array[$i]->current_question_longitued."
					)";
					
					
				}
				
				
				
				$result = mysql_query($sql);
				$resultArray = array();
				if(!$result)
				{
					$resultArray['STATUS'] = "0";
					
				}
				
				
				
				
				
			}
			
			
			
			
			
			
			
			
			if($resultArray['STATUS']=='0')
			{
				$resultArray['STATUS'] = "0";
				$resultArray['MESSAGE'] = "Error in creating race.Pleaes try again later.";
			}
			else
			{
				$resultArray['STATUS'] = "1";
				$resultArray['MESSAGE'] = "Race created successfully.";
			}
			
		}
		 
		 print_r($json->encode($resultArray));
		 
		 break;	
     }

		
		
		
		case "get_near_by_races":
		{
			
			//lat = -33.8634
			//long = 151.211
			
			$sql = "SELECT *, 
			( 3959 * acos( cos( radians(".$decodedData->user_latitude.") ) * cos( radians( race_latitude ) ) * cos( radians( race_longitude ) - radians(".$decodedData->user_longitude.") ) + sin( radians(".$decodedData->user_latitude.") ) * sin( radians( race_latitude ) ) ) ) AS distance 
			FROM tbl_race WHERE race_createdby != $decodedData->user_id
			HAVING distance < 20 ORDER BY distance";
			
			/*
			echo $sql;
			
			exit;
			*/
			
			
			$result = mysql_query($sql);
			$resultArray = array();
			if(!$result)
			{
				$resultArray['STATUS'] = "0";
			}
			else
			{
				$i=0;
				while ($row = mysql_fetch_array($result, MYSQL_ASSOC)) 
				{
    				
					$resultArray[$i]['id'] = $row["id"];
					$resultArray[$i]['race_createdby'] = $row["race_createdby"];
					$resultArray[$i]['race_name'] = $row["race_name"];
					$resultArray[$i]['number_of_questions'] = $row["number_of_questions"];
					$resultArray[$i]['race_info'] = $row["race_info"];
					$resultArray[$i]['race_rating'] = $row["race_rating"];
					$resultArray[$i]['race_difficulty'] = $row["race_difficulty"];
					$resultArray[$i]['race_popularity'] = $row["race_popularity"];
					$resultArray[$i]['number_of_completion'] = $row["number_of_completion"];
					$resultArray[$i]['race_latitude'] = $row["race_latitude"];
					$resultArray[$i]['race_longitude '] = $row["race_longitude"];
					$resultArray[$i]['distance'] = $row["distance"];
					 
					 
					
					$i++;
				}
				
				
				
				print_r($json->encode($resultArray));
			}
			
			break;
			
			
		}
		
		
		case "get_latest_news":
		{
			
			$sql = "SELECT * FROM tbl_latest_news"; 
			$result = mysql_query($sql);
			if(!$result)
			{
				//
				$resultArray['STATUS'] = "0";
			}
			else
			{
				$i=0;
				
				
				//echo "<pre>";
				//print_r($row);
				//echo"test..";
				while ($row = mysql_fetch_array($result, MYSQL_ASSOC)) 
				{
    				//printf("ID: %s  Name: %s", $row["id"], $row["news"]);
					
					//echo"test..";
					/**/
					
					$resultArray[$i]['id'] = $row["id"];
					$resultArray[$i]['news'] = $row["news"];
					
					$i++;
				}
				
				/*
				while($row = mysql_fetch_array($result));
				{
					
					echo $sql;
					//$resultArray[$i]['id'] = $row["id"];
					//$resultArray[$i]['news'] = $row["news"];
					//$i++;
				}
				*/
				
				print_r($json->encode($resultArray));
			}
			
			
			break;
		}
		
		
		case "update_user_location":
		{
			
			
			$sql = "UPDATE 
			tbl_user
			SET user_latitude = '".$decodedData->user_latitude."',
			user_longitude = '".$decodedData->user_longitude."'
			WHERE id = ".$decodedData->user_id;
			
			
			$result = mysql_query($sql);
			if(!$result)
			{
				//
				$resultArray['STATUS'] = "0";
				$resultArray['MESSAGE'] = "Update Failed";
			}
			else
			{
				$resultArray['STATUS'] = "1";
				$resultArray['MESSAGE'] = "Update Successfully";
			}
			
			print_r($json->encode($resultArray));
			break;
			
			
		}
		
		case "update_user_detail":
		{
			$sql = "UPDATE 
			tbl_user 
			SET full_name = '".$decodedData->full_name."',
			city= '".$decodedData->city."',
			password = '".$decodedData->password."'
			WHERE id = ".$decodedData->user_id;
			$result = mysql_query($sql);
			if(!$result)
			{
				//
				$resultArray['STATUS'] = "0";
				$resultArray['MESSAGE'] = "Update Failed";
			}
			else
			{
				$resultArray['STATUS'] = "1";
				$resultArray['MESSAGE'] = "Update Successfully";
			}
			
			print_r($json->encode($resultArray));
			break;
		}
		
		case "get_user_detail":
		{
			$sql = "SELECT * FROM tbl_user WHERE id = '".$decodedData->user_id."'";
			$result = mysql_query($sql);
			if(!$result)
			{
				//
				$resultArray['STATUS'] = "0";
			}
			else
			{
				
				$row = mysql_fetch_array($result);
				
				$resultArray['STATUS'] = "1";
				//$resultArray['id'] = $row["id"];
				$resultArray['user_name'] = $row["user_name"];
				$resultArray['email'] = $row["email"];
				$resultArray['password'] = $row["password"];
				$resultArray['full_name'] = $row["full_name"];
				$resultArray['city'] = $row["city"];
				$resultArray['race_completed'] = $row["race_completed"];
				$resultArray['race_created'] = $row["race_created"];
				$resultArray['gps_rank'] = $row["gps_rank"];
				
				print_r($json->encode($resultArray));
				break;
				
				
			}
			break;
			
		}
		case "fb_user_registration_login":
		{
			$sql = "SELECT * FROM tbl_user WHERE fb_id = '".$decodedData->fb_id."'";
			$result = mysql_query($sql);
			/*if user already registered redirect him to main screen. */
			if(mysql_num_rows($result)>0)
			{
				$row = mysql_fetch_array($result);
				
				$resultArray['STATUS'] = "1";
				$resultArray['MESSAGE'] = "Login successful";
				
				
					
				$resultArray['id'] = $row["id"];
				$resultArray['user_name'] = $row["user_name"];
				$resultArray['email'] = $row["email"];
				$resultArray['password'] = $row["password"];
				$resultArray['full_name'] = $row["full_name"];
				$resultArray['city'] = $row["city"];
				$resultArray['race_completed'] = $row["race_completed"];
				$resultArray['race_created'] = $row["race_created"];
				$resultArray['gps_rank'] = $row["gps_rank"];
				
				print_r($json->encode($resultArray));
				break;
			}
			/*else register him and take him to main screen*/
			else
			{
				
				$sql = "INSERT INTO tbl_user
				(
				full_name,
				user_name,
				email,
				password,
				city,
				fb_id
				
				) 
				VALUES
				(
				'".$decodedData->full_name."',
				'".$decodedData->email."',
				'".$decodedData->email."',
				'',
				'',
				'".$decodedData->fb_id."'
				)";
				
				
				
				
				
				$result = mysql_query($sql);
				
				if (!$result) 
				{
    				die('Invalid query: ' . mysql_error());
					
				}
				else
				{
					$resultArray['STATUS'] = "1";
					$resultArray['MESSAGE'] = "Registration successful";
					
					
					$resultArray['id'] = mysql_insert_id();
					$resultArray['user_name'] = $decodedData->email;
					$resultArray['email'] = $decodedData->email;
					$resultArray['password'] = '';
					$resultArray['full_name'] = $decodedData->full_name;
					$resultArray['city'] = '';
					$resultArray['race_completed'] = 0;
					$resultArray['race_created'] = 0;
					$resultArray['gps_rank'] = 0;
				
					print_r($json->encode($resultArray));
					
					
					
					
				}
				
				
				break;
			}
			
			break;
		}
	
		
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
			
			$resultArray['id'] = mysql_insert_id();
			$resultArray['user_name'] = $decodedData->user_name;
			$resultArray['email'] = $decodedData->email;
			$resultArray['password'] = $decodedData->password;
			$resultArray['full_name'] = $decodedData->full_name;
			$resultArray['city'] = $decodedData->city;
			$resultArray['race_completed'] = 0;
			$resultArray['race_created'] = 0;
			$resultArray['gps_rank'] = 0;
			
			
			
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
					
					
					$resultArray['id'] = $row["id"];
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
			$sql = "SELECT * FROM  tbl_user WHERE user_name = '".$decodedData->user_name."'";
			
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
			<td>Hello: ".$row["full_name"]."</td>
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
			$headers .= 'From: <admin@ultimategeotech.com>' . "\r\n";
			
			
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