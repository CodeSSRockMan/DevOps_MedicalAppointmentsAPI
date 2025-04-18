
# This module creates an IAM role and policies for EC2 instances to access SSM parameters and manage budgets.
resource "aws_iam_role" "ec2_ssm_role" {
  name = "EC2SSMRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      },
    ]
  })
}

resource "aws_iam_policy" "ssm_read_policy" {
  name = "EC2ReadSSMSecure"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath"
        ],
        Resource = "*"
      },
      {
        Effect   = "Allow",
        Action   = "kms:Decrypt",
        Resource = "*"
      }
    ]
  })
}
# Allow management of budgets in AWS
resource "aws_iam_policy" "budget_policy" {
  name        = "AllowBudgetManagement"
  description = "Allow management of budgets in AWS"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "budgets:ViewBudget",
          "budgets:ModifyBudget",
          "budgets:CreateBudget",
          "budgets:DescribeBudget",
          "budgets:DeleteBudget"
        ],
        Resource = "*"
      }
    ]
  })
}

# Attach the policies to the EC2 role
resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = aws_iam_policy.ssm_read_policy.arn
}
# Attach the policies to budget management role
resource "aws_iam_role_policy_attachment" "budget_access" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = aws_iam_policy.budget_policy.arn
}

# Create an instance profile for the EC2 role
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "EC2SSMProfile"
  role = aws_iam_role.ec2_ssm_role.name
}
