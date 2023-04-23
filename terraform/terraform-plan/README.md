# Create a Terraform Plan  
```
git clone https://github.com/roopendra/devops.git
cd terraform/terraform-plan
terraform init
```
### Create a plan  
There are three commands that tell Terraform to generate an execution plan:  

1. The `terraform plan` command lets you to preview the actions Terraform would take to modify your infrastructure, or save a speculative plan which you can apply later. The function of `terraform plan` is speculative: you cannot apply it unless you save its contents and pass them to a `terraform apply` command. In an automated Terraform pipeline, applying a saved plan file ensures the changes are the ones expected and scoped by the execution plan, even if your pipeline runs across multiple machines.

2. The `terraform apply` command is the more common workflow outside of automation. If you do not pass a saved plan to the apply command, then it will perform all of the functions of plan and prompt you for approval before making the changes.

3. The `terraform destroy` command creates an execution plan to delete all of the resources managed in that project.

Generate a saved plan with the `-out` flag. You will review and apply this plan later in this tutorial.

```
$ terraform plan -out tfplan

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

   docker_container.nginx will be created
  + resource "docker_container" "nginx" {

#...

Plan: 7 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────

Saved the plan to: tfplan

To perform exactly these actions, run the following command to apply:
    terraform apply "tfplan"
    
```

You can apply the saved plan file to execute these changes, but the contents are not in a human-readable format. Use the `terraform show -json` command to convert the plan contents into JSON, then pass it to `jq` to format it and save the output into a new file.

```
terraform show -json tfplan | jq > tfplan.json
```

### Review a plan
In order to determine the planned changes for your run, Terraform reconciles the prior state and the current configuration. In this section, you will review the data Terraform captures about your resources in a plan file.

#### Review planned resource changes

Review the planned resources changes to the `docker_image.nginx` resource.

The representation includes:

- The `action` field captures the action taken for this resource, in this case `create`.  
- The `before` field captures the resource state prior to the run. In this case, the value is `null` because the resource does not yet exist.  
- The `after` field captures the state to define for the resource.  
- The `after_unknown` field captures the list of values that will be computed or determined through the operation and sets them to `true`.  
- The `before_sensitive` and `after_sensitive` fields capture a list of any values marked `sensitive`. Terraform will use these lists to determine which output values to redact when you apply your configuration.  

```
$ jq '.resource_changes[] | select( .address == "docker_image.nginx")' tfplan.json
{
  "address": "docker_image.nginx",
  "mode": "managed",
  "type": "docker_image",
  "name": "nginx",
  "provider_name": "registry.terraform.io/kreuzwerker/docker",
  "change": {
    "actions": [
      "create"
    ],
    "before": null,
    "after": {
      "build": [],
      "force_remove": null,
      "keep_locally": false,
      "name": "nginx:latest",
      "pull_trigger": null,
      "pull_triggers": null,
      "triggers": null
    },
    "after_unknown": {
      "build": [],
      "id": true,
      "image_id": true,
      "latest": true,
      "output": true,
      "repo_digest": true
    },
    "before_sensitive": false,
    "after_sensitive": {
      "build": []
    }
  }
}
```
#### Review planned values

```
$ jq '.planned_values' tfplan.json
{
  "root_module": {
    "resources": [
     #...
        "address": "docker_image.nginx",
        "mode": "managed",
        "type": "docker_image",
        "name": "nginx",
        "provider_name": "registry.terraform.io/kreuzwerker/docker",
        "schema_version": 0,
        "values": {
          "build": [],
          "force_remove": null,
          "keep_locally": false,
          "name": "nginx:latest",
          "pull_trigger": null,
          "pull_triggers": null,
          "triggers": null
        },
        "sensitive_values": {
          "build": []
        }
      },
   #...
```

The `planned_values` object also lists the resources created by child modules in a separate list, and includes the address of the module.  

```
$ jq '.planned_values.root_module.child_modules' tfplan.json
[
  {
    "resources": [
      {
        "address": "module.hello.random_pet.number_2",
        "mode": "managed",
        "type": "random_pet",
        "name": "number_2",
        "provider_name": "registry.terraform.io/hashicorp/random",
        "schema_version": 0,
        "values": {
          "keepers": {
            "hello": "World"
          },
          "length": 2,
          "prefix": null,
          "separator": "-"
        },
        "sensitive_values": {
          "keepers": {}
        }
      },
#...
      }
    ],
    "address": "module.nginx-pet"
  }
]
```

### Apply a saved plan
```
terraform apply tfplan
```
Validate if Terraform created the two containers.

```
docker ps
```


#### Error: Could not retrieve providers for locking
**Solution** 
The Terraform command, `providers lock`, can be used to update the lock file
after consulting the source registries in order to add any new registry supplied
hashes to the lock file.

```
terraform providers lock
```
