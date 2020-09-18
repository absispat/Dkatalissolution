resource "aws_instance" "Dkatalisec2" {
   ami = "ami-0dba2cb6798deb6d8"
   instance_type = "t2.medium"
   key_name = "abhisheksolution"

   provisioner "remote-exec" {
     inline = [
       "wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -",
       "sudo apt-get install apt-transport-https -y",
       "sudo echo 'deb https://artifacts.elastic.co/packages/7.x/apt stable main' | sudo tee /etc/apt/sources.list.d/elastic-7.x.list",
       "sudo apt-get update -y && sudo apt-get install elasticsearch -y",
       "sudo systemctl start elasticsearch.service",
       "sudo echo 'keystore_password' > ~/my_pwd_file.tmp",
       "sudo chmod 600 ~/my_pwd_file.tmp",
       "sudo systemctl set-environment ES_KEYSTORE_PASSPHRASE_FILE=~/my_pwd_file.tmp",
       "sudo systemctl restart elasticsearch.service",
       "sudo echo 'xpack.security.enabled: true' >> /etc/elasticsearch/elasticsearch.yml",
       "sudo systemctl restart elasticsearch.service"
     ]

   connection {
     type = "ssh"
     user = "ubuntu"
     private_key = file("./abhisheksolution.pem")
     host = self.public_ip
   }
   }
}
