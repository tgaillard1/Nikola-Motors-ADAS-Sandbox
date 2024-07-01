/**
 * Copyright 2023 Google LLC
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

/**
 * Copyright 2023 Google LLC
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

variable "project_id" {
  type        = string
  description = "The ID of the project in which the resource belongs"
}

variable "vmware_engine_network_id" {
  type        = string
  description = "The ID of the private cloud VPC network"
}

variable "peer_network_type" {
  type        = string
  description = "The type of the network to peer with the VMware Engine network. Possible values are: STANDARD, VMWARE_ENGINE_NETWORK, PRIVATE_SERVICES_ACCESS, NETAPP_CLOUD_VOLUMES, THIRD_PARTY_SERVICE, DELL_POWERSCALE."

  validation {
    condition     = contains(["STANDARD", "VMWARE_ENGINE_NETWORK", "PRIVATE_SERVICES_ACCESS", "NETAPP_CLOUD_VOLUMES", "THIRD_PARTY_SERVICE", "DELL_POWERSCALE"], var.peer_network_type)
    error_message = "Valid values for var: peer_network_type are (STANDARD, VMWARE_ENGINE_NETWORK, PRIVATE_SERVICES_ACCESS, NETAPP_CLOUD_VOLUMES, THIRD_PARTY_SERVICE, DELL_POWERSCALE)."
  }
}

variable "nw_name" {
  type        = string
  description = "The relative resource name of the VMware Engine network"
}

variable "nw_location" {
  type        = string
  description = "The relative resource location of the VMware Engine network"
}

variable "nw_project_id" {
  type    = string
  default = "The relative resource project of the VMware Engine network"
}

variable "peer_nw_name" {
  type        = string
  description = " The relative resource name of the network to peer with a standard VMware Engine network. The provided network can be a consumer VPC network or another standard VMware Engine network."
}

variable "peer_nw_location" {
  type        = string
  default     = "global"
  description = " The relative resource location of the network to peer with a standard VMware Engine network. The provided network can be a consumer VPC network or another standard VMware Engine network."
}

variable "peer_nw_project_id" {
  type        = string
  description = " The relative resource project of the network to peer with a standard VMware Engine network. The provided network can be a consumer VPC network or another standard VMware Engine network."
}

variable "gcve_peer_name" {
  type        = string
  description = "The ID of the Network Peering."
}

variable "gcve_peer_description" {
  type        = string
  default     = ""
  description = " User-provided description for this network peering."
}

variable "peer_export_custom_routes" {
  type        = bool
  default     = true
  description = "True if custom routes are exported to the peered network; false otherwise."
}

variable "peer_import_custom_routes" {
  type        = bool
  default     = true
  description = "True if custom routes are imported from the peered network; false otherwise."
}

variable "peer_export_custom_routes_with_public_ip" {
  type        = bool
  default     = false
  description = "True if all subnet routes with a public IP address range are exported; false otherwise"
}

variable "peer_import_custom_routes_with_public_ip" {
  type        = bool
  default     = false
  description = "True if custom routes are imported from the peered network; false otherwise."
}

## dns peering variables
variable "dns_peering" {
  type = bool
}

variable "dns_name" {
  type = string
}

variable "dns_zone_name" {
  type = string
}
