/*
resource "aws_iam_user" "deployer" {
  count = length(var.username)
  name = element(var.username, count.index)
}
*/

resource "aws_iam_user" "deployer" {
  name = var.user
}

resource "aws_iam_policy" "deployer_policy" {
  name = "pdb_iam_policy"
  policy = file("deployer-policy.json")
}

resource "aws_iam_user_policy_attachment" "deployer_policy_attachment" {
  count = length(var.username)
  user = element(aws_iam_user.deployer.*.name, count.index)
  policy_arn = aws_iam_policy.deployer_policy.arn
}

resource "local_file" "policyarn" {
    content     = "${aws_iam_policy.deployer_policy.arn}"
    filename = "${path.module}/policy_arn.txt"
}

data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
}
}

resource "aws_iam_policy" "ingress_policy" {
  name = "ALBIngressControllerIAMPolicy"
  policy = file("ALBIngressControllerIAMPolicy.json")
}

resource "aws_iam_role" "ALBIngressControllerIAMPolicyRole" {
  name                = "ALBIngressControllerIAMPolicyRole"
  path = "/"
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json
  managed_policy_arns = [aws_iam_policy.ingress_policy.arn]
}

resource "local_file" "rolearn" {
    content     = "${aws_iam_role.ALBIngressControllerIAMPolicyRole.arn}"
    filename = "${path.module}/role_arn.txt"
}
