aws_region         = "ap-south-1"
vpc_cidr           = "172.18.0.0/16"
vpc_name           = "Devops-Vpc"
key_name           = "mum-kvpair"
azs                = ["ap-south-1a", "ap-south-1b"]
public_cidr_block  = ["172.18.1.0/24", "172.18.2.0/24", "172.18.3.0/24"]
private_cidr_block = ["172.18.10.0/24", "172.18.20.0/24", "172.18.30.0/24"]
environment        = "Dev"
ingress_value      = ["80", "443", "8080", "22", "3306", "8443", "1900", "1443"]
amis = {
  ap-south-1 = "ami-01a00762f46d584a1",
  ap-south-2 = "ami-03f1d2b3639314198"
}
