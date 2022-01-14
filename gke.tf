resource "google_container_cluster" "gke_cluster" {
  name                     = "gke-cluster"
  location                 = var.region 
  project                  = var.project_id 
  remove_default_node_pool = true
  initial_node_count       = 1
  network    = google_compute_network.vpc.id
  subnetwork = google_compute_subnetwork.restricted-subnet.id

  ip_allocation_policy {
    cluster_ipv4_cidr_block = "10.101.0.0/16"
    services_ipv4_cidr_block = "10.102.0.0/16"
  }

  private_cluster_config {
    enable_private_endpoint = true 
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "10.100.100.0/28"
  }
  
  master_auth {
	client_certificate_config {
      issue_client_certificate = false
    }
  }

master_authorized_networks_config {
    cidr_blocks {
      display_name = "bastion access"
      cidr_block   = "${google_compute_instance.vm_instance.network_interface.0.network_ip}/32"
    }
  }

 
  
  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }
    http_load_balancing {
      disabled = false
    }
}
}
