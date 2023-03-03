{{/* vim: set filetype=mustache: */}}

{{/*
Chaimeleon annotations
*/}}
{{- define "chaimeleon.annotations" -}}
{{- if .Values.datasets_list }}
chaimeleon.eu/datasetsIDs: "{{ .Values.datasets_list }}"
{{- end }}
chaimeleon.eu/toolName: "{{ .Chart.Name }}"
chaimeleon.eu/toolVersion: "{{ .Chart.Version }}"
{{- end }}

{{/*
Obtain chaimeleon common variables
*/}}
{{- define "chaimeleon.ceph.user" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- if $configmap }}
{{- index $configmap "data" "ceph.user" | default (printf "%s-%s" "chaimeleon-user" .Release.Namespace) -}}
{{- end }}
{{- end }}

{{- define "chaimeleon.ceph.gid" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- if $configmap }}
{{- index $configmap "data" "ceph.gid"  | int | default 1000 -}}
{{- end }}
{{- end }}

{{- define "chaimeleon.ceph.monitor" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- if $configmap }}
{{- index $configmap "data" "ceph.monitor" -}}
{{- end }}
{{- end }}

{{- define "chaimeleon.datasets.path" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- index $configmap "data" "datasets.path" -}}
{{- end }}

{{- define "chaimeleon.datasets.mount_point" -}}
/home/chaimeleon/datasets
{{- end }}

{{- define "chaimeleon.datalake.path" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- if $configmap }}
{{- index $configmap "data" "datalake.path" -}}
{{- end }}
{{- end }}

{{- define "chaimeleon.datalake.mount_point" -}}
/mnt/datalake
{{- end }}

{{- define "chaimeleon.persistent_home.path" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- if $configmap }}
{{- index $configmap "data" "persistent_home.path" -}}
{{- end }}
{{- end }}

{{- define "chaimeleon.persistent_home.mount_point" -}}
/home/chaimeleon/persistent-home
{{- end }}

{{- define "chaimeleon.persistent_shared_folder.path" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- if $configmap }}
{{- index $configmap "data" "persistent_shared_folder.path" -}}
{{- end }}
{{- end }}

{{- define "chaimeleon.persistent_shared_folder.mount_point" -}}
/home/chaimeleon/persistent-shared-folder
{{- end }}



{{- define "chaimeleon.user.name" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- index $configmap "data" "user.name" -}}
{{- end }}

{{- define "chaimeleon.user.uid" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- if $configmap }}
{{- index $configmap "data" "user.uid" | int -}}
{{- end }}
{{- end }}

{{- define "chaimeleon.group.name" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- index $configmap "data" "group.name" -}}
{{- end }}

{{- define "chaimeleon.group.gid" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- if $configmap }}
{{- index $configmap "data" "group.gid" | int -}}
{{- end }}
{{- end }}

{{/* Obtain the Chaimeleon image library url. */}}
{{- define "chaimeleon.library-url" -}}
harbor.chaimeleon-eu.i3m.upv.es/chaimeleon-library
{{- end -}}

{{/* Generate ingress annotations to secure a web application (only authenticated user will be able to access). */}}
{{- define "chaimeleon.ingress-auth-annotations" -}}
nginx.ingress.kubernetes.io/auth-url: "https://chaimeleon-eu.i3m.upv.es/oauth2p/auth"
nginx.ingress.kubernetes.io/auth-signin: "https://chaimeleon-eu.i3m.upv.es/oauth2p/start"
nginx.ingress.kubernetes.io/proxy-buffer-size: '16k'
{{- end }}