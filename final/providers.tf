terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.203.0"
    }
  }
  required_version = "~>1.12.0"

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }

    bucket = "terr-hw-final"
    region = "ru-central1"
    key    = "terraform/final_project.tfstate"

    use_lockfile   = true
    use_path_style = true

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true

    shared_credentials_files = ["~/.yc/credentials"]
    profile                  = "netology"
  }

}


provider "yandex" {
  service_account_key_file = file("~/key.json")
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.default_zone
}

