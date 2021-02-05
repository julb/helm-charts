# docker-certs-ca-installer

## TL;DR

```bash
$ helm repo add julb https://charts.julb.me
$ helm install my-release julb/docker-certs-ca-installer
```

## Introduction

This chart runs a DaemonSet enabling to install a custom CA certificates in the `/etc/docker/certs.d` of each worker nodes of a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release julb/docker-certs-ca-installer
```

The command deploys docker-certs-ca-installer on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

The following table lists the configurable parameters of the docker-certs-ca-installer chart and their default values.

### Common parameters

| Parameter          | Description                                                     | Default |
| ------------------ | --------------------------------------------------------------- | ------- |
| `nameOverride`     | String to partially override docker-certs-ca-installer.fullname | `nil`   |
| `fullnameOverride` | String to fully override docker-certs-ca-installer.fullname     | `nil`   |

### docker-certs-ca-installer parameters

| Parameter          | Description                                      | Default                                                 |
| ------------------ | ------------------------------------------------ | ------------------------------------------------------- |
| `image.repository` | docker-certs-ca-installer image name             | `busybox`                                               |
| `image.tag`        | docker-certs-ca-installer image tag              | `latest`                                                |
| `image.pullPolicy` | docker-certs-ca-installer image pull policy      | `IfNotPresent`                                          |
| `imagePullSecrets` | Specify docker-registry secret names as an array | `[]` (does not add image pull secrets to deployed pods) |

### DaemonSet parameters

| Parameter            | Description                                                 | Default                        |
| -------------------- | ----------------------------------------------------------- | ------------------------------ |
| `podAnnotations`     | docker-certs-ca-installer Pod annotations                   | `{}` (evaluated as a template) |
| `affinity`           | Affinity for pod assignment                                 | `{}` (evaluated as a template) |
| `nodeSelector`       | Node labels for pod assignment                              | `{}` (evaluated as a template) |
| `tolerations`        | Tolerations for pod assignment                              | `[]` (evaluated as a template) |
| `podSecurityContext` | docker-certs-ca-installer pods' Security Context            | `{}`                           |
| `securityContext`    | docker-certs-ca-installer containers' Security Context      | `{}`                           |
| `resources`          | The requested resources and resources limits for containers | `{}`                           |
| `extraLabels`        | Additional labels to apply on all objects                   | `{}`                           |

### RBAC parameters

| Parameter                    | Description                                | Default                                       |
| ---------------------------- | ------------------------------------------ | --------------------------------------------- |
| `serviceAccount.create`      | Enable creation of ServiceAccount          | `true`                                        |
| `serviceAccount.name`        | Name of the created serviceAccount         | `docker-certs-ca-installer.fullname` template |
| `serviceAccount.annotations` | Annotations to add on the service account. | `{}`                                          |

### PSP parameters

| Parameter         | Description                    | Default |
| ----------------- | ------------------------------ | ------- |
| `psp.create`      | Enable creation of the PSP     | `true`  |
| `psp.annotations` | Annotations to add on the PSP. | `{}`    |

### DockerCertsCaInstaller parameters

| Parameter                                    | Description                                 | Default |
| -------------------------------------------- | ------------------------------------------- | ------- |
| `dockerCertsCaInstaller.caConfigs[].hosts[]` | FQDN of Docker registries.                  | `[]`    |
| `dockerCertsCaInstaller.caConfigs[].x509Crt` | X509 PEM certificates of the CA to install. | ``      |

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install my-release -f values.yaml julb/docker-certs-ca-installer
```

> **Tip**: You can use the default [values.yaml](values.yaml)
