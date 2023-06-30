# Agora
![Agora Banner, apac.ai/Agora](Agora-Banner-blend.png)
Agora is a collective of creators, [join us and help create Athena Create and or receive support!](https://discord.gg/qUtxnK2NMf)

# Athena Create - The Everything App
**Welcome to Athena Create, the epicenter of creation and collaboration.** 

![Athena Create Logo](AthenaCreate.png)

*Art, science, and the future converge here. This is Athena Create.*

## Overview

Athena Create empowers you to bring your ideas to life using state-of-the-art AI models. Whether you're imagining stunning visuals, composing symphonies, or crafting captivating videos, Athena Create serves as your versatile canvas. But it's more than just a tool — it's a thriving community where creators meet, collaborate, and inspire each other.

## Features

**Create**: Unlock your creativity with the power of AI. Generate images, compose music, and design videos — all in one place. 

**Collaborate**: Join a vibrant community of creators. Share your projects, invite feedback, and collaborate with fellow innovators to push the boundaries of what's possible.

**Inspire**: Take part in community challenges, earn badges, and get recognized for your work. Your creations might just be the spark that ignites another's imagination.

## Getting Started
There are 2 methods, 1 local no docker, and docker:

### Method 1
1. Fork and clone the Athena Create repository.
2. Start the backend: 
```bash
# setup env
cd server
conda create -n athena python=3.8
conda activate athena
conda install pytorch torchvision torchaudio pytorch-cuda=11.7 -c pytorch -c nvidia
pip install -r requirements.txt

# download models. Make sure that `git-lfs` is installed.
cd models
bash download.sh # required when `inference_mode` is `local` or `hybrid`. 

# run server
cd ..
python models_server.py --config configs/config.default.yaml # required when `inference_mode` is `local` or `hybrid`
python awesome_chat.py --config configs/config.default.yaml --mode server # for text-davinci-003
```
3. Prepare frontend: `cd frontend` then Install dependencies with `npm install` then start dev server: `npm run dev`

# Method2
Docker, not done yet

## How to Contribute

We welcome contributions from anyone and everyone. To get started, take a look at our [Contribution Guidelines](https://github.com/kyegomez/Athena-Create/blob/main/CONTRIBUTING.md).

## Share with Friends and Family

Unleash the power of social media and let your creations reach every corner of the globe. Share your Athena Create projects on:

- [Facebook](https://www.facebook.com/sharer/sharer.php?u=https://github.com/kyegomez/Athena-Create)
- [Twitter](https://twitter.com/intent/tweet?text=Check%20out%20my%20new%20creation%20on%20Athena%20Create!&url=https://github.com/kyegomez/Athena-Create)
- [LinkedIn](https://www.linkedin.com/sharing/share-offsite/?url=https://github.com/kyegomez/Athena-Create)
- [Instagram](instagram://camera)
- [Pinterest](http://pinterest.com/pin/create/button/?url=https://github.com/kyegomez/Athena-Create)
- [WhatsApp](https://wa.me/?text=Check%20out%20my%20new%20creation%20on%20Athena%20Create!%20https://github.com/kyegomez/Athena-Create)
- [Telegram](https://telegram.me/share/url?url=https://github.com/kyegomez/Athena-Create&text=Check%20out%20my%20new%20creation%20on%20Athena%20Create!)

## License

Shield: [![CC BY-NC-SA 4.0][cc-by-nc-sa-shield]][cc-by-nc-sa]

This work is licensed under a
[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
[cc-by-nc-sa-shield]: https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg

## Final Thoughts

Athena Create is not just an app — it's a vision for a future where anyone can be an artist, where creativity is democratized, and where the boundary between reality and imagination blurs. We invite you to join us on this journey

.

*Turn the ethos of creation into the echo of the cosmos. This is Athena Create.*



# Roadmap

* Brute force to functional prototype that takes in user input, text or multi-modal => sends to swarm => worker node uses model from HF to complete the user task

* Implement Database logic

* Deploy on AWS at `create.apac.ai`

* Optimize for reliability and speed

# Kubernetes Documentation

Here is a brief guide on how to use the provided Kubernetes configuration files:

### Prerequisites

1. **Kubernetes Cluster**: Make sure you have access to a Kubernetes cluster. You can set one up on a cloud provider like AWS, GCP, Azure, or locally using tools like minikube or kind.

2. **Kubectl**: Kubectl is a command line tool for controlling Kubernetes clusters. Make sure it's installed on your machine and configured to interact with your Kubernetes cluster. You can verify that kubectl is working correctly by running `kubectl version`.

3. **Docker Image**: The Docker image `athenaCreate:latest` should be available in a registry accessible by the Kubernetes cluster.

### Instructions

The provided scripts create various resources in your Kubernetes cluster. Here's how you can use them:

1. **Create Persistent Volume and Persistent Volume Claim**: To create the persistent volume and volume claim, run the command:

    ```
    kubectl apply -f athena-create-pv-and-pvc.yaml
    ```

    This will create a PersistentVolume and PersistentVolumeClaim which are used for storing data.

2. **Create Deployment and Service**: To create the Deployment and Service, run the command:

    ```
    kubectl apply -f athena-create-deployment-and-service.yaml
    ```

    This will create a Deployment which manages the running of your application, and a Service which exposes your application to the network.

3. **Create Horizontal Pod Autoscaler**: To create the Horizontal Pod Autoscaler, run the command:

    ```
    kubectl apply -f athena-create-hpa.yaml
    ```

    This will create a HorizontalPodAutoscaler which automatically scales the number of pods in your deployment based on CPU usage.

### Managing your Kubernetes Resources

You can use the `kubectl` command line tool to manage your Kubernetes resources. Here are some common commands:

- `kubectl get pods`: Lists all pods in the current namespace.
- `kubectl get svc`: Lists all services in the current namespace.
- `kubectl get hpa`: Lists all horizontal pod autoscalers in the current namespace.
- `kubectl get pv` and `kubectl get pvc`: Lists all persistent volumes and persistent volume claims, respectively.
- `kubectl describe <resource>/<name>`: Provides more detail about a specific resource (like a Pod, Service, etc.)
- `kubectl delete -f <file>`: Deletes the resources defined in a file.

### Notes

- In a real-world scenario, it's often better to use a namespace to isolate your application resources. This can be done by adding a `metadata.namespace` field to all resources, or by appending `-n <namespace>` to all `kubectl` commands.
- Persistent Volumes are a complex topic, and the provided configuration might not work in all scenarios (for example, in a multi-node cluster). In such cases, consider using a StorageClass and dynamic provisioning.
- Make sure to monitor your application to ensure that the autoscaling is working as expected.
- The resource limits and requests, as well as the autoscaling parameters, should be adjusted based on the requirements of your application and the resources of your cluster. The provided values are just examples.


---------------------


# Terraform

In order to deploy the above Kubernetes resources to AWS using Terraform, you can follow the plan outlined below. Please note that deploying a Kubernetes cluster to AWS involves many steps and decisions based on your specific requirements, this is a simplified guide:

**Plan**

1. **Provisioning AWS infrastructure:** We'll use AWS EKS (Elastic Kubernetes Service) as it manages the Kubernetes control plane for you. For this, we'll need an EKS cluster and worker nodes.

2. **Setup Kubernetes Provider:** Once the EKS cluster is created, we'll use the Kubernetes provider to manage resources inside the Kubernetes cluster (e.g., deployment, service, HPA).

3. **Deploy the Kubernetes resources:** Once we have the Kubernetes provider set up, we can deploy the Kubernetes resources.

Now, let's proceed to the Terraform scripts:

1. **Terraform Configuration** (main.tf)

```hcl
provider "aws" {
  region  = "us-west-2"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-eks-cluster"
  cluster_version = "1.21"
  subnets         = module.vpc.private_subnets

  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 10
      min_capacity     = 1

      instance_type = "m5.large"
      key_name      = "my-key"

      additional_tags = {
        Environment = "test"
        Name        = "eks-worker-node"
      }
    }
  }
}

data "aws_ami" "eks_worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-1.21-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI account ID
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = module.eks.cluster_token
  load_config_file       = false
  version                = "~> 2.3"
}

```

2. **Deploying Kubernetes resources**

Now that the EKS cluster is set up and the Kubernetes provider is configured, we can manage Kubernetes resources. We can define the Kubernetes resources in Terraform in a similar way to how we did with the Kubernetes YAML. 

Note: For simplicity, I'll only show a partial translation of the Deployment. Translating the Service, PVC, PV, and HPA to Terraform is a similar process. Here's how you could define the Deployment in Terraform:

```hcl
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
```

**Instructions:**

1. **Install Terraform:** Make sure you have Terraform installed on your machine.

2. **Configure AWS Credentials:** Make sure your AWS credentials are properly configured. You can set the AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables, or use AWS profiles.

3. **Terraform Initialization:** Navigate to the directory containing the Terraform scripts and run `terraform init`. This will download the necessary provider plugins.

4. **Terraform Plan:** Run `terraform plan` to see what changes will be made.

5. **Terraform Apply:** Run `terraform apply` to apply the changes. It will show you a plan and you will need to confirm it.

**Please Note:**

- The above code is a simple demonstration of how one can deploy a Kubernetes cluster using EKS and Terraform. There are many factors to consider when deploying to production, including network setup, security, IAM roles, and more.
- Make sure to replace the placeholder values in the code with actual values suitable for your environment.
- Managing Kubernetes resources with Terraform is a bit more complex compared to using YAML and `kubectl`. If your team is comfortable with Kubernetes and `kubectl`, consider using Terraform just to set up the EKS cluster and `kubectl` to manage the resources inside the cluster.


-------------------------------------- 

**Deployment Plan:**

1. **Review and Update Infrastructure Configuration:** Review your `main.tf` script and make sure that all configurations meet your production requirements. This includes subnet configurations, EKS node group settings (instance type, min/max nodes), etc.

2. **IAM Roles and Security:** Create necessary IAM roles and security groups for your EKS cluster and nodes. Make sure only necessary permissions are given.

3. **Network Setup:** Make sure your VPC, subnets, routing, and NAT Gateways are correctly configured and follow best practices. If you're deploying the app in an existing network, adjust the network settings in `main.tf`.

4. **Secrets Management:** Avoid hardcoding any sensitive data or secrets in your scripts. Use AWS Secrets Manager or similar services to manage your secrets.

5. **Terraform Backend:** Configure a Terraform backend for storing your Terraform state. This is crucial for managing your infrastructure in a team.

6. **Testing:** Test your Terraform scripts in a non-production environment first. Validate if the resources are created and configured correctly.

7. **Continuous Deployment:** Set up a CI/CD pipeline for your app. When changes are pushed to your app's repository, the pipeline should build a new Docker image, push it to a registry, and update the Kubernetes Deployment.

8. **Monitoring and Logging:** Set up monitoring and logging for your EKS cluster and your app. AWS CloudWatch can be used for this purpose.

9. **Auto Scaling:** Test if the Kubernetes HPA is correctly configured and scaling your app based on CPU usage.

10. **Disaster Recovery:** Make sure you have a disaster recovery plan in place. This includes regular backups of your app data and a plan to restore from these backups.

11. **Maintenance:** Plan for regular maintenance of your EKS cluster. This includes Kubernetes version upgrades, node updates, etc.

12. **Apply Changes:** Finally, use the `terraform apply` command to create your EKS cluster and deploy your app. Monitor the output and resolve any errors if they come up.

This plan provides a general guide but every production environment will have its own requirements, so make sure to adapt this plan as needed.



# Terraform Deployment

Once you have your Terraform scripts ready (`main.tf` and `k8s_deployment.tf`), you can run the following commands to use them:

**Initialize Terraform**

The first command to run in the directory where your Terraform files are located is:

```bash
terraform init
```

This will download the necessary providers (AWS and Kubernetes in this case) for Terraform.

**Create an Execution Plan**

To see what changes Terraform will apply, you can create an execution plan:

```bash
terraform plan
```

**Apply Changes**

If the plan looks correct, you can apply it:

```bash
terraform apply
```

Terraform will again show you the planned changes and ask for confirmation before applying them.

**Destroy Resources**

If you want to remove all resources managed by Terraform, you can use the destroy command:

```bash
terraform destroy
```

Again, Terraform will show you what will be destroyed and ask for confirmation.

**Note:** 

- Before you can run these commands, you need to have Terraform installed on your machine.
- Also, make sure that your AWS credentials are set up correctly. You can use environment variables, `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`, or configure them in the AWS credentials file.
- Remember that `terraform apply` and `terraform destroy` can make significant changes to your infrastructure. Always review the plan before confirming any changes.