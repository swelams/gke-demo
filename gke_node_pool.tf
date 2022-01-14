resource "google_container_node_pool" "node_pool" {
  name           = "gke-node-pool"
  location       = var.region 
  cluster        = google_container_cluster.gke_cluster.id
  node_locations = var.node_zones
  node_count     = 1 


 autoscaling {
    min_node_count = 1
    max_node_count = 6
  }

  node_config {
    preemptible  = false
    machine_type = "e2-medium"  #"e2-micro"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    labels = {
      cluster = google_container_cluster.gke_cluster.name
    }
  }

  
}