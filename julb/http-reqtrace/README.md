# http-reqtrace

[http-reqtrace](https://gitlab.com/julb/http-reqtrace) is a simple WebServer which logs details of incoming HTTP requests.

## TL;DR

```bash
$ helm repo add julb https://charts.julb.me
$ helm install my-release julb/http-reqtrace
```

## Introduction

This chart bootstraps a [http-reqtrace](https://gitlab.com/julb/http-reqtrace) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release julb/http-reqtrace
```

The command deploys http-reqtrace on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

The following table lists the configurable parameters of the http-reqtrace chart and their default values.

### Common parameters

| Parameter                                 | Description                                                                                                          | Default                                                      |
|-------------------------------------------|----------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------|
| `nameOverride`                            | String to partially override http-reqtrace.fullname                                                                       | `nil`                                                        |
| `fullnameOverride`                        | String to fully override http-reqtrace.fullname                                                                           | `nil`                                                        |

### http-reqtrace parameters

| Parameter                                 | Description                                                                                                          | Default                                                      |
|-------------------------------------------|----------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------|
| `image.repository`                        | http-reqtrace image name                                                                                                  | `julb/http-reqtrace`                                           |
| `image.tag`                               | http-reqtrace image tag                                                                                                   | `{TAG_NAME}`                                                 |
| `image.pullPolicy`                        | http-reqtrace image pull policy                                                                                           | `IfNotPresent`                                               |
| `imagePullSecrets`                       | Specify docker-registry secret names as an array                                                                     | `[]` (does not add image pull secrets to deployed pods)      |

### Deployment parameters

| Parameter                                 | Description                                                                                                          | Default                                                      |
|-------------------------------------------|----------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------|
| `replicaCount`                            | Number of http-reqtrace nodes                                                                                             | `1`                                                          |
| `podAnnotations`                          | http-reqtrace Pod annotations                                                                                             | `{}` (evaluated as a template)                               |
| `affinity`                                | Affinity for pod assignment                                                                                          | `{}` (evaluated as a template)                               |
| `nodeSelector`                            | Node labels for pod assignment                                                                                       | `{}` (evaluated as a template)                               |
| `tolerations`                             | Tolerations for pod assignment                                                                                       | `[]` (evaluated as a template)                               |
| `podSecurityContext`                      | http-reqtrace pods' Security Context                                                                                      | `{}`                                                         |
| `securityContext`                | http-reqtrace containers' Security Context                                                                                | `{}`                                                         |
| `resources`                        | The requested resources and resources limits for http-reqtrace containers                                                                         | `{}`                                                         |
| `extraLabels`        | Additional labels to apply on all objects                                      | `{}`                           |

### Exposure parameters

| Parameter                                 | Description                                                                                                          | Default                                                      |
|-------------------------------------------|----------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------|
| `service.type`                            | Kubernetes Service type                                                                                              | `ClusterIP`                                                  |
| `service.port`                            | HTTP port                                                                                                            | `80`                                                       |
| `ingress.enabled`                         | Enable ingress resource for the deployment                                                                       | `false`                                                      |
| `ingress.annotations`                     | Ingress annotations                                                                                                  | `{}`                                                         |
| `ingress.hostname`                        | Default host for the ingress resource                                                                                | `http-reqtrace.local`                                             |
| `ingress.tls`                             | Enable TLS configuration for the hostname defined at `ingress.hostname` parameter                                    | `false`                                                      |
| `ingress.existingSecret`                  | Existing secret for the Ingress TLS certificate                                                                      | `nil`                                                        |
| `ingress.hosts[0].host`              | Additional hostnames to be covered                                                                                   | `nil`                                                        |
| `ingress.hosts[0].paths[0]`              | Additional paths to be covered                                                                                   | `nil`                                                        |
| `ingress.tls[0].hosts[0]`            | TLS configuration for additional hostnames to be covered                                                             | `nil`                                                        |
| `ingress.tls[0].secretName`          | TLS configuration for additional hostnames to be covered                                                             | `nil`                                                        |

### RBAC parameters

| Parameter                                 | Description                                                                                                          | Default                                                      |
|-------------------------------------------|----------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------|
| `serviceAccount.create`                   | Enable creation of ServiceAccount for http-reqtrace pods                                                                  | `true`                                                       |
| `serviceAccount.name`                     | Name of the created serviceAccount                                                                                   | Generated using the `http-reqtrace.fullname` template             |
| `serviceAccount.annotations`                             | Annotations to add on the service account.                                                                        | `{}`                                                      |


The above parameters map to the env variables defined in [julb/http-reqtrace](http://gitlab.com/julb/http-reqtrace). For more information please refer to the [julb/http-reqtrace](http://gitlab.com/julb/http-reqtrace) image documentation.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install my-release -f values.yaml julb/http-reqtrace
```

> **Tip**: You can use the default [values.yaml](values.yaml)
