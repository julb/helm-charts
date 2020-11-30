# git-configmap-sync

[kubernetes-configmap-sync](https://github.com/julb/kubernetes-configmap-sync) is a Python job that creates configmaps from a source directory.

## TL;DR

```bash
$ helm repo add julb https://charts.julb.me
$ helm install my-release julb/git-configmap-sync
```

## Introduction

This chart bootstraps a [kubernetes-configmap-sync](https://github.com/julb/kubernetes-configmap-sync) job on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release julb/git-configmap-sync
```

The command deploys git-configmap-sync on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

The following table lists the configurable parameters of the git-configmap-sync chart and their default values.

### Common parameters

| Parameter          | Description                                              | Default |
| ------------------ | -------------------------------------------------------- | ------- |
| `nameOverride`     | String to partially override git-configmap-sync.fullname | `nil`   |
| `fullnameOverride` | String to fully override git-configmap-sync.fullname     | `nil`   |

### git-configmap-sync parameters

| Parameter          | Description                                      | Default                                                 |
| ------------------ | ------------------------------------------------ | ------------------------------------------------------- |
| `image.repository` | git-configmap-sync image name                    | `julb/kubernetes-configmap-sync`                               |
| `image.tag`        | git-configmap-sync image tag                     | `{TAG_NAME}`                                            |
| `image.pullPolicy` | git-configmap-sync image pull policy             | `IfNotPresent`                                          |
| `imagePullSecrets` | Specify docker-registry secret names as an array | `[]` (does not add image pull secrets to deployed pods) |

### CronJob parameters

| Parameter            | Description                                                                    | Default                        |
| -------------------- | ------------------------------------------------------------------------------ | ------------------------------ |
| `concurrencyPolicy`  | Concurrency policy on the CronJob                                              | `Forbid`                       |
| `failedJobsHistoryLimit`  | The maximum number of failed jobs to keep in history.                     | `3`                            |
| `schedule`           | The Cron schedule at which to run the job.                                     | `*/5 * * * *`                  |
| `backoffLimit`       | The maximum number of re-tries before aborting the job execution.              | `0`                            |
| `podAnnotations`     | Pod annotations                                                                | `{}` (evaluated as a template) |
| `affinity`           | Affinity for pod assignment                                                    | `{}` (evaluated as a template) |
| `nodeSelector`       | Node labels for pod assignment                                                 | `{}` (evaluated as a template) |
| `tolerations`        | Tolerations for pod assignment                                                 | `[]` (evaluated as a template) |
| `podSecurityContext` | git-configmap-sync pods' Security Context                                      | `{}`                           |
| `securityContext`    | git-configmap-sync containers' Security Context                                | `{}`                           |
| `resources`          | The requested resources and resources limits for git-configmap-sync containers | `{}`                           |
| `extraLabels`        | Additional labels to apply on all objects                                      | `{}`                           |

### RBAC parameters

| Parameter                    | Description                                                   | Default                                                    |
| ---------------------------- | ------------------------------------------------------------- | ---------------------------------------------------------- |
| `serviceAccount.create`      | Enable creation of ServiceAccount                             | `true`                                                     |
| `serviceAccount.name`        | Name of the created serviceAccount                            | Generated using the `git-configmap-sync.fullname` template |
| `serviceAccount.annotations` | Annotations to add on the service account.                    | `{}`                                                       |


### GitClone parameters

| Parameter          | Description                                      | Default                                                 |
| ------------------ | ------------------------------------------------ | ------------------------------------------------------- |
| `gitClone.image.repository` | Git clone image name                    | `alpine/git`                                            |
| `gitClone.image.tag`        | Git clone image tag                     | `latest`                                                |
| `gitClone.image.pullPolicy` | Git clone image pull policy             | `IfNotPresent`                                          |
| `gitClone.resources`        | Git clone requested resources and resources limits | `{}`                                         |
| `gitClone.securityContext`  | Git clone container security context    | `{}`                                                    |
| `gitClone.gitConfig.repository`  | Git repository to clone            | ` `                                                     |
| `gitClone.gitConfig.branch`      | Git branch to clone                | ` `                                                     |
| `gitClone.gitConfig.subdirectory`| Git subdirectory to process        | ` `                                                     |
| `gitClone.gitConfig.credentials.username`| Username to use to clone the repository        | ` `                                 |
| `gitClone.gitConfig.credentials.password`| Password to use to clone the repository        | ` `                                 |
| `gitClone.gitConfig.credentials.privateSshKey`| Private SSH key to use to clone the repository        | ` `                     |
| `gitClone.gitConfig.credentials.existingSecret`| Existing secret holding git credentials used to clone the repository        | ` `                     |

The above parameters map to the env variables defined in [julb/kubernetes-configmap-sync](http://github.com/julb/kubernetes-configmap-sync). For more information please refer to the [julb/kubernetes-configmap-sync](http://github.com/julb/kubernetes-configmap-sync) image documentation.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install my-release -f values.yaml julb/git-configmap-sync
```

> **Tip**: You can use the default [values.yaml](values.yaml)
