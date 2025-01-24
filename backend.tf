terraform {
  backend "s3" {
    bucket = "saisanjay-1"
    key = "my-terraform-environment/main"
    region = "ap-south-1"
    dynamodb_table = "Terrafom-lock-db-table"
    
  }
}