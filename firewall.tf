resource "google_compute_firewall" "lb" {
  name        = "k8s-fw-abdca8a7bd83f4a84a8fb7a869242967"
  network     = google_compute_network.vpc.id
  project     = var.project_id
  description = "{\"kubernetes.io/service-name\":\"default/nginx\", \"kubernetes.io/service-ip\":\"35.235.121.183\"}"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}
resource "google_compute_firewall" "lb2" {
  name        = "k8s-fw-abdca8a7bd83f4a84a8fb7a86924"
  network     = google_compute_network.vpc.id
  project     = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}
