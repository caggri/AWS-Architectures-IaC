variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
    default = "us-east-1"
}

variable "AMIS" {
    type=map
    default = {
        us-east-1 = "ami-0d5eff06f840b45e9"
    }
}

variable "instance_type" {
    type = string
    default = "t1.micro"
}

variable "PATH_TO_PRIVATE_INSTANCE_PRIVATE_KEY" {
    default = "PrivKey"
}

variable "PATH_TO_PRIVATE_INSTANCE_PUBLIC_KEY" {
    default = "PrivKey.pub"
}

variable "PATH_TO_PUBLIC_INSTANCE_PRIVATE_KEY" {
    default = "PubKey"
}

variable "PATH_TO_PUBLIC_INSTANCE_PUBLIC_KEY" {
    default = "PubKey.pub"
}

variable "INSTANCE_USERNAME" {
    default = "ec2-user"
}

variable "USER_DATA" {
    default = "user_data.sh"
}