provider "kubernetes" {
  config_path = var.kubeconfig
}

resource "kubernetes_namespace" "sre_app" {
  metadata {
    name = "sre-app-zg-namespace"
  }
}

resource "kubernetes_service" "sre_app_lb" {
  metadata {
    name      = "sre-app-lb"
    namespace = kubernetes_namespace.sre_app.metadata[0].name
  }

  spec {
    selector = {
      app = "sre-app"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_horizontal_pod_autoscaler_v2" "sre_app_hpa" {
  metadata {
    name      = "sre-app-hpa"
    namespace = kubernetes_namespace.sre_app.metadata[0].name
  }

  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = "sre-app"
    }

    min_replicas = 2
    max_replicas = 5

    metrics {
      type = "Resource"
      resource {
        name   = "cpu"
        target {
          type    = "Utilization"
          average_utilization = 75
        }
      }
    }

    metrics {
      type = "Resource"
      resource {
        name   = "memory"
        target {
          type    = "Utilization"
          average_utilization = 75
        }
      }
    }
  }
}

resource "kubernetes_deployment" "sre_app" {
  metadata {
    name      = "sre-app"
    namespace = kubernetes_namespace.sre_app.metadata[0].name
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "sre-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "sre-app"
        }
      }

      spec {
        container {
          name  = "sre-app-container"
          image = "meu-repo/sre-app:latest"

          resources {
            requests {
              cpu    = "100m"
              memory = "256Mi"
            }

            limits {
              cpu    = "200m"
              memory = "512Mi"
            }
          }

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}
