resource "aws_route_table_association" "public-rt-association" {
  count          = length(var.public_cidr_block)
  subnet_id      = element(aws_subnet.subnet-public.*.id, count.index)
  route_table_id = aws_route_table.public-routing-table.id
}

resource "aws_route_table_association" "private-rt-association" {
  count          = length(var.private_cidr_block)
  subnet_id      = element(aws_subnet.subnet-private.*.id, count.index)
  route_table_id = aws_route_table.private-routing-table.id
}






