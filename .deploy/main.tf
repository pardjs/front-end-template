resource "null_resource" "docker-compose" {
  connection {
    host = "${var.serverHost}"
    user = "${var.serverUser}"

    private_key = "${
      length(var.serverUserPrivateKey) > 0
      ? var.serverUserPrivateKey
      : file(var.serverUserPrivateKeyPath)
    }"
  }

  provisioner "remote-exec" {
    inline = ["mkdir -p /root/deploy/template"]
  }

  provisioner "file" {
    content = "${templatefile(
      ".deploy/docker-compose.yaml.tpl",
      {
        appVersion = "${var.appVersion}"
      }
    )}"
    destination = "/root/deploy/template/docker-compose.yaml"
  }

  provisioner "remote-exec" {
    inline = [
      "docker-compose -f /root/deploy/template/docker-compose.yaml up -d"
    ]
  }
}

// TF_VAR_serverHost
variable "serverHost" {
  type        = "string"
  description = "the server host to deploy"
  default     = "devops.do021.com"
}

// TF_VAR_serverUser
variable "serverUser" {
  type        = "string"
  description = "the user on server used to deploy"
  default     = "root"
}

// Private key should be added on CI tools
// TF_VAR_serverUserPrivateKeyPath
variable "serverUserPrivateKeyPath" {
  type        = "string"
  description = "the private key for the user"
  default     = "~/.ssh/id_rsa"
}

// TF_VAR_serverUserPrivateKeyPath
variable "serverUserPrivateKey" {
  type        = "string"
  description = "the private key for the user"
  default     = ""
}

variable "appVersion" {
  type        = "string"
  description = "the version of current application"
}
