# Terraform config for automatic EBS snapshots

This repo contains a terraform configuration that creates two lambda functions
that will take automatic EBS snapshots at regular intervals. It is based on
the code at
<https://serverlesscode.com/post/lambda-schedule-ebs-snapshot-backups/> and
<https://serverlesscode.com/post/lambda-schedule-ebs-snapshot-backups-2/>.

## Usage

### Terraform Module

This is intended for use as a module in another project. You would include it like so:
```
// ... other resources

module "ebs_backups" {
  source = "github.com:mivok/ebs_snapshot_terraform"
}
```

It exposes the following variables:

- `backups_schedule`: a `rate` or `cron` expression. Defaults to `cron(0 20 * * ? *)`. See [Schedule Expressions][schedule-expressions] for more info.
- `janitor_schedule`: a `rate` or `cron` expression. Defaults to `cron(30 20 * * ? *)`. See [Schedule Expressions][schedule-expressions] for more info.
- `backups_zip`: the filepath to the file to use as the scheduled backup Lambda function. Lambda functions uploaded via terraform need to be uploaded as a zip file.
- `janitor_zip`: the filepath to the file to use as the janitor Lambda function. Lambda functions uploaded via terraform need to be uploaded as a zip file.

If you wanted to run a backup every hour:
```
module "ebs_backups" {
  source = "github.com:mivok/ebs_snapshot_terraform"

  backups_schedule = "rate(1 hour)"
}
```

If you wanted to use your own backup script:
```
module "ebs_backups" {
  source = "github.com:mivok/ebs_snapshot_terraform"

  backups_zip = "${path.module}/backup.zip"
}
```

### Configuring your instances to be backed up

Tag any instances you want to be backed up with `Backup = true`.

By default, old backups will be removed after 7 days, to keep them longer, set
another tag: `Retention = 14`, where 14 is the number of days you want to keep
the backups for.

## Contributing

### Updating the script

Lambda functions uploaded via terraform need to be uploaded as a zip file. To
change the code, make your changes to the python code and then run `make`.
This will create/update the zip files for terraform to re-upload.

[schedule-expressions]: http://docs.aws.amazon.com/lambda/latest/dg/tutorial-scheduled-events-schedule-expressions.html
