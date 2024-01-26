provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "mariadb" {
  name       = "mariadb-galera"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "galera"
  version    = "1.3.8"

  set {
    name  = "rootUser.password"
    value = "quick123" # ROOT DB User PASS (In non-testing environment we have to use secrets here, for security reasons)
  }

  set {
    name  = "galera.mariadbUser.password"
    value = "suite123" # Maria DB User PASS (In non-testing environment we have to use secrets here, for security reasons)
  }

  set {
    name  = "galera.mariadbDatabase"
    value = "quicksuitedb" # DB Name
  }

  set {
    name  = "cluster.size"
    value = "3"
  }

  set {
    name  = "mariadb.architecture"
    value = "replication"
  }

  set {
    name  = "mariadb.master.persistence.enabled"
    value = "true"
  }

  set {
    name  = "mariadb.master.persistence.size"
    value = "1Gi" # Set size of the database
  }
}
