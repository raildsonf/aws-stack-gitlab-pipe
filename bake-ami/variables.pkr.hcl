variable "access_key" {
  default = env("AWS_ACCESS_KEY_ID")
}

variable "secret_key" {
  default = env("AWS_SECRET_ACCESS_KEY")
}