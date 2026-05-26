terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "networking" {
  source               = "./modules/networking"
  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "monitoring" {
  source       = "./modules/monitoring"
  project_name = var.project_name
  environment  = var.environment
}

module "storage" {
  source             = "./modules/storage"
  project_name       = var.project_name
  environment        = var.environment
  private_subnet_ids = module.networking.private_subnet_ids
  vpc_id             = module.networking.vpc_id
  redis_node_type    = var.redis_node_type
  redis_sg_id        = module.networking.redis_sg_id
}

module "compute" {
  source                   = "./modules/compute"
  project_name             = var.project_name
  environment              = var.environment
  vpc_id                   = module.networking.vpc_id
  public_subnet_ids        = module.networking.public_subnet_ids
  private_subnet_ids       = module.networking.private_subnet_ids
  instance_type            = var.instance_type
  min_size                 = var.min_size
  max_size                 = var.max_size
  desired_capacity         = var.desired_capacity
  ec2_sg_id                = module.networking.ec2_sg_id
  alb_sg_id                = module.networking.alb_sg_id
  bastion_sg_id            = module.networking.bastion_sg_id
  iam_instance_profile     = module.monitoring.iam_instance_profile
}