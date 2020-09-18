provider "aws" {
  region     = "us-east-1"
  access_key = "accesskey"
  secret_key = "secretaccess"
}



resource "aws_instance" "Dkatalisec2" {
   ami = "ami-0dba2cb6798deb6d8"
   instance_type = "t2.medium"
   key_name = "abhisheksolution"
   security_groups  = ["solution"]

   provisioner "local-exec" {
    command = "echo ${aws_instance.Dkatalisec2.public_ip} >> hosts.ini"
  }
}
