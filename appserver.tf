# -----------------------
# key pair
# -----------------------
resource "aws_key_pair" "keypair" {
  key_name   = "${var.project}-${var.environment}-keypair"
  public_key = file("./src/tastylog-dev-keypair.pub")

  tags = {
    Name    = "${var.project}-${var.environment}-keypair"
    Project = var.project
    Env     = var.environment
  }
}

# -----------------------
# ssm parameter store
# -----------------------
resource "aws_ssm_parameter" "db_password" {
  name  = "${var.project}-${var.environment}-db-password"
  type  = "SecureString"
  value = aws_db_instance.mysql_standalone.password
}

resource "aws_ssm_parameter" "db_host" {
  name  = "${var.project}-${var.environment}-db-host"
  type  = "String"
  value = aws_db_instance.mysql_standalone.address
}

resource "aws_ssm_parameter" "db_port" {
  name  = "${var.project}-${var.environment}-db-port"
  type  = "String"
  value = aws_db_instance.mysql_standalone.port
}

resource "aws_ssm_parameter" "db_name" {
  name  = "${var.project}-${var.environment}-db-name"
  type  = "String"
  value = aws_db_instance.mysql_standalone.name
}

resource "aws_ssm_parameter" "db_username" {
  name  = "${var.project}-${var.environment}-db-username"
  type  = "SecureString"
  value = aws_db_instance.mysql_standalone.username
}

# -----------------------
# EC2 instance
# -----------------------
resource "aws_instance" "app_server" {
  ami                         = data.aws_ami.app.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_1a.id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.app_ec2_profile.name
  vpc_security_group_ids = [
    aws_security_group.app_sg.id,
    aws_security_group.opmng_sg.id
  ]
  key_name = aws_key_pair.keypair.key_name

  tags = {
    Name    = "${var.project}-${var.environment}-app-ec2"
    Project = var.project
    Env     = var.environment
    Type    = "app"
  }
}
