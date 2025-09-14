# Capstone GitOps Project

This project demonstrates a GitOps workflow using ArgoCD, Kustomize, and Argo Rollouts for multi-environment deployments with canary releases and automated rollbacks.

## 🚀 Features

- **GitOps Workflow**: Declarative infrastructure and application management
- **Multi-Environment Support**: Separate configurations for dev, staging, and production
- **Canary Deployments**: Progressive delivery with Argo Rollouts
- **Automated Rollbacks**: Based on Prometheus metrics and analysis
- **Security Scanning**: GitHub Actions workflow with Trivy and kube-score
- **Monitoring**: Prometheus and Grafana integration

## 🔄 CI/CD Workflow

The GitHub Actions workflow (`.github/workflows/ci-cd.yml`) includes these jobs:

1. **Lint and Validate**:
   - YAML linting
   - Kubernetes manifest validation
   - Kustomize build verification

2. **Security Scan**:
   - Container image scanning with Trivy
   - Kubernetes manifest analysis with kube-score

3. **Build and Push**:
   - Builds Docker image
   - Pushes to DockerHub with `latest` and commit SHA tags

4. **Deploy**:
   - Updates Kustomize manifests with new image tags
   - Deploys to Kubernetes using kustomize
   - Waits for rollout to complete

5. **Notify**:
   - Sends success/failure notifications to Slack (if configured)

## 🛠️ Tools Used

- **Kubernetes**: Container orchestration
- **ArgoCD**: GitOps tool for Kubernetes
- **Kustomize**: Kubernetes native configuration management
- **Argo Rollouts**: Advanced deployment strategies (Canary, Blue/Green)
- **Prometheus**: Monitoring and alerting
- **Grafana**: Visualization and dashboards
- **GitHub Actions**: CI/CD pipeline
- **Trivy**: Security scanning
- **kube-score**: Kubernetes object analysis

## 📂 Project Structure

```
.
├── .github/workflows/     # GitHub Actions workflows
├── argocd/                # ArgoCD application definitions
│   └── apps/
│       ├── production.yaml
│       └── staging.yaml
├── base/                  # Base Kubernetes manifests
│   ├── deployment.yaml    # Main Rollout configuration
│   ├── kustomization.yaml
│   └── service.yaml
├── monitoring/            # Monitoring configurations
│   ├── grafana-dashboard.json
│   └── analysis-template.yaml
├── overlays/              # Environment-specific configurations
│   ├── dev/
│   ├── staging/
│   └── prod/
├── .kube-score-exclude.yaml
└── README.md
```

## 🔑 Prerequisites

- A Kubernetes cluster with ArgoCD installed
- DockerHub account (or another container registry)
- GitHub repository with the code

## 🔧 Setup

### 1. Repository Secrets

Add these secrets to your GitHub repository (Settings > Secrets > Actions):

1. `DOCKERHUB_USERNAME`: Your DockerHub username
2. `DOCKERHUB_TOKEN`: DockerHub access token with write permissions
3. `KUBE_CONFIG`: Your Kubernetes configuration (base64 encoded)
4. `SLACK_WEBHOOK_URL` (optional): For Slack notifications

### 2. Update Configuration

1. In `.github/workflows/ci-cd.yml`, update the `IMAGE_NAME` with your DockerHub username:
   ```yaml
   IMAGE_NAME: docker.io/your-dockerhub-username/capstone-app
   ```

2. Update the Dockerfile if your application has specific requirements.

## 🚀 Getting Started

### Prerequisites

- Kubernetes cluster (v1.20+)
- kubectl
- ArgoCD CLI
- Argo Rollouts CLI
- kustomize

### Installation

1. **Install ArgoCD**
   ```bash
   kubectl create namespace argocd
   kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
   ```

2. **Install Argo Rollouts**
   ```bash
   kubectl create namespace argo-rollouts
   kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml
   ```

3. **Install Prometheus and Grafana**
   ```bash
   kubectl create namespace monitoring
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
   helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring
   ```

### Deploying Applications

1. **Bootstrap ArgoCD**
   ```bash
   kubectl apply -f argocd/apps/staging.yaml
   kubectl apply -f argocd/apps/production.yaml
   ```

2. **Access ArgoCD UI**
   ```bash
   kubectl port-forward svc/argocd-server -n argocd 8080:80
   ```
   Open http://localhost:8080 and login with admin/initial-password

## 🔄 Deployment Flow

1. **Development**
   - Code changes pushed to feature branch
   - Pull request created
   - Automated tests and security scans run
   - Code review and approval

2. **Staging**
   - Merged to main branch
   - ArgoCD syncs changes to staging
   - Canary deployment starts automatically
   - Automated tests run against staging

3. **Production**
   - Manual approval required
   - Canary deployment with analysis
   - Automated rollback on failure
   - Monitoring and observability

## 🌐 Live Application

Currently, the application runs inside Minikube / Kubernetes local cluster.

To access it locally:
```bash
kubectl port-forward svc/capstone-rollout -n capstone 8080:80
```

Then open in your browser: http://localhost:8080

GitHub Repository for app source code: [capstone-app](https://github.com/yourusername/capstone-app)

## 🔒 Security

- **Container Scanning**: Trivy scans container images for vulnerabilities
- **Manifest Validation**: kube-score validates Kubernetes manifests
- **Network Policies**: Restrict pod-to-pod communication
- **RBAC**: Least privilege service accounts

## 📊 Monitoring

Access Grafana dashboard:
```bash
kubectl port-forward -n monitoring svc/prometheus-grafana 3000:80
```

Access Argo Rollouts dashboard:
```bash
kubectl argo rollouts dashboard
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Argo Project](https://argoproj.github.io/)
- [Kubernetes](https://kubernetes.io/)
- [Prometheus](https://prometheus.io/)
- [Grafana](https://grafana.com/)