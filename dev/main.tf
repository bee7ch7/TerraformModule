module "meldm" {
    source = "../modules/meldm"

    env = "dev"
    type_ec2 = "t2.micro"
}

output "PublicIP" {
    value = module.meldm.ip_meldm
    
}

output "PublicDNS" {
    value = module.meldm.dns_meldm
    
}