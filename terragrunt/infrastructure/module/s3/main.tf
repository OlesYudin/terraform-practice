resource "aws_s3_bucket" "main-s3" {
  bucket = "${var.local_tags.project_name}-${var.local_tags.env}-s3-bucket"

  tags = merge(
    var.local_tags,
    { Name = "${var.local_tags.project_name}-${var.local_tags.env}-bucket" }
  )
}
