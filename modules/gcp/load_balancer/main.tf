resource "google_compute_backend_service" "instance-group-backendservice" {

  name             = "regional-backend-service"

  description      = "Region Instance Group Backend Service"

  protocol         = "HTTP"

 port_name        = var.named_port_name



  health_checks   = [google_compute_health_check.http-healthcheck.id]

 #Change value to get more time to instance group autoscaler to complete its job

   timeout_sec      = 60

  session_affinity = "NONE"

  #load_balancing_scheme = "INTERNAL_SELF_MANAGED"

  backend {

     group          = var.instance_group


     balancing_mode = "UTILIZATION"

    # capacity_scaler = 1.0

     capacity_scaler = 0.8

  }


 depends_on = [google_compute_health_check.http-healthcheck]


}

# used to route requests to a backend service based on rules that you define for the host and path of an incoming URL

resource "google_compute_url_map" "LB-url-map" {

  project         = var.project

#  count           = var.create_url_map ? 1 : 0

  name            = "${var.lb_name}-lb"

 default_service = google_compute_backend_service.instance-group-backendservice.self_link

}

# HTTP proxy when http forwarding is true

resource "google_compute_target_http_proxy" "target-http-prxy" {

  project = var.project

#  count   = var.http_forward ? 1 : 0

  name    = "${var.lb_name}-proxy"

  url_map = google_compute_url_map.LB-url-map.self_link

}

resource "google_compute_global_forwarding_rule" "fw-rule-for-lb" {

  project    = var.project

 # count      = var.http_forward ? 1 : 0

  name       = "${var.lb_name}-fw-rule"

  target     = google_compute_target_http_proxy.target-http-prxy.self_link

  port_range = "8080"

}

# determine whether instances are responsive and able to do work

resource "google_compute_health_check" "http-healthcheck" {

  name = "${var.lb_name}-healthcheck"

  timeout_sec = 5

 check_interval_sec = 10

  healthy_threshold   = 2

  unhealthy_threshold = 3

   

         tcp_health_check {

     port = "8080"

     port_name = "tcp-hc"

   #  port_name = var.named_port_name

  #  request = "/"

  }  
}


