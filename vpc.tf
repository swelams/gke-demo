
# VPC
resource "google_compute_network" "vpc" {
  name                    = "demo-vpc"
  auto_create_subnetworks = "false"
  routing_mode = "REGIONAL"
}

# mangement Subnet
resource "google_compute_subnetwork" "mangement-subnet" {
  name          = "mangement-subnet"
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = "10.10.0.0/16"
  private_ip_google_access= "true"
}

# Restricted Subnet
resource "google_compute_subnetwork" "restricted-subnet" {
  name          = "restricted-subnet"
  region        = var.region
  network       = google_compute_network.vpc.id 
  ip_cidr_range = "10.11.0.0/16"
  private_ip_google_access = "true"
}


 


#routing
resource "google_compute_router" "router" {
  name    = "my-router"
  network = google_compute_network.vpc.id 
  region = var.region 
  #bgp {
   # asn               = 64514
    #advertise_mode    = "CUSTOM"
    #advertised_groups = ["ALL_SUBNETS"]
    #advertised_ip_ranges {
     # range = "1.2.3.4"
    #}
    #advertised_ip_ranges {
     # range = "6.7.0.0/16"
    #}
  #}
}

#natgateway resoruce 

resource "google_compute_router_nat" "nat" {
  name                               = "my-router-nat"
  router                             = google_compute_router.router.name
  region                             = var.region 
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                             ="mangement-subnet"
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}


#my private virtual machiene 
resource "google_compute_instance" "vm_instance" {
  name         = "vm-instance"
  machine_type = "e2-micro" 
  zone = var.zone 

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.mangement-subnet.name
    network = google_compute_network.vpc.id  
    subnetwork_project = var.project_id

  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone = var.zone
  credentials = "${file("gke-service.json")}"
}
