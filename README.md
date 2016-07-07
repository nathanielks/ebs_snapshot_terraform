# Terraform config for automatic EBS snapshots

This repo contains a terraform configuration that creates two lambda functions
that will take automatic EBS snapshots at regular intervals. It is based on
the code at
<https://serverlesscode.com/post/lambda-schedule-ebs-snapshot-backups/> and
<https://serverlesscode.com/post/lambda-schedule-ebs-snapshot-backups-2/>.

## Usage

### Running terraform

Make sure you have an AWS API key set up for your account in
`~/.aws/credentials`, then run:

    AWS_PROFILE=myprofile terraform plan
    AWS_PROFILE=myprofile terraform apply

If you set up your credentials as the default profile, you can skip the
`AWS_PROFILE` environment variable setting and just run `terraform
plan`/`terraform apply` directly.

Once you have run terraform apply, commit the terraform state file.

### Configuring your instances to be backed up

Tag any instances you want to be backed up with `Backup = true`.

By default, old backups will be removed after 7 days, to keep them longer, set
another tag: `Retention = 14`, where 14 is the number of days you want to keep
the backups for.

## Updating the script

Lambda functions uploaded via terraform need to be uploaded as a zip file. To
change the code, make your changes to the python code and then run `make`.
This will create/update the zip files for terraform to re-upload.
