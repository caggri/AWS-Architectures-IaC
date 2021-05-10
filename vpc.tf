resource "aws_vpc" "DemoVPC" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    
  tags = {
    Name = "DemoVPC"
  }
}

resource "aws_subnet" "PublicSubnetA" {
    vpc_id = "${aws_vpc.DemoVPC.id}"
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"

    tags = {
        Name = "PublicSubnetA"
    }
}

resource "aws_subnet" "PublicSubnetB" {
    vpc_id = "${aws_vpc.DemoVPC.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1b"

    tags = {
        Name = "PublicSubnetB"
    }
}

resource "aws_subnet" "PrivateSubnet" {
    vpc_id = "${aws_vpc.DemoVPC.id}"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1c"

    tags = {
        Name = "PrivateSubnet"
    }
    
}

