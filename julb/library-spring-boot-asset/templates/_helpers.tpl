{{/*
Expand the name of the chart.
*/}}
{{- define "library-spring-boot-asset.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "library-spring-boot-asset.fullname" -}}
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
{{- define "library-spring-boot-asset.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "library-spring-boot-asset.labels" -}}
helm.sh/chart: {{ include "library-spring-boot-asset.chart" . }}
{{ include "library-spring-boot-asset.selectorLabels" . }}
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
{{- define "library-spring-boot-asset.selectorLabels" -}}
app.kubernetes.io/name: {{ include "library-spring-boot-asset.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "library-spring-boot-asset.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "library-spring-boot-asset.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Specifies the Java Options
*/}}
{{- define "library-spring-boot-asset.javaOpts" -}}
-Dfile.encoding=UTF-8 -Djava.security.egd=file:/dev/./urandom -Dserver.port=8080
{{ if .Values.extraJavaOpts }}{{ .Values.extraJavaOpts }}{{ end }}
{{- end }}