variable "vpc_id" {}
variable "subnet_id" {}
variable "ssh_private_key" {
  description = "Private SSH key for EC2 instances"
  type        = string
  default     = ""  # Puede estar vacío si no se quiere asignar un valor por defecto
}