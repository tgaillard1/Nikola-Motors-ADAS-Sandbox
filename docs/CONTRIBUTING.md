# How to Contribute

We'd love to accept your patches and contributions to this project. There are
just a few small guidelines you need to follow.

## Contributor License Agreement

Contributions to this project must be accompanied by a Contributor License
Agreement. You (or your employer) retain the copyright to your contribution;
this simply gives us permission to use and redistribute your contributions as
part of the project. Head over to <https://cla.developers.google.com/> to see
your current agreements on file or to sign a new one.

You generally only need to submit a CLA once, so if you've already submitted one
(even if it was for a different project), you probably don't need to do it
again.

## Code reviews

All submissions, including submissions by project members, require review. We
use GitHub pull requests for this purpose. Consult
[GitHub Help](https://help.github.com/articles/about-pull-requests/) for more
information on using pull requests.

## Community Guidelines

This project follows
[Google's Open Source Community Guidelines](https://opensource.google/conduct/).

## Strategy

Code aims to be as close as possible as
[GCP Fabric modules](https://github.com/GoogleCloudPlatform/cloud-foundation-fabric).

## Structure

```
├── modules
│    |── vcenter-folder
│    |── vcenter-role
│    |── vcenter-resource-pool
│       ├── main.tf
│       ├── outputs.tf
│       ├── README.md
│       ├── variables.tf
│       └── versions.tf
├──examples
│    |── vcenter-folder
│    |── vcenter-role
│    |── vcenter-resource-pool
│       ├── main.tf
│       ├── outputs.tf
│       ├── terraform.tfvars.example
│       ├── variables.tf
│       └── versions.tf
├──stages
│   ├── 01-privatecloud
│       ├── main.tf
│       ├── outputs.tf
│       ├── README.md
│       ├── terraform.tfvars.example
│       ├── variables.tf
│       └── versions.tf
│   └── 02-xxx
└── tests
```

Optionally: other Terraform files that cover specifically one implementation
part in complement to `main.tf`. Same rules as `main.tf` apply to those
Terraform files.

## Checklist

-  Each module has an `outputs.tf` file that at least covers all the
    resources id created by the module
-  Each output should have a description field
-  Each module has `variables.tf` with description field
-  `README.md` should explain any pre-requisite (for example, creation of
    certificates for example)

**Tip**: Test that the module works for another environment to check that all
pre-requisites are properly specified

## Example

-  An example in the examples folder should illustrate the creation of only
    one module item and not a list of items.
-  An example in the stages folder can illustrate the creation of a list of
    module calls
-  Have an example that covers the common cases and remove redundancy (for
    example, we can provide an example with only 2 folder children instead of
    3. If we showed some optional value for one folder, we can omit the
    optional values for the other folders)
-  There should be a file `terraform.tfvars.example`.

## Inside Module - main.tf

-  Related locals {}, data {}, resource {} are in the same file and in this
    order
-  Unlike classic Terraform, "this" is not used but rather the name of the
    resource or a descriptive name. It enables us to have more than one
    resource of this type (cf
    [example](https://github.com/GoogleCloudPlatform/cloud-foundation-fabric/blob/master/modules/folder/organization-policies.tf)
    in Fabric) and to have a clearer description. For example:
    [resource "google_essential_contacts_contact" "contact"](https://github.com/GoogleCloudPlatform/cloud-foundation-fabric/blob/master/modules/folder/main.tf)
    or
    [data "google_iam_policy" "authoritative"](https://github.com/GoogleCloudPlatform/cloud-foundation-fabric/blob/master/modules/organization/iam.tf)
-  The same type of resource can be created in 2 different modules
    (google_compute_firewall_policy_rule in
    [folder](https://github.com/GoogleCloudPlatform/cloud-foundation-fabric/blob/master/modules/folder/firewall-policies.tf)
    and in
    [organization](https://github.com/GoogleCloudPlatform/cloud-foundation-fabric/blob/master/modules/organization/firewall-policies.tf))
    - in the case the resource to be created is very thin
-  It should create a single main resource (not a list of resources of the
    same type. Examples or factory examples could do that though such as
    [project factory](https://github.com/GoogleCloudPlatform/cloud-foundation-fabric/tree/master/fast/stages/03-project-factory))
-  If it creates different types of resources, it might be possible to add a
    variable that enables the user to specify if they want to create a resource
    or use an existing resource. (Example: var.folder_create in
    [folder](https://github.com/GoogleCloudPlatform/cloud-foundation-fabric/blob/master/modules/folder/main.tf))
-  Make sure to use resources {} and data {} block properly: module
    shouldn't create resources that are out of their scope. For example, if we
    want to create a module that create firewall rules on tier 1 gateway, we
    don't want to create a resource for the tier 1 gateway but rather refers to
    an existing tier 1 gateway.
-  In some cases, we might want to define a variable with a single value:
    myValue whereas the provider has a list instead. So we would use it like
    [myValue]. In this case, make sure that by doing so, we're not restricting
    the user too much in case they might want to pass a list instead. In this
    case, we might want to use a variable which is a list instead.
-  When creating resources (this doesn't apply for data blocks and this
    might not be problematic for dynamic blocks which would trigger an update
    of the resource - however for consistency it's probably follow the same
    rules for data and dynamic blocks as well when possible):
    -  We shouldn't use "count" when there are more than 1 resource
        (but instead for_each) because it might recreate resources if we change
        the order ; apply also can potentially fail for this reason.
    -  For_each should not take as key a value that can be changed by
        the user. Otherwise, when this change occurs, it will delete and
        recreate the resource. Apply might fail as well for this reason
        (for_each should operate on values which are less likely to change not
        on ephemeral values such as description fields)

> Note: in the case a user changes a key that is not likely to change, they
can use[ move
blocks](https://www.terraform.io/language/modules/develop/refactoring) to
refactor it
## Inside Module - variables.tf

-  For each variable, set description
-  When a variable is sensitive, mark it as such in the variable and output
    block (cf
    [sensitive](https://www.terraform.io/language/values/variables#suppressing-values-in-cli-output))
-  Variables should be listed in alphabetical order (this
    [tool](https://www.libredevops.org/quickstart/utils/scripts/linux/sort-terraform-variables.html)
    might be used)
-  List all keys of map and specify if a key is optional 
    ```
    type = list(object({
      display_name       = string
      disabled           = optional(bool) 
      ...
    ```

-  For variables associated to variables of provider, default should is set
    to null (ex:
    [folder](https://github.com/GoogleCloudPlatform/cloud-foundation-fabric/blob/master/modules/folder/variables.tf))
    unless it's not secure (in this case, we should it to the secure value)
    -  Pros
        -  A user can refer to provider docs for defaults and will
            always get the provider default
        -  We don't need to think about defaults

    -  Cons
        -  In the event that the upstream provider default changes
            there could be unintended consequences. For example, an edge case
            consequence could be a resource recreation.

-  Cover all optional variables of the provider (unless there are lots of
    option variables)
-  If a variable is optional in the provider, it should be also optional in
    the module.
    -  Solution 1: set a default value to null or a map to {}
    -  Solution 2: Since, it's not possible to have an optional variable
        directly, we can instead encapsulate all the optional variables in an
        object type and use optional fields (example in Fabric:
        [bigquery_dataset](https://github.com/GoogleCloudPlatform/cloud-foundation-fabric/blob/master/modules/bigquery-dataset/variables.tf)
        - optional fields are not used in Fabric - however we would be able to
        use it inside an options variable)

-  There can be predefined default values declared as object (Example: [project_factory](https://github.com/GoogleCloudPlatform/cloud-foundation-fabric/blob/master/examples/factories/project-factory/main.tf))
    ```
    labels = merge(coalesce(var.labels, {}), coalesce(try(var.defaults.labels, {}), {}) )
    ```
    Or
    ```
    essential_contacts = concat(try(var.defaults.essential_contacts, []), var.essential_contacts)
    ```

-  Optional variables in the provider should be set like: `priority =
    try(each.value.priority, null)`
-  If only specific values should be used, a validation must be in place. Example:
    ```
    validation {
      condition = alltrue([
          for k, v in var.logging_sinks :
          contains(["bigquery", "logging", "pubsub", "storage"], v.type)
      ])
      error_message = "Type must be one of 'bigquery', 'logging', 'pubsub', 'storage'."
    }
    ```

## Inside Module - outputs.tf

-  Outputs should be listed in alphabetical order (this
    [tool](https://www.libredevops.org/quickstart/utils/scripts/linux/sort-terraform-variables.html)
    might be used).
-  For each output, set description.
-  There should be at least all ids created by the module. If the module
    creates resources of the same type, it should be a map so that it's
    possible to match the resource key with the resource id. The resource key
    should be the same as the one used in `variables.tf`.

## Inside Module - versions.tf

-  Specify Terraform required version, required providers and provider versions.