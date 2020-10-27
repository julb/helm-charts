{{/*
Expand the name of the chart.
*/}}
{{- define "git-configmap-sync.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "git-configmap-sync.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "git-configmap-sync.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "git-configmap-sync.labels" -}}
helm.sh/chart: {{ include "git-configmap-sync.chart" . }}
{{ include "git-configmap-sync.selectorLabels" . }}
{{- if .Values.extraLabels }}
{{ toYaml .Values.extraLabels }}
{{- end }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "git-configmap-sync.selectorLabels" -}}
app.kubernetes.io/name: {{ include "git-configmap-sync.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "git-configmap-sync.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "git-configmap-sync.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Git clone secret holding git credentials to clone the repository.
*/}}
{{- define "git-configmap-sync.gitCloneSecretName" -}}
    {{- if .Values.gitClone.gitConfig.credentials.existingSecret -}}
        {{- printf "%s" .Values.gitClone.gitConfig.credentials.existingSecret -}}
    {{- else -}}
        {{- printf "%s" (include "git-configmap-sync.fullname" .) -}}
    {{- end -}}
{{- end -}}