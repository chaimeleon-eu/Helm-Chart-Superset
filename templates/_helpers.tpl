{{- define "superset.rootpath" }}
# Generates an unique URL per deployment
{{- $hash := printf "%s:%s:%s" .Release.Name .Release.Namespace "J4aMz" | sha256sum -}}
{{- printf "/%s/superset/%s/" .Release.Namespace $hash -}}
{{ end -}}