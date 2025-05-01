variable "linode_token" {
  description = "Personal access token with at least 'Read/Write' on Linodes"
  type        = string
  sensitive   = true
}

variable "root_password" {
  description = "Initial root password (min 11 chars, incl. mixed case & numbers)"
  type        = string
  sensitive   = true
}

variable "ssh_public_key" {
  description = "Path to your SSH public key"
  type        = string
  default     = "~/.ssh/carlosm-lacnic-ed25519.pub"
}

variable "ssh_pub_key_2" {
  description = "Path to your SSH public key"
  type        = string
}

variable "ssh_private_key" {
  description = "Path to your SSH public key"
  type        = string
}


variable "region" {
  description = "Linode datacenter"
  type        = string
  default     = "br-gru"                # Miami; pick any region Linode offers
}

variable "instance_type" {
  description = "Plan/size of the VM"
  type        = string
  default     = "g6-standard-2"         # 4 GB RAM, 2 vCPU
}

variable "instance_label" {
  description = "Human-friendly name"
  type        = string
  default     = "lacnic43-lab"
}
