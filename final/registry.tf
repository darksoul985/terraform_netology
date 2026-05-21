resource "yandex_container_registry" "app_registry" {
  name = var.registry_name
  labels = {
    environment = "develop"
    managed_by  = "terraform"
  }
}
