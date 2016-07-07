# See https://docs.aws.amazon.com/lambda/latest/dg/tutorial-scheduled-events-schedule-expressions.html
# for how to write schedule expressions
variable "ebs_snapshot_backups_schedule" {
  default = "cron(0 20 * * ? *)"
}

variable "ebs_snapshot_janitor_schedule" {
  default = "cron(30 20 * * ? *)"
}
