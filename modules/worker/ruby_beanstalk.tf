data "aws_elastic_beanstalk_solution_stack" "ruby" {
  most_recent = true
  name_regex  = "^64bit Amazon Linux (.*) running Ruby (.*)Puma(.*)$"
}

data "aws_region" "current" {
  current = true
}

resource "aws_elastic_beanstalk_environment" "worker" {
  name                = "${var.environment_name}"
  application         = "${var.application_name}"
  version_label       = "${var.version_label}"
  tier                = "Worker"
  solution_stack_name = "${data.aws_elastic_beanstalk_solution_stack.ruby.name}"

  lifecycle {
    ignore_changes = ["version_label"]
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "${var.min_size}"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = "${var.max_size}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "${var.instance_type}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = "${var.key_name}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SSHSourceRestriction"
    value     = "tcp,22,22,10.0.0.0/16"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = "${join(",", sort(var.security_groups))}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "${var.iam_instance_profile}"
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "MeasureName"
    value     = "CPUUtilization"
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "Statistic"
    value     = "Maximum"
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "Unit"
    value     = "Percent"
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "UpperThreshold"
    value     = "85"
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "LowerThreshold"
    value     = "30"
  }

  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateEnabled"
    value     = "true"
  }

  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateType"
    value     = "Health"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "${var.vpc_id}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${join(",", var.subnets)}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = "${join(",", var.subnets)}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application"
    name      = "Application Healthcheck URL"
    value     = "/"
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "DeploymentPolicy"
    value     = "Immutable"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "LoadBalanced"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = "aws-elasticbeanstalk-service-role"
  }

  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "AWS_REGION"
    value     = "${data.aws_region.current.name}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DATABASE"
    value     = "${var.db_name}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DATABASE_USER"
    value     = "${var.db_username}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DATABASE_PASSWORD"
    value     = "${var.db_password}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DATABASE_HOST"
    value     = "${var.db_hostname}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DATABASE_PORT"
    value     = "${var.db_port}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "FEDORA_URL"
    value     = "${var.fcrepo_url}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "FILE_SYSTEM_ID"
    value     = "${var.efs_filesystem}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "HONEYBADGER_API_KEY"
    value     = "${var.honeybadger_key}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "HONEYBADGER_ENV"
    value     = "${var.honeybadger_env}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "MOUNT_DIRECTORY"
    value     = "${var.efs_mount_path}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "PROCESS_ACTIVE_ELASTIC_JOBS"
    value     = "true"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RAILS_SERVE_STATIC_FILES"
    value     = "true"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "REDIS_HOST"
    value     = "${var.redis_host}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "REDIS_PORT"
    value     = "${var.redis_port}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SECRET_KEY_BASE"
    value     = "${var.rails_secret_key}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SOLR_URL"
    value     = "${var.solr_url}hydrox_dev"
  }

  setting {
    namespace = "aws:elasticbeanstalk:sqsd"
    name      = "HttpConnections"
    value     = "5"
  }

  setting {
    namespace = "aws:elasticbeanstalk:sqsd"
    name      = "WorkerQueueURL"
    value     = "${var.sqs_queue_name}"
  }
}
