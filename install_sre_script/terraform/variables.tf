
variable "kubeconfig" {
  description = "Path to the kubeconfig file"
  type        = string
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
  default     = "my-cluster"
}
