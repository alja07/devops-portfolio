#!/bin/bash

OUTPUT_DIR="/var/www/metrics"
mkdir -p "$OUTPUT_DIR"

HTML_FILE="$OUTPUT_DIR/metrics.html"
PROMETHEUS_FILE="$OUTPUT_DIR/metrics"
API_FILE="$OUTPUT_DIR/api.json"

MAX_HISTORY=120
CPU_HISTORY=()
RAM_HISTORY=()
DISK_HISTORY=()
TIMESTAMPS=()

while true; do
  source metrics-collect.sh
  source html-generator.sh
done