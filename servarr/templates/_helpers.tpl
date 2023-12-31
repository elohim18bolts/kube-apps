{{/*
Expand the name of the chart.
*/}}
{{- define "servarr.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Define namespce
*/}}
{{- define "servarr.namespace" -}}
{{- if hasKey .Values "forceNamespace" -}}
{{ printf "namespace: %s" .Values.forceNamespace }}
{{- else -}}
{{ printf "namespace: %s" .Release.Namespace }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "servarr.fullname" -}}
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
{{- define "servarr.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "servarr.labels" -}}
helm.sh/chart: {{ include "servarr.chart" . }}
{{ include "servarr.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "servarr.selectorLabels" -}}
app.kubernetes.io/name: {{ include "servarr.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Radarr FullName definition
*/}}
{{- define "servarr.radarr.fullname" -}}
{{- if .Values.radarr.fullnameOverride }}
{{- .Values.radarr.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- printf "%s-%s" .Release.Name .Values.radarr.name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s-%s" .Release.Name $name .Values.radarr.name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "servarr.radarr.labels" -}}
{{ include "servarr.labels" . }}
{{ include "servarr.radarr.matchLabels" . }}
{{- end }}

{{- define "servarr.radarr.matchLabels" -}}
app: {{ .Values.radarr.name | quote }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "servarr.radarr.serviceAccountName" -}}
{{- if .Values.radarr.serviceAccount.create }}
{{- default (include "servarr.radarr.fullname" .) .Values.radarr.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccounts.radarr.name }}
{{- end }}
{{- end }}

{{/*
Create service name for radarr
*/}}
{{- define "servarr.radarr.serviceName" -}}
{{- default (include "servarr.radarr.fullname" .) .Values.radarr.service.name }}
{{- end }}



{{/*
Sonarr Configuration
*/}}

{{- define "servarr.sonarr.fullname" -}}
{{- if .Values.sonarr.fullnameOverride }}
{{- .Values.radarr.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- printf "%s-%s" .Release.Name .Values.sonarr.name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s-%s" .Release.Name $name .Values.sonarr.name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "servarr.sonarr.labels" -}}
{{ include "servarr.labels" . }}
{{ include "servarr.sonarr.matchLabels" . }}
{{- end }}

{{- define "servarr.sonarr.matchLabels" -}}
app: {{ .Values.sonarr.name | quote }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "servarr.sonarr.serviceAccountName" -}}
{{- if .Values.sonarr.serviceAccount.create }}
{{- default (include "servarr.sonarr.fullname" .) .Values.sonarr.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccounts.sonarr.name }}
{{- end }}
{{- end }}


{{/*
Create service name for sonarr
*/}}
{{- define "servarr.sonarr.serviceName" -}}
{{- default (include "servarr.sonarr.fullname" .) .Values.sonarr.service.name }}
{{- end }}

{{/*
Prowlarr Configuration
*/}}

{{- define "servarr.prowlarr.fullname" -}}
{{- if .Values.prowlarr.fullnameOverride }}
{{- .Values.radarr.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- printf "%s-%s" .Release.Name .Values.prowlarr.name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s-%s" .Release.Name $name .Values.prowlarr.name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "servarr.prowlarr.labels" -}}
{{ include "servarr.labels" . }}
{{ include "servarr.prowlarr.matchLabels" . }}
{{- end }}

{{- define "servarr.prowlarr.matchLabels" -}}
app: {{ .Values.prowlarr.name | quote }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "servarr.prowlarr.serviceAccountName" -}}
{{- if .Values.prowlarr.serviceAccount.create }}
{{- default (include "servarr.prowlarr.fullname" .) .Values.prowlarr.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccounts.prowlarr.name }}
{{- end }}
{{- end }}


{{/*
Create service name for prowlarr
*/}}
{{- define "servarr.prowlarr.serviceName" -}}
{{- default (include "servarr.prowlarr.fullname" .) .Values.prowlarr.service.name }}
{{- end }}
