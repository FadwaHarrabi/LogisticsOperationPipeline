variable "minio_user" {
   type=string
   default="admin"
 
 }

 variable "minio_password" {
   type=string
   default="fadwa123@#"
   sensitive=true
 
 }