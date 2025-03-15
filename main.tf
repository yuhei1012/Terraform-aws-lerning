provider "aws" {
  region = "ap-northeast-1"  # 東京リージョン
}

# 🔹 VPCを作成（10.0.0.0/16の範囲でネットワークを作る）
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "MyTerraformVPC"
  }
}

# 🔹 サブネットを作成（VPC内に作る）
resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id  # 作成したVPCを紐づけ
  cidr_block        = "10.0.1.0/24"  # /24 の範囲でサブネット作成
  map_public_ip_on_launch = true  # EC2に自動でパブリックIPを付与
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "MyTerraformSubnet"
  }
}

# 🔹 EC2インスタンスを作成（作成したVPC & サブネット内）
resource "aws_instance" "my_ec2" {
  ami           = "ami-0c3fd0f5d33134a76"  # Amazon Linux 2023のAMI
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_subnet.id  # 作成したサブネットを指定

  tags = {
    Name = "MyTerraformEC2"
  }
}

