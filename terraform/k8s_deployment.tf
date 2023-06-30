resource "kubernetes_deployment" "athena_create" {
  metadata {
    name = "athena-create-deployment"
    labels = {
      app = "athena-create"
    }
  }

  spec {
    replicas = 1

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
