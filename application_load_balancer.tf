resource "aws_lb_target_group" "TargetGroupDemo" {
  name     = "TargetGroupDemo"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.DemoVPC.id}"
}


resource "aws_lb" "ApplicationLBDemo" {
  name               = "ApplicationLBDemo"
  load_balancer_type = "application"
  subnets            = ["${aws_subnet.PublicSubnetA.id}", "${aws_subnet.PublicSubnetB.id}"]
  security_groups = ["${aws_security_group.SecurityGroupDemo.id}"]

  enable_cross_zone_load_balancing = true
}

resource "aws_lb_listener" "ListenerDemo" {
  load_balancer_arn = "${aws_lb.ApplicationLBDemo.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.TargetGroupDemo.arn}"
  }
}