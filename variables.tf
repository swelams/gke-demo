variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

variable "zone" {
  description = "zone"
  
}

variable "node_zones" {
  type = list(string)
  description = "The zones where worker nodes are located"
}