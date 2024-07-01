/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

data "nsxt_policy_edge_cluster" "this" {
  display_name = var.edge_cluster_name
}

data "nsxt_policy_tier0_gateway" "this" {
  display_name = var.tier0_gateway_name
}

data "nsxt_policy_tier1_gateway" "this" {
  display_name = var.tier1_gateway_name
}

data "nsxt_policy_transport_zone" "transport_zone" {
  display_name = var.transport_zone_name
}

module "vm_segments" {
  source   = "../../modules/nsxt-segment/"
  for_each = { for k, v in var.segments : v.display_name => v }

  connectivity_path    = data.nsxt_policy_tier1_gateway.this.path
  display_name         = each.value.display_name
  resource_description = each.value.description
  segment_cidr         = each.value.cidr
  tags                 = each.value.tags
  transport_zone_path  = data.nsxt_policy_transport_zone.transport_zone.path
}

module "gwf_policies" {
  depends_on = [module.vm_segments]
  source     = "../../modules/nsxt-gateway-firewall/"
  for_each   = { for k, v in var.gwf_policies : v.display_name => v }

  display_name = each.value.display_name
  rules        = each.value.rules
  scope_path   = data.nsxt_policy_tier1_gateway.this.path
}

module "dfw_policies" {
  depends_on = [module.vm_segments]
  source     = "../../modules/nsxt-distributed-firewall-policy/"
  for_each   = { for k, v in var.dfw_policies : v.display_name => v }

  display_name    = each.value.display_name
  sequence_number = each.value.sequence_number
  rules           = each.value.rules
  scope           = []
}