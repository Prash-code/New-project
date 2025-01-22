# Run first terraform-15days/day-3-resources_for_backend_s3_dynamodb to create reources 
# This backend configuration instructs Terraform to store its state in an S3 bucket.
 terraform {
backend "s3" {
    bucket         = "project-statefile-999"  # Name of the S3 bucket where the state will be stored.
    region         =  "us-east-1"
    key            = "terraform.tfstate" # Path within the bucket where the state will be read/written.
    #dynamodb_table = "terraform-state-lock-dynamodbb" # DynamoDB table used for state locking, note: first run day-3-bckend resources then day-4-backend config
    encrypt        = true  # Ensures the state is encrypted at rest in S3.
}
}