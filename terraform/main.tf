terraform {
  required_version = ">= 1.6"

  required_providers {
    linode = {
      source  = "linode/linode"
      version = "~> 2.17"   # any recent 2.x works – adjust if needed
    }
  }
}

provider "linode" {
  # Pass the API token securely, e.g. via the TF_VAR_linode_token env-var
  token = var.linode_token
}

resource "linode_instance" "ubuntu24" {
  label         = var.instance_label
  region        = var.region            # e.g. "us-mia"
  type          = var.instance_type     # e.g. "g6-standard-1"
  image         = "linode/ubuntu24.04"  # Ubuntu 24.04 LTS slug :contentReference[oaicite:0]{index=0}
  root_pass     = var.root_password     # required even if you SSH only
  authorized_keys = [
    # file(var.ssh_public_key)            # path to your public key
    var.ssh_pub_key_2
  ]

  tags = ["terraform", "ubuntu24", "lacnic43"]
}

resource "null_resource" "post_install" {
  depends_on = [linode_instance.ubuntu24]

  connection {
    type        = "ssh"
    user        = "root"
    host        = linode_instance.ubuntu24.ip_address
    # private_key = file(var.ssh_private_key)  # Add this var
    password = var.root_password
    timeout     = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "apt update",
      # "apt -y dist-upgrade",
      "apt install -y figlet rsync curl htop",
      "curl -sL https://containerlab.dev/setup | sudo -E bash -s \"all\""
    ]
  }
}

output "ip_address" {
  description = "Public IPv4 address of the new Linode"
  value       = linode_instance.ubuntu24.ip_address
}
