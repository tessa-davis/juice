resource "aws_db_subnet_group" "snyk_rds_subnet_grp" {
  name       = "snyk_rds_subnet_grp_demo"
  subnet_ids = var.private_subnet

  tags = {
    Name      = "snyk_rds_subnet_grp_${var.cluster_name}"
    yor_trace = "ba99765e-2f4e-489f-89d5-31ee54237906"
  }
}

resource "aws_kms_key" "snyk_db_kms_key" {
  description             = "KMS Key for DB instance ${var.cluster_name}"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = {
    Name      = "snyk_db_kms_key_${var.cluster_name}"
    yor_trace = "6277d3ae-5a2a-45b4-a6be-496293ac06fd"
  }
}

resource "aws_db_instance" "snyk_db" {
  name                      = replace(var.cluster_name, "-", "")
  allocated_storage         = 20
  engine                    = "postgres"
  engine_version            = "10.20"
  instance_class            = "db.t3.micro"
  storage_type              = "gp2"
  password                  = "supersecret"
  username                  = "snyk"
  vpc_security_group_ids    = [var.rds_sg_id]
  db_subnet_group_name      = aws_db_subnet_group.snyk_rds_subnet_grp.id
  identifier                = "snyk-db-demo"
  storage_encrypted         = true
  skip_final_snapshot       = true
  final_snapshot_identifier = "${var.cluster_name}-db-destroy-snapshot"
  kms_key_id                = aws_kms_key.snyk_db_kms_key.arn
  tags = {
    Name      = "snyk_db_${var.cluster_name}"
    yor_trace = "7a2479d8-813f-4220-9761-6377ee01e248"
  }
}

resource "aws_ssm_parameter" "snyk_ssm_db_host" {
  name        = "/snyk-${var.cluster_name}/DB_HOST"
  description = "Snyk Database"
  type        = "SecureString"
  value       = aws_db_instance.snyk_db.endpoint

  tags = {
    yor_trace = "4220a9d2-f860-4b7c-bfca-f23bf0c9eb3c"
  }
}

resource "aws_ssm_parameter" "snyk_ssm_db_password" {
  name        = "/snyk-${var.cluster_name}/DB_PASSWORD"
  description = "Snyk Database Password"
  type        = "SecureString"
  value       = aws_db_instance.snyk_db.password

  tags = {
    yor_trace = "51af037a-b469-4c63-84e4-af935ad95965"
  }
}

resource "aws_ssm_parameter" "snyk_ssm_db_user" {
  name        = "/snyk-${var.cluster_name}/DB_USER"
  description = "Snyk Database Username"
  type        = "SecureString"
  value       = aws_db_instance.snyk_db.username

  tags = {
    yor_trace = "a7cbdd0b-8a38-4109-8683-82bfecd73bf9"
  }
}
resource "aws_ssm_parameter" "snyk_ssm_db_name" {
  name        = "/snyk-${var.cluster_name}/DB_NAME"
  description = "Snyk Database Name"
  type        = "SecureString"
  value       = aws_db_instance.snyk_db.name

  tags = {
    environment = "${var.cluster_name}"
    yor_trace   = "90bda5a1-d1fe-49d9-b16f-30b391a1e4df"
  }
}

resource "aws_s3_bucket" "snyk_storage" {
  bucket = "${var.cluster_name}"
  tags = {
    name      = "snyk_blob_storage_${var.cluster_name}"
    yor_trace = "4414680b-4bb5-4b80-9145-de3e583b8c8e"
  }
}

resource "aws_s3_bucket" "my-new-undeployed-bucket" {
  bucket = "${var.cluster_name}"
  tags = {
    yor_trace = "f0d4e8f3-5bfd-405c-b33e-977b8f2cb00f"
  }
}

resource "aws_s3_bucket_public_access_block" "snyk_public" {
  bucket = aws_s3_bucket.my-new-undeployed-bucket.id

  block_public_acls   = false
  ignore_public_acls  = false
  block_public_policy = false
}

resource "aws_s3_bucket_public_access_block" "snyk_private" {
  bucket = aws_s3_bucket.snyk_storage.id

  ignore_public_acls  = true
  block_public_acls   = true
  block_public_policy = true
}
