output "security_group_ids" {
  description = "A list of SGs to attach to ec2 or lambda"
  value       = [aws_security_group.http-instance.id]
}
output "private_load_balancer_arn" {
  description = "The private LB arn"
  value       = aws_lb.null-main-balancer-internal.arn
}
output "private_load_balancer_listener_arn" {
  description = "The private LB Listener arn"
  value       = aws_lb_listener.null-main-internal-listener-https.arn
}
output "public_load_balancer_arn" {
  description = "The public LB arn"
  value       = aws_lb.null-main-balancer.arn

}
output "public_load_balancer_listener_arn" {
  description = "The public LB listener arn"
  value       = aws_lb_listener.null-main-listener-https.arn
}
