resource "aws_subnet" "main" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_main
  availability_zone = "${var.region}a"

  tags = {
    Name      = "Main"
    yor_trace = "155f1510-575b-4f9d-92f0-c0b2fda69735"
  }
}

resource "aws_subnet" "secondary" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_secondary
  availability_zone = "${var.region}c"

  tags = {
    Name      = "Main"
    yor_trace = "013c2ff6-6bc7-43f8-b73e-e76e6a5dc3cd"
  }
}
