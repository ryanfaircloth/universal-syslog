
data "kubectl_path_documents" "namespaces" {
  pattern = "./manifests/namespaces/*.yaml"
}

resource "kubectl_manifest" "namespaces" {
  for_each  = data.kubectl_path_documents.namespaces.manifests
  yaml_body = each.value
}
