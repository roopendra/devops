# Apply Terraform Configuration

```
git clone https://github.com/roopendra/devops.git
cd terraform/terraform-apply
terraform init
```

## Apply configuration

When you apply this configuration, Terraform will:

- Lock your project's state, so that no other instances of Terraform will attempt to modify your state or apply changes to your resources. If Terraform detects an existing lock file (`.terraform.tfstate.lock.info`), it will report an error and exit.
- Create a plan, and wait for you to approve it. Alternatively, you can provide a saved speculative plan created with the `terraform plan` command, in which case Terraform will not prompt for approval.
- Execute the steps defined in the plan using the providers you installed when you initialized your configuration. Terraform executes steps in parallel when possible, and sequentially when one resource depends on another.
- Update your project's state file with a snapshot of the current state of your resources.
- Unlock the state file.
- Print out a report of the changes it made, as well as any output values defined in your configuration.

**Apply the configuration**   
``` 
terraform apply
```
Respond to the confirmation prompt with a `yes` to apply the proposed execution plan.

**Clean up infrastructure**  
``` 
terraform destroy
```
