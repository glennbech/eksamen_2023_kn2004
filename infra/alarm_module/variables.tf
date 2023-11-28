variable "threshold" {
  type = number
  default = 25
}

variable "alarm_email" {
  type = string
  default = "candidate2004@proton.me"
}

variable "cloudwatch_namespace"{
    description = "The cloudwatch namespace where the metrics are located."
    default = "kn2004"
}

variable "prefix" {
  type = string
  default = "kn2004"
}