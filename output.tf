output "Jenkins_Public_ip" {
  value=module.Jenkins.EC2_Public_ip
}

output "Public_subnet_id" {
  value = module.Networking.Public_Subnet_id
}

output "EC2_Subnet_id" {
  value = module.Jenkins.EC2_instance_Subnet_id
}