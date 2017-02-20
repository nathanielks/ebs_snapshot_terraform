# See https://docs.aws.amazon.com/lambda/latest/dg/tutorial-scheduled-events-schedule-expressions.html
# for how to write schedule expressions
variable "backups_schedule" {
  default = "cron(0 20 * * ? *)"
}

variable "janitor_schedule" {
  default = "cron(30 20 * * ? *)"
}

variable "backups_zip" {
  default = ""
}

variable "janitor_zip" {
  default = ""
}
