resource "aws_instance" "ec2_instance" {
  ami                    = var.ami_id
  instance_type          = var.vm_size
  vpc_security_group_ids = [var.sg_id]
  subnet_id              = var.subnet_id
  key_name               = var.keypair

  root_block_device {
    volume_size = var.disk_size
  }
  tags = {
    Name = var.ec2_name
  }
}

resource "aws_eip_association" "eip-association" {
  instance_id   = aws_instance.ec2_instance.id
  allocation_id = aws_eip.eip.id
}

resource "aws_eip" "eip" {
  vpc = true
}

output "instance_id" {
  value = aws_instance.ec2_instance.id
}
