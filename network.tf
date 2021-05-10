resource "aws_internet_gateway" "InternetGatewayDemo" {
    vpc_id = "${aws_vpc.DemoVPC.id}"

    tags = {
        Name = "InternetGatewayDemo"
    }
}

resource "aws_route_table" "RouteTableDemo" {
    vpc_id = "${aws_vpc.DemoVPC.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.InternetGatewayDemo.id}"
    }
    
    tags = {
        Name = "RouteTableDemo"
    }
}


resource "aws_route_table_association" "PublicSubnetA-Assoc" {
    subnet_id = "${aws_subnet.PublicSubnetA.id}"
    route_table_id = "${aws_route_table.RouteTableDemo.id}"
}

resource "aws_route_table_association" "PublicSubnetB-Assoc" {
    subnet_id = "${aws_subnet.PublicSubnetB.id}"
    route_table_id = "${aws_route_table.RouteTableDemo.id}"
}

resource "aws_security_group" "SecurityGroupDemo" {
    vpc_id = "${aws_vpc.DemoVPC.id}"
    egress {
        from_port = 0
        to_port = 0
        protocol = -1 
        cidr_blocks      = ["0.0.0.0/0"]
    }
    ingress {
    description      = "Allow SSH from Everywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
   ingress {
    description      = "Allow HTTP from Everywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
    tags = {
        Name = "SecurityGroupDemo"
    }
}

# EIP
resource "aws_eip" "DemoEIP" {
  vpc = true
}

# NAT GATEWAY

resource "aws_nat_gateway" "DemoNATGW" {
  allocation_id = "${aws_eip.DemoEIP.id}"
  subnet_id     = "${aws_subnet.PublicSubnetA.id}"

  tags = {
    Name = "DemoNATGW"
  }

  depends_on = [aws_internet_gateway.InternetGatewayDemo]
}

# PRIVATE ROUTE TABLE
resource "aws_route_table" "PrivateRouteTableDemo" {
    vpc_id = "${aws_vpc.DemoVPC.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_nat_gateway.DemoNATGW.id}"
    }
    
    tags = {
        Name = "PrivateRouteTableDemo"
    }
}

resource "aws_route_table_association" "PrivateSubnetAssoc" {
    subnet_id = "${aws_subnet.PrivateSubnet.id}"
    route_table_id = "${aws_route_table.PrivateRouteTableDemo.id}"
}
