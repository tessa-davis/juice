resource "aws_s3_bucket" "demo" {
  bucket = "juice-shop-demo-bucket"
  acl    = "public-read"
}

resource "aws_security_group" "demo" {
  name = "demo-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "demo" {
  engine              = "mysql"
  instance_class      = "db.t3.micro"
  publicly_accessible = true
  storage_encrypted   = false
  password            = "hunter2hunter2"
}
