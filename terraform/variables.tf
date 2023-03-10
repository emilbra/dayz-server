variable "vmsize" {
  type        = string
  default     = "Standard_D2s_v3"
  description = "Size of the vm. Recommended size is Standard_D2s_v3"
}

variable "tenant_id" {
  type        = string
  description = "the tenant id"
}

variable "principal_id" {
  type = string
}

variable "alert_email" {
  type = string
}