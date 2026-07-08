variable "region" {
  default = "eu-central-1"
}

variable "vpc_id" {
  default = "vpc-05d7df2e0fad8cb52"
}

variable "public_subnet_1" {
  default = "subnet-0225483f87d5dabc8"
}

variable "public_subnet_2" {
  default = "subnet-04dde5c9625d7bceb"
}

variable "public_subnet_3" {
  default = "subnet-02ed1e3bca698dfb3"
}

variable "db_password" {
  default   = "tato0681201111"
  sensitive = true
}

variable "docker_image" {
  default = "zvmarko/taskmanager:latest"
}

variable "database_url" {
  description = "PostgreSQL connection string"
  sensitive   = true
}
