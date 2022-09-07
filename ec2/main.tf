# Get Availability Zones
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Generate a Private Key and encode it as PEM.
resource "aws_key_pair" "key_pair" {
  key_name   = "key"
  public_key = tls_private_key.key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.key.private_key_pem}' > ./key.pem"
  }
}
/*
data "cloudinit_config" "user_data" {
  gzip          = true
  base64_encode = true
  part {
    content_type = "text/x-shellscript"
    content      = "baz"
    filename     = "userdata.sh"
  }
}
*/
# Create a EC2 Instance (Amazon EC2 with docker pulling image)
resource "aws_instance" "node" {
  instance_type          = "t2.micro"
  ami                    = "ami-02a7b1673051d5182"
  key_name               = aws_key_pair.key_pair.id
  vpc_security_group_ids = [var.public_sg]
  subnet_id              = var.public_subnet


  tags = {
    Name = "first EC2"
  }

  //user_data = data.cloudinit_config.user_data.rendered

  root_block_device {
    volume_size = 10
  }


  metadata_options {
    http_endpoint = "disabled"
    http_tokens   = "required"
  }
}

# Create and assosiate an Elastic IP
resource "aws_eip" "eip" {
  instance = aws_instance.node.id
}

