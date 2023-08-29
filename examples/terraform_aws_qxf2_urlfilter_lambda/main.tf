
resource "null_resource" "install_dependencies" {
  triggers = {
    files = filesha256("${path.module}/lambda_functions/requirements.txt")
  }

  provisioner "local-exec" {
    command = "pip3 install -r lambda_functions/requirements.txt -t ${path.module}/lambda_functions/"
  }
}

data "archive_file" "function_zip" {
  source_dir =  "lambda_functions/"
  type        = "zip"
  output_path = "lambda_functions/url_filter_lambda.zip"
  depends_on  = [null_resource.install_dependencies]
  
}
resource "aws_lambda_function" "lambda_functions" {
  function_name = "url_filtering_lambda"
  role = aws_iam_role.IndiraUser.arn
  filename = data.archive_file.function_zip.output_path
  source_code_hash = data.archive_file.function_zip.output_base64sha256
  handler = "url_filtering_lambda.lambda_handler"  
  runtime = "python3.8"  
  environment {
    variables = {
      SKYPE_SENDER_QUEUE_URL ="${var.SKYPE_SENDER_QUEUE_URL}"
      CHATGPT_API_KEY ="${var.CHATGPT_API_KEY}"
      CHATGPT_VERSION="${var.CHATGPT_VERSION}"
      URL="${var.URL}"
      DEFAULT_CATEGORY="${var.DEFAULT_CATEGORY}"
      API_KEY_VALUE="${var.API_KEY_VALUE}"
      LOCALSTACK_ENV="${var.LOCALSTACK_ENV}"
      ETC_CHANNEL="${var.ETC_CHANNEL}"
      employee_list=jsonencode(var.employee_list)
      Qxf2Bot_USER="${var.Qxf2Bot_USER}"

    }
  }
}

resource "aws_iam_role" "IndiraUser" {
  name = "IndiraLambdaUser"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}