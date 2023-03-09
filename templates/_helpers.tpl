{{- define "superset.rootpath" }}
# Generates an unique URL per deployment
{{- $hash := printf "%s:%s:%s" .Release.Name .Release.Namespace "J4aMz" | sha256sum -}}
{{- printf "/%s/superset/%s/" .Release.Namespace $hash -}}
{{ end -}}

{{/* Print the name for the Guacamole connection. */}}
{{- define "superset.connectionName" -}}
{{- now | date "2006-01-02-15-04-05" }}--{{ .Release.Name }}-superset
{{- end }}
