{{- define "superset.rootpath" }}
# Generates an unique URL per deployment
{{- $hash := printf "%s:%s:%s" .Release.Name .Release.Namespace "J4aMz" | sha256sum -}}
{{- printf "/%s/superset/%s/" .Release.Namespace $hash -}}
{{ end -}}

{{/* Print the name for the Guacamole connection. */}}
{{- define "superset.connectionName" -}}
DATE-TIME---{{ .Release.Name }}-superset
{{- end }}

{{/* Print a random string (useful for generate passwords). */}}
{{- define "utils.randomString" -}}
{{- randAlphaNum 20 -}}
{{- end }}

