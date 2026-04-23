# Настройка подключения к удаленному docker через ssh
provider "docker" {
  host = "ssh://soul@${yandex_compute_instance.vm-1.network_interface.0.nat_ip_address}:22"
  # ssh_opts = ["-i", "~/.ssh/id_ed25519"]
}

# генерация случайных паролей
resource "random_password" "mysql_root_pwd" {
  length           = 16
  special          = true
  override_special = "!#*()-_=+"
}

resource "random_password" "mysql_user_pwd" {
  length  = 12
  special = true
}

# описание образа и контейнера
resource "docker_image" "mysql_8" {
  name         = "mysql:8"
  keep_locally = true
}

resource "docker_container" "mysql_server" {
  name  = "mysql_db"
  image = docker_image.mysql_8.image_id

  # проброс порта
  ports {
    internal = 3306
    external = 3306
    ip       = "127.0.0.1"
  }
  # передача переменных окружения
  env = [
    "MYSQL_ROOT_PASSWORD=${random_password.mysql_root_pwd.result}",
    "MYSQL_DATABASE=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_PASSWORD=${random_password.mysql_user_pwd.result}",
    "MYSQL_ROOT_HOST=%"
  ]
  # ожидание, пока поднимется ВМ и установиться docker
  depends_on = [yandex_compute_instance.vm-1]
}

# вывести пароли в консоль
output "mysql_root_password" {
  value     = random_password.mysql_root_pwd.result
  sensitive = true
}
output "mysql_user_password" {
  value     = random_password.mysql_user_pwd.result
  sensitive = true
}
