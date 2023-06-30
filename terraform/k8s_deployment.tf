resource "kubernetes_deployment" "athena_create" {
  metadata {
    name = "athena-create-deployment"
    labels = {
      app = "athena-create"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "athena-create"
      }
    }

    template {
      metadata {
        labels = {
          app = "athena-create"
        }
      }

      spec {
        container {
          image = "athenaCreate:latest"
          name  = "athena-create-container"
          
          resources {
            limits {
              cpu    = "1"
              memory = "1Gi"
            }
            requests {
              cpu    = "0.5"
              memory = "500Mi"
            }
          }

          port {
            container_port = 80
          }

          volume_mount {
            name       = "storage-volume"
            mount_path = "/opt/storage"
          }
        }

        volume {
          name = "storage-volume"

          persistent_volume_claim {
            claim_name = "athena-create-pvc"
          }
        }
      }
    }
  }
}

resource "kubernetes_horizontal_pod_autoscaler" "athena_create_hpa" {
  metadata {
    name = "athena-create-hpa"
  }
  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = kubernetes_deployment.athena_create.metadata.0.name
    }
    min_replicas = 3
    max_replicas = 10
    target_cpu_utilization_percentage = 50
  }
}
