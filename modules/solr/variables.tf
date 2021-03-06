variable "application_name" {
  description = "Name for beanstalk application"
}

variable "environment_name" {
  description = "Name for beanstalk environment"
}

variable "environment_cname" {
  description = "CNAME for beanstalk environment"
}

variable "vpc_id" {
  description = "VPC id to deploy instances in"
}

variable "subnets" {
  description = "Subnets to deploy instances in"
  type = "list"
}

variable "key_name" {
  description = "Name of SSH key pair"
}

variable "version_label" {
  description = "Version label from beanstalk_application_version module"
}

variable "instance_type" {
  description = "Instance type to deploy"
  default = "t2.large"
}

variable "lb_security_groups" {
  description = "List of security groups to grant access to loadbalancer on port 80. This will be from the webapp"
  default = []
  type = "list"
}

variable "instance_security_groups" {
  description = "List of security groups to grant access to instances"
  default = []
  type = "list"
}

variable "hosted_zone_name" {
  description = "Route53 zone name within which to create a solr record"
}

variable "hosted_zone_id" {
  description = "Route53 zone name within which to create a solr record"
}

variable "zookeeper_hosts" {
  description = "Route53 round robin DNS record name for zookeeper hosts"
}
