terraform {
  backend "local" {}
}

locals {
    manifests = split("---", file("${path.module}/../kubernetes/app.yaml"))
    ready_manifests = [for manifest in local.manifests : yamldecode(manifest)]
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_manifest" "namespace" {
  manifest = yamldecode(file("${path.module}/../kubernetes/namespace.yaml"))
}

resource "kubernetes_manifest" "app" {
  count = length(local.ready_manifests)
  manifest = local.ready_manifests[count.index]
  depends_on = [ kubernetes_manifest.namespace ]
}
