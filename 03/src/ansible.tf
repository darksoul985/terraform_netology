resource "local_file" "ansible_inventory" {
  depends_on = [yandex_compute_instance.web, yandex_compute_instance.database, yandex_compute_instance.storage]
  content = templatefile("${path.module}/templates.tpl", {
    webservers = yandex_compute_instance.web,
    databases  = [for key, val in yandex_compute_instance.database : val],
    storage    = yandex_compute_instance.storage
    }
  )
  filename = "${path.module}/inventory.ini"
}



