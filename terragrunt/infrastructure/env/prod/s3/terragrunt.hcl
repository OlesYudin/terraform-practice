terraform {
  source = "../../../module//s3"
}

include "root" {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../network"]
}
