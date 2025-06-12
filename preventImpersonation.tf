resource "google_org_policy_custom_constraint" "prevent_impersonation_compute_sa" {
  name         = "custom.preventImpersonationOfComputeSA"
  parent       = "organizations/251485126955"
  display_name = "Prevent Impersonation Compute SA"
  description  = "Do not allow impersonation, prevent granting roles (roles/iam.serviceAccountTokenCreator) to default compute engine service account."

  action_type  = "DENY"
  method_types = ["CREATE", "UPDATE"]
  resource_types = ["iam.googleapis.com/AllowPolicy"]

  condition = <<EOF
  resource.bindings.exists(
    binding, 
    RoleNameMatches(binding.role, ['roles/iam.serviceAccountTokenCreator']) && 
    binding.members.exists(
      member, 
      MemberSubjectEndsWith(member, ['-compute@developer.gserviceaccount.com']))
  )
  EOF
}

resource "google_org_policy_policy" "prevent_impersonation_policy" {
  name   = "projects/aishwarya-orgpolicy-test/policies/${google_org_policy_custom_constraint.prevent_impersonation_compute_sa.name}"
  parent = "projects/aishwarya-orgpolicy-test"

  spec {
    rules {
      enforce = true
    }
  }
}
