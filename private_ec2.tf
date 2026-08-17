resource "aws_instance" "private-server" {
  count                       = length(var.private_cidr_block)
  ami                         = lookup(var.amis, var.aws_region)
  instance_type               = "t3.nano"
  key_name                    = var.key_name
  subnet_id                   = element(aws_subnet.subnet-private.*.id, count.index)
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name        = "${var.vpc_name}-private-server-${count.index + 1}"
    Owner       = local.Owner
    CostCenter  = local.CostCenter
    TeamDL      = local.TeamDL
    environment = "${var.environment}"
  }

  user_data = <<-EOF
       #!/bin/bash
       sudo apt update
       sudo apt install nginx -y
       sudo apt install git
       sudo git clone https://github.com/saikiranpi/SecOps-game.git
       sudo rm -rf /var/www/html/index.nginx-debian.html
       sudo cp SecOps-game/index.html /var/www/html/index.html
       echo "<h1>${var.vpc_name}-private-Server-${count.index + 1}</h1>" >> /var/www/html/index.html
       sudo systemctl start nginx
       sudo systemctl enable nginx
  EOF 
}
