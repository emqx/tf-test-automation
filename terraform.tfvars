## common

namespace = "tf-basic"


## vpc
cidr = "172.31.0.0/16"
# cidr = "10.0.0.0/16"
private_subnets = ["172.31.1.0/24"]
public_subnets = ["172.31.101.0/24"]
ingress_with_cidr_blocks = [
    {
      description = "ssh"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      description = "mqtt"
      from_port   = 1883
      to_port     = 1883
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      description = "mqtts"
      from_port   = 8883
      to_port     = 8883
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      description = "ws"
      from_port   = 8083
      to_port     = 8083
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      description = "wss"
      from_port   = 8084
      to_port     = 8084
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      description = "dashboard"
      from_port   = 18083
      to_port     = 18083
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

egress_with_cidr_blocks = [
    {
      description = "all"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
]

## ec2
associate_public_ip_address = true
instance_type = "t2.micro"
os = "ubuntu"
