FROM golang:1.22 AS builder
ARG  OTEL_VERSION=0.95.0
WORKDIR /app
RUN go install go.opentelemetry.io/collector/cmd/builder@v$OTEL_VERSION
COPY ocb-config.yml ./
RUN CGO_ENABLED=0 GOOS=linux builder --config=ocb-config.yml
 
FROM gcr.io/distroless/base-debian12
COPY --from=builder /app/build/otelcol-custom /
ENTRYPOINT ["/otelcol-custom"]
CMD [ "--version" ]
