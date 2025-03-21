###############

# output "alb_arn" {
#   value = module.alb.alb_arn
# }

# output "alb_dns_name" {
#   value = module.alb.alb_dns_name
# }

# output "target_group_arn" {
#   value = module.alb.target_group_arn
# }

# output "vpc_id" {
#   value = module.vpc.vpc_id
# }

# output "subnet_ids" {
#   value = module.vpc.subnet_ids
# }

# output "lb_sg_id" {
#   value = module.security_groups.lb_sg_id
# }

# output "ecs_sg_id" {
#   value = module.security_groups.ecs_sg_id
# }


output "log_group_name" {
  value = module.cloudwatch.log_group_name
}

# output "cpu_alarm_arn" {
#   value = module.cloudwatch.cpu_alarm_arn
# }

# output "memory_alarm_arn" {
#   value = module.cloudwatch.memory_alarm_arn
# }

#Log the load balancer app URL
output "app_url" {
  value = module.alb.alb_dns_name
}