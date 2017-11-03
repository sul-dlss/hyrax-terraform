# Converting over all security groups.  These should be pulled into their
# relevant module, but it was easiest here to just run through them all at
# once.  When you pull something out of here, please delete it so that we can
# use this to track when all security groups are implemented.

# These will usually reference a vpc_id and possibly another security group
# that is being granted access.  Adjust variables as needed.

resource "aws_security_group" "solr" {
  vpc_id = "${var.vpc_id}"
  name   = "Solr security group"

  # TODO: This replicates what was there, I'm pretty sure, but I'm not actually
  #       sure if it makes sense.
  ingress {
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
  }
  ingress {
    security_groups = ["${var.SolrLbSecurityGroup}"]
    from_port       = 8983
    to_port         = 8983
    protocol        = "tcp"
  }

  tags {
    Name = "${var.StackName}-solr"
  }
}

resource "aws_security_group" "solr-lb" {
  vpc_id = "${var.vpc_id}"
  name   = "Solr load balancer security group"

  ingress {
    security_groups = ["${var.WebappSecurityGroup}"]
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
  }

  ingress {
    security_groups = ["${var.SolrSecurityGroup}"]
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
  }

  tags {
    Name = "${var.StackName}-solr-lb"
  }
}

resource "aws_security_group" "zookeeper-lb" {
  vpc_id = "${var.vpc_id}"
  name   = "Zookeeper load balancer security group"

  ingress {
    security_groups = ["${var.SolrSecurityGroup}"]
    from_port       = 2181
    to_port         = 2181
    protocol        = "tcp"
  }
  ingress {
    security_groups = ["${var.WebappSecurityGroup}"]
    from_port       = 2181
    to_port         = 2181
    protocol        = "tcp"
  }

  tags {
    Name = "${var.StackName}-zookeeper-lb"
  }
}

resource "aws_security_group" "zookeeper" {
  vpc_id = "${var.vpc_id}"
  name   = "Zookeeper security group"

  ingress {
    security_groups = ["${var.ZookeeperLbSecurityGroup}"]
    from_port       = 2181
    to_port         = 2181
    protocol        = "tcp"
  }
  ingress {
    security_groups = ["${var.SolrSecurityGroup}"]
    from_port       = 2181
    to_port         = 2181
    protocol        = "tcp"
  }
  ingress {
    security_groups = ["${var.ZookeeperLbSecurityGroup}"]
    from_port       = 8181
    to_port         = 8181
    protocol        = "tcp"
  }
  # TODO: This replicates what was there, I'm pretty sure, but I'm not actually
  #       sure if it makes sense.
  ingress {
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
  }

  tags {
    Name = "${var.StackName}-zookeeper"
  }
}
