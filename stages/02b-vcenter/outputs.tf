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

output "folder_l1" {
  value       = module.folder_l1
  description = "The entity IDs for all level 1 folders"
}

output "folder_l2" {
  value       = module.folder_l2
  description = "The entity IDs for all level 2 folders"
}

output "vsphere_resource_pool" {
  value       = module.resource_pool
  description = "Vsphere Resource Pool object"
}