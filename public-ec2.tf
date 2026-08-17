resource "aws_instance" "public-server" {
  count                       = (var.environment == "Prod") ? 3 : 1
  ami                         = lookup(var.amis, var.aws_region)
  instance_type               = "t3.nano"
  key_name                    = var.key_name
  subnet_id                   = element(aws_subnet.subnet-public.*.id, count.index)
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name        = "${var.vpc_name}-public-server-${count.index + 1}"
    Owner       = local.Owner
    CostCenter  = local.CostCenter
    TeamDL      = local.TeamDL
    environment = "${var.environment}"
  }

}
