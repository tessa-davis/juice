resource "aws_subnet" "main" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_main
  availability_zone = "${var.region}a"

  tags = {
    Name      = "Main"
    yor_trace = "7cb4e4c2-db57-4600-80a0-06ceecb8e628"
  }
}

resource "aws_subnet" "secondary" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_secondary
  availability_zone = "${var.region}c"

  tags = {
    Name      = "Main"
    yor_trace = "2da85f45-ce50-40ac-b98f-94355da31254"
  }
}
