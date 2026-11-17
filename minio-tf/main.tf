terraform {
  required_providers {
    minio = {
      source  = "aminueza/minio"
      version = "~> 3.0"   
    }
  }
}
provider "minio" {
  minio_server   = "localhost:9000"  
  minio_user     = var.minio_user
  minio_password = var.minio_password
  minio_ssl      = false           
}

resource "minio_s3_bucket" "logistics-operation" {
  bucket = "logistics-operation"
  acl    = "private"
}