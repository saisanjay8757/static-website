# Create S3 bucket
resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucketname
}

# Configure bucket ownership to allow ACLs
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.mybucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Configure public access block (optional)
resource "aws_s3_bucket_public_access_block" "example" {
  bucket                  = aws_s3_bucket.mybucket.id
  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

# Set bucket-wide ACL for public-read
resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.mybucket.id
  acl    = "public-read"
}

# Upload objects with individual ACLs
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.mybucket.id
  key          = "index.html"
  source       = "index.html"
  acl          = "public-read"
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.mybucket.id
  key          = "error.html"
  source       = "error.html"
  acl          = "public-read"
  content_type = "text/html"
}

resource "aws_s3_object" "style" {
  bucket       = aws_s3_bucket.mybucket.id
  key          = "style.css"
  source       = "style.css"
  acl          = "public-read"
  content_type = "text/css"
}

resource "aws_s3_object" "script" {
  bucket       = aws_s3_bucket.mybucket.id
  key          = "script.js"
  source       = "script.js"
  acl          = "public-read"
  content_type = "text/javascript"
}

# Enable S3 website hosting
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.mybucket.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
  depends_on = [aws_s3_bucket_acl.example]
}
