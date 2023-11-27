variable "prefix" {
    description = "The name of the aws apprunner service."
    default = "kn2004"
}

variable "cloudwatch_namespace"{
    description = "The cloudwatch namespace where the metrics are located."
    default = "kn2004"
}

variable "img" {
    description = "The identifier of the image to use."
    default = "244530008913.dkr.ecr.eu-west-1.amazonaws.com/2004-ecr-repo:latest"
}

variable "dashboard_name"{
    description = "Dashboard name."
    default = "kn2004-rekognition-dashboard"
}

variable "metrics_region"{
    description = "Metrics region."
    default = "eu-west-1"
}