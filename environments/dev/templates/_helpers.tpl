{{- define "argocdapp.projectName" -}}
{{ .Values.argocdapp.spec.project | default "default-dev" }}
{{- end -}}
{{- define "argocdapp.applicationName" -}}
{{ .Values.argocdapp.spec.name | default "gen3-app" }}
{{- end -}}
{{- define "argocdapp.sourceNamespaces" -}}
{{ .Values.argocdapp.sourceNamespaces | default (list "argocd" "gen3") }}
{{- end -}}
{{- define "argocdapp.argoNamespace" -}}
{{ .Values.argocdapp.argoNamespace | default "argocd" }}
{{- end -}}
{{- define "argocdapp.destinationServer" -}}
{{ .Values.argocdapp.spec.destination.server | default "https://kubernetes.default.svc" }}
{{- end -}}

---
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: {{ include "argocdapp.projectName" . }}
  namespace: argocd
  # Finalizer that ensures that project is not deleted until it is not referenced by any application
  finalizers:
    - resources-finalizer.argocd.argoproj.io
  annotations:
    argocd.argoproj.io/sync-wave: "1"
spec:
  sourceRepos:
    - '*'
  destinations:
    - namespace: "*"
      server: https://kubernetes.default.svc
      name: in-cluster
  clusterResourceWhitelist:
    - group: '*'
      kind: '*'
  namespaceResourceWhitelist:
    - group: '*'
      kind: '*'
  sourceNamespaces:
    {{- toYaml (include "argocdapp.sourceNamespaces" .) | nindent 4 }}
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: {{ include "argocdapp.applicationName" . }}
  namespace: {{ include "argocdapp.argoNamespace" . }}
  labels:
    {{- toYaml .Values.argocdapp.labels | nindent 4 }}
  finalizers:
    - resources-finalizer.argocd.argoproj.io
  annotations:
    argocd.argoproj.io/sync-wave: "2"
spec:
  project: {{ include "argocdapp.projectName" . }}
  destination:
    namespace: {{ .Values.argocdapp.spec.namespace | default "dev" }}
    server: {{ include "argocdapp.destinationServer" . }}
  sources:
      {{- toYaml .Values.argocdapp.spec.sources | nindent 4 }}
  syncPolicy:
    automated:
      prune: true
    syncOptions:
      - CreateNamespace=true
