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
  name = "pdb_policy"
  policy = file("deployer-policy.json")
}

resource "aws_iam_user_policy_attachment" "deployer_policy_attachment" {
  count = length(var.username)
  user = element(aws_iam_user.deployer.*.name, count.index)
  policy_arn = aws_iam_policy.deployer_policy.arn
}

resource "local_file" "foo" {
    content     = "${aws_iam_user.deployer.arn}"
    filename = "${path.module}/local-output-files/pdb_policy_arn.txt"
}
