resource "aws_key_pair" "vpn" {
  key_name   = "vpn"
  # you can paste the public key directly like this
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCwcSF0IDR1ocDKGLZD1EcH4ufNYyY2UlTycWS9FL5ahQTh5PnAyJqYcSP9DB5xcBI82ZiA7pF3glh4nu0lkq/JqbKm4PeiZMfZ7iO/6W7udze9XG2mwbOgL7LqRRZ6JGEMGAG5ELMkmeCPVNNxLCFPA3qVwuHPMPelXEuV6qvSD9WhNc0r8QeV7h8sm8nvzKlQ+456LZArWFTzfDCC3l0sBFqyFEV0pTxZoKRNA5YrSs64o+PzQPGJAeeoDtyTp84B3pCOHDfufRCw/laskZcuEGgxqalP3WCJMpSfRpAZ4DMPvmfd4r2bl42w1cH/aNPipBvs/BuMOygNeltxPZeAkEqdqtFN3j88PHuPfdAJYUW82ixNk5QWreAkQRhWOh7YKlctnL6ae6xIjeG/AnLzV5JnYRotFgJMC537vXJUuBNBDPK8rJogwnhtIB0/lUCRCTRNsbDfVGMjBP8+dexPYtrygluaqZAaHLJ54+XQ2hmw53SQ+TcgmFzdMF2NzKbsg3SbNK1bTv7VlmLDR1fIvCQ09kBnA0ndFXXKrnLk80gzWYbkB/FJzV+V9TvjAg1VQRpk8vGpB9pCapwrOV/dwKDUP4pfTz+Psnve6DVL9J3zkRbuUguVFywoBusJo/L/uJeXpCtyE/rkPZ3ECv7M0EjZGJgi2Nd8n4qgJhK9Xw== Neela Reddy@neela"
  #public_key = file("c/devops/daws-78s/devopspractice.pub")
  # ~ means windows home directory
}


module "vpn" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  key_name = aws_key_pair.vpn.key_name
  name = "${var.project_name}-${var.environment}-vpn"

  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
  # convert StringList to list and get first element
  subnet_id = local.public_subnet_id
  ami = data.aws_ami.ami_info.id
  
  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-vpn"
    }
  )
}