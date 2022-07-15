module "ec2" {
  source = "./modules/ec2-basic"
  vpc_id              = module.vpc.vpc_id
  vpc_public_subnets  = module.vpc.public_subnets[0]
  key_name            = "ec2-key"
  list_security_group = [module.securitygroup.allow_private_sg_id]
}
