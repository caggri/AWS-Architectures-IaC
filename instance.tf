resource "aws_key_pair" "PrivKey" {
    key_name = "PrivKey"
    public_key = "${file("${var.PATH_TO_PRIVATE_INSTANCE_PUBLIC_KEY}")}"
}

resource "aws_instance" "PrivateInstance" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "${var.instance_type}"
    subnet_id = "${aws_subnet.PrivateSubnet.id}"
    key_name = "${aws_key_pair.PrivKey.key_name}"
    vpc_security_group_ids = ["${aws_security_group.SecurityGroupDemo.id}"]
    tags = {
      Name = "PrivateInstance"
    } 
 }


resource "aws_instance" "PrivateInstance2" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "${var.instance_type}"
    subnet_id = "${aws_subnet.PrivateSubnet.id}"
    key_name = "${aws_key_pair.PrivKey.key_name}"
    vpc_security_group_ids = ["${aws_security_group.SecurityGroupDemo.id}"]
    tags = {
      Name = "PrivateInstance2"
    } 
 }