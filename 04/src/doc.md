## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_example-vm"></a> [example-vm](#module\_example-vm) | git::https://github.com/udjin10/yandex_compute_instance.git | main |
| <a name="module_second_task"></a> [second\_task](#module\_second\_task) | ./modules/second | n/a |
| <a name="module_test-vm"></a> [test-vm](#module\_test-vm) | git::https://github.com/udjin10/yandex_compute_instance.git | main |

## Resources

| Name | Type |
|------|------|
| [template_file.cloudinit](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name                                                                                     | Description                                                            | Type           | Default                              | Required |
| ---------------------------------------------------------------------------------------- | ---------------------------------------------------------------------- | -------------- | ------------------------------------ | :------: |
| <a name="input_cloud_id"></a> [cloud\_id](#input\_cloud\_id)                             | https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id  | `string`       | n/a                                  |   yes    |
| <a name="input_default_cidr"></a> [default\_cidr](#input\_default\_cidr)                 | https://cloud.yandex.ru/docs/vpc/operations/subnet-create              | `list(string)` | <pre>[<br>  "10.0.1.0/24"<br>]</pre> |    no    |
| <a name="input_default_cidr_b"></a> [default\_cidr\_b](#input\_default\_cidr\_b)         | https://cloud.yandex.ru/docs/vpc/operations/subnet-create              | `list(string)` | <pre>[<br>  "10.0.2.0/24"<br>]</pre> |    no    |
| <a name="input_default_zone"></a> [default\_zone](#input\_default\_zone)                 | https://cloud.yandex.ru/docs/overview/concepts/geo-scope               | `string`       | `"ru-central1-a"`                    |    no    |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id)                          | https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id | `string`       | n/a                                  |   yes    |
| <a name="input_vm_db_name"></a> [vm\_db\_name](#input\_vm\_db\_name)                     | example vm\_db\_ prefix                                                | `string`       | `"netology-develop-platform-db"`     |    no    |
| <a name="input_vm_web_name"></a> [vm\_web\_name](#input\_vm\_web\_name)                  | example vm\_web\_ prefix                                               | `string`       | `"netology-develop-platform-web"`    |    no    |
| <a name="input_vms_ssh_root_key"></a> [vms\_ssh\_root\_key](#input\_vms\_ssh\_root\_key) | ssh-keygen -t ed25519                                                  | `string`       | `"~/.ssh/id_ed25519"`                |    no    |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name)                             | VPC network&subnet name                                                | `string`       | `"develop"`                          |    no    |