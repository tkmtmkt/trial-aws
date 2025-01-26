trial-aws
=========

```sh
alias aws='podman run --rm -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli'
alias terraform='podman run --rm -w /root -v $(pwd):/root/ hashicorp/terraform'
```

```
terraform init
terraform validate
terraform fmt
terraform plan
terraform apply
terraform destroy
```
