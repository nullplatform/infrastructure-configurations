resource "random_uuid" "encryption_key" {
}

resource "aws_secretsmanager_secret" "nullservice_params_encryption" {
  name = "nullservice/params-${var.organization}-${var.account}-${var.namespace}-${var.suffix}"
}

resource "aws_secretsmanager_secret_version" "encryption_key" {
  secret_id     = aws_secretsmanager_secret.nullservice_params_encryption.id
  secret_string = <<EOF
        {
          "encryption_key": "${random_uuid.encryption_key.result}"
        }
        EOF
}
