# alertmanager-gchat-integration

[alertmanager-gchat-integration](https://github.com/julb/alertmanager-gchat-integration) is a Web application which listens for Prometheus AlertManager alerts' and forward them to Google Chat rooms.

## TL;DR

```bash
$ helm repo add julb https://charts.julb.me
$ helm install my-release julb/alertmanager-gchat-integration
```

## Introduction

This chart bootstraps a [alertmanager-gchat-integration](https://github.com/julb/alertmanager-gchat-integration) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release julb/alertmanager-gchat-integration
```

The command deploys alertmanager-gchat-integration on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Integrate with Prometheus AlertManager configuration

In the [AlertManager receivers configuration](https://prometheus.io/docs/alerting/latest/configuration/), a `webhook_config` instance needs to be configured to push notification to GChat.

See [webhook_config](https://prometheus.io/docs/alerting/latest/configuration/#webhook_config) configuration details in the official AlertManager documentation.

```yaml
route:
  group_by: ["job"]
  group_wait: 30s
  group_interval: 5m
  repeat_interval: 12h
  receiver: default-alert-receiver
  routes:
    - match:
        severity: critical
      receiver: critical-alert-receiver
    - match:
        severity: warning
      receiver: warning-alert-receiver
receivers:
  - name: default-alert-receiver
    webhook_configs:
      - url: http://<alertmanager-gchat-integration.fullname>.<namespace>.svc/alerts?room=<room-name>
  - name: warning-alert-receiver
    webhook_configs:
      - url: http://<alertmanager-gchat-integration.fullname>.<namespace>.svc/alerts?room=<room-name>
  - name: critical-alert-receiver
    webhook_configs:
      - url: http://<alertmanager-gchat-integration.fullname>.<namespace>.svc/alerts?room=<room-name>
```

## Parameters

The following table lists the configurable parameters of the alertmanager-gchat-integration chart and their default values.

### Common parameters

| Parameter          | Description                                                          | Default |
| ------------------ | -------------------------------------------------------------------- | ------- |
| `nameOverride`     | String to partially override alertmanager-gchat-integration.fullname | `nil`   |
| `fullnameOverride` | String to fully override alertmanager-gchat-integration.fullname     | `nil`   |

### alertmanager-gchat-integration parameters

| Parameter          | Description                                      | Default                                                 |
| ------------------ | ------------------------------------------------ | ------------------------------------------------------- |
| `image.repository` | alertmanager-gchat-integration image name        | `julb/alertmanager-gchat-integration`                   |
| `image.tag`        | alertmanager-gchat-integration image tag         | `{TAG_NAME}`                                            |
| `image.pullPolicy` | alertmanager-gchat-integration image pull policy | `IfNotPresent`                                          |
| `imagePullSecrets` | Specify docker-registry secret names as an array | `[]` (does not add image pull secrets to deployed pods) |

### Deployment parameters

| Parameter            | Description                                                                                | Default                        |
| -------------------- | ------------------------------------------------------------------------------------------ | ------------------------------ |
| `replicaCount`       | Number of alertmanager-gchat-integration nodes                                             | `1`                            |
| `podAnnotations`     | alertmanager-gchat-integration Pod annotations                                             | `{}` (evaluated as a template) |
| `affinity`           | Affinity for pod assignment                                                                | `{}` (evaluated as a template) |
| `nodeSelector`       | Node labels for pod assignment                                                             | `{}` (evaluated as a template) |
| `tolerations`        | Tolerations for pod assignment                                                             | `[]` (evaluated as a template) |
| `podSecurityContext` | alertmanager-gchat-integration pods' Security Context                                      | `{}`                           |
| `securityContext`    | alertmanager-gchat-integration containers' Security Context                                | `{}`                           |
| `resources`          | The requested resources and resources limits for alertmanager-gchat-integration containers | `{}`                           |
| `extraLabels`        | Additional labels to apply on all objects                                                  | `{}`                           |

### Exposure parameters

| Parameter                   | Description                                                                       | Default                                |
| --------------------------- | --------------------------------------------------------------------------------- | -------------------------------------- |
| `service.type`              | Kubernetes Service type                                                           | `ClusterIP`                            |
| `service.port`              | HTTP port                                                                         | `80`                                   |
| `ingress.enabled`           | Enable ingress resource for the deployment                                        | `false`                                |
| `ingress.annotations`       | Ingress annotations                                                               | `{}`                                   |
| `ingress.hostname`          | Default host for the ingress resource                                             | `alertmanager-gchat-integration.local` |
| `ingress.tls`               | Enable TLS configuration for the hostname defined at `ingress.hostname` parameter | `false`                                |
| `ingress.existingSecret`    | Existing secret for the Ingress TLS certificate                                   | `nil`                                  |
| `ingress.hosts[0].host`     | Additional hostnames to be covered                                                | `nil`                                  |
| `ingress.hosts[0].paths[0]` | Additional paths to be covered                                                    | `nil`                                  |
| `ingress.tls[0].hosts[0]`   | TLS configuration for additional hostnames to be covered                          | `nil`                                  |
| `ingress.tls[0].secretName` | TLS configuration for additional hostnames to be covered                          | `nil`                                  |

### RBAC parameters

| Parameter                    | Description                                | Default                                                                |
| ---------------------------- | ------------------------------------------ | ---------------------------------------------------------------------- |
| `serviceAccount.create`      | Enable creation of ServiceAccount          | `true`                                                                 |
| `serviceAccount.name`        | Name of the created serviceAccount         | Generated using the `alertmanager-gchat-integration.fullname` template |
| `serviceAccount.annotations` | Annotations to add on the service account. | `{}`                                                                   |

### Metrics parameters

| Parameter                                 | Description                                                                  | Default |
| ----------------------------------------- | ---------------------------------------------------------------------------- | ------- |
| `metrics.enabled`                         | Enable exposing metrics to be gathered by Prometheus                         | `false` |
| `metrics.serviceMonitor.enabled`          | Create ServiceMonitor Resource for scraping metrics using PrometheusOperator | `false` |
| `metrics.serviceMonitor.namespace`        | Namespace which Prometheus is running in                                     | `nil`   |
| `metrics.serviceMonitor.interval`         | Interval at which metrics should be scraped                                  | `30s`   |
| `metrics.serviceMonitor.scrapeTimeout`    | Specify the timeout after which the scrape is ended                          | `nil`   |
| `metrics.serviceMonitor.relabellings`     | Specify Metric Relabellings to add to the scrape endpoint                    | `nil`   |
| `metrics.serviceMonitor.honorLabels`      | honorLabels chooses the metric's labels on collisions with target labels.    | `false` |
| `metrics.serviceMonitor.additionalLabels` | Used to pass Labels that are required by the Installed Prometheus Operator.  | `{}`    |

### AlertManagerGChatIntegration parameters

| Parameter                                                         | Description                                 | Default |
| ----------------------------------------------------------------- | ------------------------------------------- | ------- |
| `alertManagerGChatIntegration.configToml.existingSecret`          | Existing secret holding configuration file. | ` `     |
| `alertManagerGChatIntegration.configToml.origin`                  | Origin to add to the GChat message.         | ` `     |
| `alertManagerGChatIntegration.configToml.rooms[].name`            | Logical name of the GChat room.             | ` `     |
| `alertManagerGChatIntegration.configToml.rooms[].notificationUrl` | Webhook URL of the GChat room.              | ` `     |
| `alertManagerGChatIntegration.notificationTemplateJsonJ2`         | Jinja2 template to render alerts on GChat.  | ` `     |

The above parameters map to the env variables defined in [julb/alertmanager-gchat-integration](http://github.com/julb/alertmanager-gchat-integration). For more information please refer to the [julb/alertmanager-gchat-integration](http://github.com/julb/alertmanager-gchat-integration) image documentation.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install my-release -f values.yaml julb/alertmanager-gchat-integration
```

> **Tip**: You can use the default [values.yaml](values.yaml)
