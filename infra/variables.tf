variable "prefix" {
    description = "The name of the aws apprunner service."
    default = "kn2004"
}

variable "img" {
    description = "The identifier of the image to use."
    default = "kn2004-ppe:latest"
}

variable "dashboard_name"{
    description = "Dashboard name."
    default = "kn2004-rekognition-dashboard"
}
