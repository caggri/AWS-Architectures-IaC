resource "aws_key_pair" "PubKey" {
    key_name = "PubKey"
    public_key = "${file("${var.PATH_TO_PUBLIC_INSTANCE_PUBLIC_KEY}")}"
}

resource "aws_launch_template" "DemoTemplate" {
  name = "DemoTemplate"

  image_id = "${lookup(var.AMIS, var.AWS_REGION)}"

  instance_type = "${var.instance_type}"

  key_name = "${aws_key_pair.PubKey.key_name}"

  vpc_security_group_ids = ["${aws_security_group.SecurityGroupDemo.id}"]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "DemoTemplate"
    }
  }

  user_data = filebase64("${var.USER_DATA}")
}
