# Custom OpenTelemetry Collector Distribution

## Install Go

Follow these instructions  -> [Download and Install Go][go-install-doc]

## Install [OpenTelemetry Collector Builder][otelcol-builder-gh]

```bash
go install go.opentelemetry.io/collector/cmd/builder@latest

echo 'alias ocb="$HOME/go/bin/builder"' >> ~/.zshrc
```

## Your first OpenTelemetry distribution
###  Distribution Manifest

```yaml
# ocb-config.yml

dist:
  module: github.com/open-telemetry/opentelemetry-collector # the module name for the new distribution
  name: otelcol-custom # the binary name
  description: Custom OpenTelemetry Collector distribution
  output_path: ./build # the path to write the output (sources and binary)
  version: 1.0.0 # the version for your custom OpenTelemetry Collector

exporters:
  - gomod: go.opentelemetry.io/collector/exporter/debugexporter v0.95.0
  - gomod: go.opentelemetry.io/collector/exporter/loggingexporter v0.95.0
  - gomod: go.opentelemetry.io/collector/exporter/otlpexporter v0.95.0

processors:
  - gomod: go.opentelemetry.io/collector/processor/batchprocessor v0.95.0

receivers:
  - gomod: go.opentelemetry.io/collector/receiver/otlpreceiver v0.95.0
  - gomod: github.com/open-telemetry/opentelemetry-collector-contrib/receiver/filelogreceiver v0.95.0
```

### Build your distribution

```bash
ocb --config ocb-config.yml
```

### Test your distribution

```bash
cd test

../build/otelcol-custom --config otelcol-config.yml


## In new Terminal
echo '127.0.0.1 - - [03/Mar/2024:12:34:56 +0000] "GET /page.html" 200 1234' >> app.log
```

### Dockerize

```bash
docker build --push -t nzuguem/otelcol-custom:1.0.0 .
```

<!-- Links -->
[go-install-doc]:https://go.dev/doc/install
[otelcol-builder-gh]:https://github.com/open-telemetry/opentelemetry-collector/tree/main/cmd/builder