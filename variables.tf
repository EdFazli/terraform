#########################
# Variables Declaration #
#########################
variable "region" {
  type = string
  description = "Which region you want to provision your resources? Default: ap-southeast-1"
  default = "ap-southeast-1"
}