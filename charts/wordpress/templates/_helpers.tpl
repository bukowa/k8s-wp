{{- define "wordpress.url" }}http://{{- .Values.web.host -}}{{- end}}
{{- define "metadata.name.configmap.scripts" }}
{{- include "wordpress.fullname" . }}-files
{{- end}}

{{- define "volumes" }}
        {{ range $key, $value := .Values.volumes }}
        {{- $volumes := list }}
        {{- $volume := set $value "name" $key }}
        {{- $volumes = append $volumes $volume }}
          {{- toYaml $volumes | nindent 8 }}
        {{ end }}
{{- end}}

{{- define "volumes.files" }}
        {{- $glob := . }}
        {{- range $key, $value := .Values.files }}
        - name: {{ $key }}
          configMap:
            name: {{ include "metadata.name.configmap.scripts" $glob }}
            defaultMode: {{ default "0444" $value.filemode }}
            items:
              - key: {{ $key }}
                path: {{ $key }}
        {{ end }}
{{- end}}

{{- define "volumeMounts.files" }}
            {{- range $key, $value := .Values.files }}
            {{- $file := . }}
            {{- $volumes := get $file.containers $.Container }}
            {{- if $volumes }}
            {{ range $volumes }}
            {{- $volume := set . "name" $key }}
            {{- $volume = set . "subPath" (default $key .subPath)}}
            {{- $volumes := append list $volume }}
            {{- toYaml $volumes | nindent 12 }}
            {{- end}}
            {{- end}}
            {{- end}}
{{- end }}

{{- define "volumeMounts" }}

            {{- range $volumeName, $volumeContainers := $.Values.volumeMounts }}
            {{- range $container, $volumeSpec := $volumeContainers }}
            {{- if eq $container $.Container }}
            {{- $volume := set $volumeSpec "name" $volumeName }}
            {{- $volumes := append list $volume }}
                {{- tpl (toYaml $volumes ) $.Context | nindent 12}}
            {{- end}}
            {{- end}}
            {{- end}}
{{- end}}
{{/*
Expand the name of the chart.
*/}}
{{- define "wordpress.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "wordpress.fullname" -}}
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
{{- define "wordpress.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "wordpress.labels" -}}
helm.sh/chart: {{ include "wordpress.chart" . }}
{{ include "wordpress.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "wordpress.selectorLabels" -}}
app.kubernetes.io/name: {{ include "wordpress.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "wordpress.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "wordpress.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
