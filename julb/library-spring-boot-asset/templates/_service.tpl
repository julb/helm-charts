{{- define "library-spring-boot-asset.service" -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ include "library-spring-boot-asset.fullname" . }}
  labels:
    {{- include "library-spring-boot-asset.labels" . | nindent 4 }}
spec:
  type: {{ .Values.service.type }}
  ports:
    - port: {{ .Values.service.port }}
      targetPort: http
      protocol: TCP
      name: http
  selector:
    {{- include "library-spring-boot-asset.selectorLabels" . | nindent 4 }}
{{- end }}