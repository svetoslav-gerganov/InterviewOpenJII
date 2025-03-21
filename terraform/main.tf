module "ecs" {
  source                = "./modules/ecs"
  cluster_name          = "${var.app_name}-cluster-${var.environment}"
  task_family           = "${var.app_name}-task-${var.environment}"
  container_definitions = jsonencode([
    {
      "name"      : "${var.app_name}-task-${var.environment}",
      "image"     : var.docker_image,
      "essential" : true,
      "portMappings" : [{
        "containerPort" : 3000,
        "hostPort"      : 3000
      }],
      "memory" : 512,
      "cpu"    : 256
    }
  ])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  service_name             = "${var.app_name}-service-${var.environment}"
  desired_count            = 3
  target_group_arn         = module.alb.target_group_arn
  container_port           = 3000
  subnets                  = module.vpc.subnets
  assign_public_ip         = true
  security_groups          = [module.security_groups.ecs_sg_id]
  environment              = var.environment
  app_name                 = var.app_name
}

module "alb" {
  source                = "./modules/alb"
  alb_name              = "${var.app_name}-lb-${var.environment}"
  subnets               = module.vpc.subnets
  security_groups       = [module.security_groups.lb_sg_id]
  target_group_name     = "${var.app_name}-tg-${var.environment}"
  target_group_port     = 80
  target_group_protocol = "HTTP"
  vpc_id                = module.vpc.vpc_id
  listener_port         = 80
  listener_protocol     = "HTTP"
}


module "vpc" {
  source       = "./modules/vpc"
  cidr_block   = "10.0.0.0/16"
  app_name     = var.app_name
  environment  = var.environment
  aws_region   = var.aws_region
}


module "security_groups" {
  source       = "./modules/security_groups"
  app_name     = var.app_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
}


module "cloudwatch" {
  source              = "./modules/cloudwatch"
  app_name            = var.app_name
  environment         = var.environment
  retention_in_days   = 7
  evaluation_periods  = 1
  period              = 60
  cpu_threshold       = 80
  memory_threshold    = 80
  ecs_cluster_name    = module.ecs.ecs_cluster_id
  ecs_service_name    = module.ecs.ecs_service_name
  sns_topic_arn       = "arn:aws:sns:eu-central-1:123456789012:app-alerts"
}