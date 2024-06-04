Provider "aws" {
    region = "ap-south-1" 
}


resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  tags = {
    Name = "main"
  }
}
resource "aws_subnet" "Public_sub" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.16.0.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "Public_sub"
  }
}

resource "aws_subnet" "Pri_sub" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.32.0.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "Pri_sub"
  }
}
resource "aws_security_group" "My_sg" {
  description = "all-tcp-allow"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "My_sg"
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks =  0.0.0.0/0
  }
   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks =  0.0.0.0/0
  }
}
/*
resource "aws_instance" "Pub_instance" {
  ami           = "ami-00fa32593b478ad6e"
  instance_type = "t2.micro"
  key_name = "task-key.pem"
  subnet_id     = aws_subnet.Public_sub.id
  vpc_security_group_ids = aws_security_group-My_sg.id
}

resource "aws_instance" "pri_instance" {
  ami = "ami-00fa32593b478ad6e"
  instance_type = "t2.micro"
  key_name = "task-key.pem"
  subnet_id = aws_subnet.Pri_sub.id
  vpc_security_group_ids = aws_security_group-My_sg.id
}
*/