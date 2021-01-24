output "backend_service_id" {
value  = google_compute_backend_service.instance-group-backendservice.id
}

output "url-map-id" {
value  = google_compute_url_map.LB-url-map.id
}

output "target-http-proxy_id" {
value  = google_compute_target_http_proxy.target-http-prxy.id
}


output "healthcheck_self_link" {
value = google_compute_health_check.http-healthcheck.self_link   
}

output "LB_name" {
value  = google_compute_url_map.LB-url-map.name
}

output "LB_ip_address" {
value = google_compute_global_forwarding_rule.fw-rule-for-lb.ip_address
}
