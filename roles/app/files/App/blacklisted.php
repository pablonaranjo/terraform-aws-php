<?php
  $ip_origen = $_SERVER['REMOTE_ADDR'];
  $path = $_SERVER["REQUEST_URI"];
  $iptables_command = "sudo /sbin/iptables -A INPUT -s $ip_origen -j DROP";
  $output = shell_exec($iptables_command);
  http_response_code(444); // set error code 444

  $from = "test@paxful.com";
  $to = "test@domain.com";
  $subject = "IP blacklisted";
  $message = "IP blacklisted: $ip_origen";
  $headers = "From:" . $from;
  mail($to,$subject,$message, $headers);

  $now = date('Y-m-d H:i:s');
  $db_connection = pg_connect("host=dbmaster dbname=blacklisted user=black password=black123");
  pg_query($db_connection, "CREATE TABLE IF NOT EXISTS ip_blocked (endpoint VARCHAR(50) NOT NULL, ip_addr VARCHAR(50) NOT NULL, blocked_at TIMESTAMP NOT NULL)");
  pg_query($db_connection, "INSERT INTO ip_blocked (endpoint,ip_addr,blocked_at) VALUES ('$path','$ip_origen','$now')");
?>
