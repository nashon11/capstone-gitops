# Capstone GitOps Project

This project demonstrates a GitOps workflow using ArgoCD, Kustomize, and Argo Rollouts for multi-environment deployments with canary releases and automated rollbacks.

## 🚀 Features

- **GitOps Workflow**: Declarative infrastructure and application management
- **Multi-Environment Support**: Separate configurations for dev, staging, and production
- **Canary Deployments**: Progressive delivery with Argo Rollouts
- **Automated Rollbacks**: Based on Prometheus metrics and analysis
- **Security Scanning**: GitHub Actions workflow with Trivy and kube-score
- **Monitoring**: Prometheus and Grafana integration

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