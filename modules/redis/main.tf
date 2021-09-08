data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "redis" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  // always be true as you have to get public ip
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_name
  subnet_id                   = var.subnet_ids[0]
  vpc_security_group_ids      = var.sg_ids

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = var.private_key
  }

  # install redis
  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo apt-get update",
  #     "sudo apt install redis-server",
  #     "sudo sed -i 's/bind 127.0.0.1 ::1/bind ${self.private_ip} ::1/g' /etc/redis/redis.conf",
  #     "sudo systemctl start redis.service"
  #   ]
  # }

  # install redis
  provisioner "file" {
    content     = templatefile("${path.module}/scripts/init.sh", { local_ip = self.private_ip })
    destination = "/tmp/init.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/init.sh",
      "/tmp/init.sh",
    ]
  }

  # make sure the config valid
  provisioner "remote-exec" {
    inline = [
      "sudo systemctl restart redis.service"
    ]
  }

  root_block_device {
    iops        = 3000
    throughput  = 125
    volume_size = 50
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.namespace}"
  }
}