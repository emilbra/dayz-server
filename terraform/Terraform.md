# How to use this terraform code

To use this code, first create a .tfvars file, similar to this:

```bash
tenant_id    = ""
vmsize       = ""
principal_id = ""
alert_email  = ""
```

Gather tenant_id and principal_id from your azure subscription. A suggested VMSize is Standard_D2s_v3.

Make sure you are authenticated against azure. This can be done using Azure Cli
``` az login ```
or using environment vars.

Then run terraform, like this:

1. ``` terraform init ```  - initializes the terraform module
2. ``` terraform plan -var-file myvars.tfvars ``` - creates a plan based on the current terraform code.
3. ``` terraform apply -var-file myvars.tfvars ``` - applies changes based on the current terraform code. You will be prompted to confirm.
4. ``` terraform Destroy -var-file myvars.tfvars ``` - Destroys infrastructure based on the current terraform code. You will be prompted to confirm