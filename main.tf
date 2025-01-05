module "Networking" {
   source               = "./Networking"
   vpc_cidr             = var.vpc_cidr
   vpc_name             = var.vpc_name
   cidr_private_subnet  = var.cidr_private_subnet
   cidr_public_subnet   = var.cidr_public_subnet
   availability_zone    = var.availability_zone
}

module "Security-Groups" {
  source               = "./Security-Groups"
  ec2_sg_name          = "SG for EC2 to enable SSH(22), HTTPS(443) and HTTP(80)"
  ec2_jenkins_sg_name  = "Allow port 8080 for jenkins"
  vpc_id               = module.Networking.vpc_id
}

module "Jenkins" {
  source           = "./Jenkins"
  instance_type    = "t2.large"
  tag_name         = "Jenkins_EC2"
  ami_id           = "ami-0e2c8caa4b6378d8c"
  public_key       = var.public_key
  subnet_id        = element(module.Networking.Public_Subnet_id,0)
  enable_public_ip_address  = true
  user_data_install_jenkins = templatefile("./jenkins-runner-script/jenkins3tier.sh", {})
  vpc_security_group_ids    = [module.Security-Groups.ec2_sg_ssh_http_id, module.Security-Groups.Jenkins_SG_8080_id]
}
