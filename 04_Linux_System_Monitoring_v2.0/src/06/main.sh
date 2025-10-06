#!/bin/bash

source config.sh

# Проверки
if ! command -v goaccess &> /dev/null; then
    echo "ERROR: GoAccess is not installed."
    echo "Install it with:"
    echo "  Ubuntu/Debian: sudo apt install goaccess"
    echo "  CentOS/RHEL:   sudo yum install goaccess"
    echo "  MacOS:         brew install goaccess"
    exit 1
fi

if [ -z "$(ls $LOG_FILES 2>/dev/null)" ]; then
    echo "ERROR: No log files found matching: $LOG_FILES"
    exit 1
fi

# Создание HTML отчета
echo "Generating report from: $(ls $LOG_FILES)"
goaccess $LOG_FILES \
    --log-format=COMBINED \
    --output="$REPORT_FILE"

if [ ! -f "$REPORT_FILE" ]; then
    echo "ERROR: Failed to generate report"
    exit 1
fi

# Открытие в браузере отчета HTML
echo "Report generated: $REPORT_FILE"
echo "Opening in default browser..."

if command -v xdg-open &> /dev/null; then
    xdg-open "$REPORT_FILE" &
elif command -v open &> /dev/null; then
    open "$REPORT_FILE" &
else
    echo "Please open manually: file://$(pwd)/$REPORT_FILE"
fi