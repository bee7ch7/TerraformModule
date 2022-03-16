data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.type_ec2
  
  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.vpc.default_security_group_id]

  key_name = "meldm"

  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("key.pem")
    host     = self.public_ip
  }

  provisioner "file" {
    content = templatefile("${path.module}/index.html", {ip = aws_instance.web.public_ip, env = var.env})
    destination = "/tmp/index.html"
  }  

  provisioner "remote-exec" {
    inline = [
      "sudo apt -y update",
      "sudo apt -y install nginx",
      "sudo service nginx start",
      "sudo mv /tmp/index.html /var/www/html/index.html",
    ]
  }

tags = {
        "Name" = var.env
    }

}