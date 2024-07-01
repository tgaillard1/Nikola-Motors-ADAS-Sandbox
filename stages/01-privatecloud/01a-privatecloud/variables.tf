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


variable "project" {
  type        = string
  description = "Project where private cloud will be deployed"
}
variable "gcve_zone" {
  type        = string
  description = "Zone where private cloud will be deployed"
}
variable "gcve_region" {
  type        = string
  description = "Region where private cloud will be deployed"
}
variable "vmware_engine_network_name" {
  type        = string
  description = "Name of the vmware engine network for the private cloud"
}

variable "vmware_engine_network_type" {
  type        = string
  description = "Type of the vmware engine network for the private cloud"
  default     = "LEGACY"
}
variable "vmware_engine_network_location" {
  type        = string
  description = "Location of the vmware engine network for the private cloud"
  default     = "us-central1"
}

variable "vmware_engine_network_description" {
  type        = string
  description = "Description of the vmware engine network for the private cloud"
  default     = "PC Network"
}

variable "create_vmware_engine_network" {
  type        = bool
  description = "Set this value to true if you want to create a vmware engine network,"
}

variable "pc_name" {
  type        = string
  description = "Name of the private cloud that will be deployed"
}


variable "pc_cidr_range" {
  type        = string
  description = "CIDR range for the management network of the private cloud that will be deployed"
}

variable "base_cidr_range" {
  type        = string
  description = "CIDR range for the foundational network thet the private cloud will connect to"
}

variable "pc_description" {
  type        = string
  description = "Description for the private cloud that will be deployed"
  default     = "Private Cloud description"
}

variable "cluster_id" {
  type        = string
  description = "The cluster ID for management cluster in the private cloud"
}

variable "cluster_node_type" {
  type        = string
  description = "Specify the node type for the management cluster in the private cloud"
  default     = "standard-72"
}

variable "billing_id" {
  type        = string
  description = "Specify the customer billing ID"
}

variable "cluster_node_count" {
  type        = number
  description = "Specify the number of nodes for the management cluster in the private cloud"
  default     = 3
}
