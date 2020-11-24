<p align="center"> <img src="https://user-images.githubusercontent.com/50652676/62349836-882fef80-b51e-11e9-99e3-7b974309c7e3.png" width="100" height="100"></p>


<h1 align="center">
    Terraform AWS Security Group
</h1>

<p align="center" style="font-size: 1.2rem;"> 
    This terraform module creates set of Security Group and Security Group Rules resources in various combinations.
     </p>

<p align="center">

<a href="https://www.terraform.io">
  <img src="https://img.shields.io/badge/terraform-v0.13-green" alt="Terraform">
</a>
<a href="LICENSE.md">
  <img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="Licence">
</a>


</p>
<p align="center">

<a href='https://facebook.com/sharer/sharer.php?u=https://github.com/devops4mecode/terraform-aws-security-group'>
  <img title="Share on Facebook" src="https://user-images.githubusercontent.com/50652676/62817743-4f64cb80-bb59-11e9-90c7-b057252ded50.png" />
</a>
<a href='https://www.linkedin.com/shareArticle?mini=true&title=Terraform+AWS+Security+Group&url=https://github.com/devops4mecode/terraform-aws-security-group'>
  <img title="Share on LinkedIn" src="https://user-images.githubusercontent.com/50652676/62817742-4e339e80-bb59-11e9-87b9-a1f68cae1049.png" />
</a>
<a href='https://twitter.com/intent/tweet/?text=Terraform+AWS+Security+Group&url=https://github.com/devops4mecode/terraform-aws-security-group'>
  <img title="Share on Twitter" src="https://user-images.githubusercontent.com/50652676/62817740-4c69db00-bb59-11e9-8a79-3580fbbf6d5c.png" />
</a>

</p>
<hr>
## Prerequisites

This module has a few dependencies: 

- [Terraform 0.13](https://learn.hashicorp.com/terraform/getting-started/install.html)
- [Go](https://golang.org/doc/install)
- [github.com/stretchr/testify/assert](https://github.com/stretchr/testify)
- [github.com/gruntwork-io/terratest/modules/terraform](https://github.com/gruntwork-io/terratest)

## Examples


**IMPORTANT:** Since the `master` branch used in `source` varies based on new modifications, we suggest that you use the release versions [here](https://github.com/devops4mecode/terraform-aws-security-group/releases).


### Simple Example
Here is an example of how you can use this module in your inventory structure:
```hcl
# use this
  module "security_group" {
    source        = "devops4mecode/security-group/aws"
    version       = "1.0.0"
    name          = "security-group"
    application   = "devops4me"
    environment   = "test"
    protocol      = "tcp"
    label_order   = ["environment", "application", "name"]
    vpc_id        = "vpc-xxxxxxxxx"
    allowed_ip    = ["172.16.0.0/16", "10.0.0.0/16"]
    allowed_ipv6  = ["2405:201:5e00:3684:cd17:9397:5734:a167/128"]
    allowed_ports = [22, 27017]
  }
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_ip | List of allowed ip. | `list` | `[]` | no |
| allowed\_ipv6 | List of allowed ipv6. | `list` | `[]` | no |
| allowed\_ports | List of allowed ingress ports. | `list` | `[]` | no |
| application | Application (e.g. `do4m` or `devops4me`). | `string` | `""` | no |
| description | The security group description. | `string` | `"Instance default security group (only egress access is allowed)."` | no |
| enable\_security\_group | Enable default Security Group with only Egress traffic allowed. | `bool` | `true` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| label\_order | Label order, e.g. `name`,`application`. | `list` | `[]` | no |
| managedby | ManagedBy, eg 'DevOps4Me' or 'NajibRadzuan'. | `string` | `"najibradzuan@devops4me.com"` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| prefix\_list | List of prefix list IDs (for allowing access to VPC endpoints)Only valid with egress | `list` | `[]` | no |
| protocol | The protocol. If not icmp, tcp, udp, or all use the. | `string` | `"tcp"` | no |
| security\_groups | List of Security Group IDs allowed to connect to the instance. | `list(string)` | `[]` | no |
| tags | Additional tags (e.g. map(`BusinessUnit`,`XYZ`). | `map(string)` | `{}` | no |
| vpc\_id | The ID of the VPC that the instance security group belongs to. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| security\_group\_ids | IDs on the AWS Security Groups associated with the instance. |
| tags | A mapping of public tags to assign to the resource. |

## Testing
In this module testing is performed with [terratest](https://github.com/gruntwork-io/terratest) and it creates a small piece of infrastructure, matches the output like ARN, ID and Tags name etc and destroy infrastructure in your AWS account. This testing is written in GO, so you need a [GO environment](https://golang.org/doc/install) in your system. 

You need to run the following command in the testing folder:
```hcl
  go test -run Test
```