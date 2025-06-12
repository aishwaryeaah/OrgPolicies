resource "google_org_policy_custom_constraint" "deny_default_internet_route" {
  name         = "custom.denyInvalidRoute"
  parent       = "organizations/251485126955"
  display_name = "Deny Default Internet Route"
  description  = "Deny creation of a route with 0.0.0.0/0 destination and default internet gateway as next hop."

  action_type   = "DENY"
  method_types  = ["CREATE"]
  resource_types = ["compute.googleapis.com/Route"]

  condition = <<EOF
    resource.destRange == '0.0.0.0/0' && resource.nextHopGateway.endsWith('/global/gateways/default-internet-gateway')
  EOF
}

resource "google_org_policy_policy" "enforce_deny_default_internet_route" {
  name   = "projects/aishwarya-orgpolicy-test/policies/${google_org_policy_custom_constraint.deny_default_internet_route.name}"
  parent = "projects/aishwarya-orgpolicy-test"

  spec {
    rules {
      enforce = true
    }
  }
}