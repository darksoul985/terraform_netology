#cloud-config
users:
  - name: ${ssh_user}
    groups: sudo
    shell: /bin/bash
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    ssh_authorized_keys:
      - ${ssh_public_key}

runcmd:
    curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

    chmod +x /usr/local/bin/docker-compose

    usermod -aG docker ${ssh_user}

    IAM_TOKEN=$(curl -s --header Metadata-Flavor:Google http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token | jq -r .access_token)

    echo $IAM_TOKEN | docker login --username iam --password-stdin cr.yandex

    docker run -d --restart=always --name app-web -p 80:5000 -e DB_HOST='${db_host}' -e DB_USER='${db_user}' -e DB_PASSWORD='$PASSWORD_DB' -e DB_NAME='${db_name}' ${full_image_name}
