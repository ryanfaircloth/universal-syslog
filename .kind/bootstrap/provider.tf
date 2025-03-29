provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "kind-us"
}


provider "kubectl" {
  config_path    = "~/.kube/config"
  config_context = "kind-us"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "kind-us"
  }
}
