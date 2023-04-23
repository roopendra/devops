# Initialize a Terraform Working Directory

```
git clone https://github.com/roopendra/devops.git
cd terraform/terraform-init
terraform init
terraform validate
```

### Review initialization artifacts
When Terraform initializes a new Terraform directory, it creates a lock file named `.terraform.lock.hcl` and the `.terraform` directory.

### Update provider and module versions
In versions.tf, update the random provider's version to 3.0.1.

**versions.tf**  
```
terraform {
  required_providers {
    ## ..
    random = {
      source = "hashicorp/random"
      version = "3.0.1"
    }
  }
}
```
In main.tf, update the hello module's version to 3.1.0.

**main.tf**  
```
module "hello" {
  source  = "joatmon08/hello/random"
  version = "3.1.0"

  hello = random_pet.dog.id

 secret_key = "secret"
}
```

### Reinitialize configuration
```
terraform validate
terraform init
terraform init -upgrade
```

### Reconcile configuration  
Since you have updated your provider and module version, check whether your configuration is still valid.

```
$ terraform validate
╷
│ Error: Missing required argument
│ 
│   on main.tf line 29, in module "hello":
│   29: module "hello" {
│ 
│ The argument "second_hello" is required, but no definition was found.
╵
```

The new version of the hello module expects a new required argument. Add the `second_hello` required argument to the `hello` module.

**main.tf**  
```
module "hello" {
  source  = "joatmon08/hello/random"
  version = "3.1.0"

  hello = random_pet.dog.id
  second_hello = random_pet.dog.id

  secret_key = "secret"
}
```
**Re-validate your configuration.**
```
$ terraform validate
Success! The configuration is valid.
```

Now your Terraform project is initialized and ready to be applied.


