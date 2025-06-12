# Commenting out the code as the custom constraint is not possible, due to lack of autoclass attribute.

# resource "google_org_policy_custom_constraint" "cs_bucket_no_autoclass_on_dev" {
#   name         = "custom.csBucketNoAutoclassOnDev"
#   parent       = "organizations/251485126955"
#   display_name = "Bucket must have AutoClass or Lifecycle enabled"
#   description  = "Buckets must be created with AutoClass or at least one lifecycle rule."

#   action_type   = "DENY"
#   method_types  = ["CREATE"]
#   resource_types = ["storage.googleapis.com/Bucket"]

#   # The condition denies creation if neither AutoClass nor Lifecycle rule exists
#   condition = <<EOF
#     !(resource.autoclass.enabled == true || size(resource.lifecycle.rule) > 0)
#   EOF
# }

# resource "google_org_policy_policy" "enforce_cs_bucket_no_autoclass_on_dev" {
#   name   = "projects/aishwarya-orgpolicy-test/policies/${google_org_policy_custom_constraint.cs_bucket_no_autoclass_on_dev.name}"
#   parent = "projects/aishwarya-orgpolicy-test"

#   spec {
#     rules {
#       enforce = true
#     }
#   }
# }
