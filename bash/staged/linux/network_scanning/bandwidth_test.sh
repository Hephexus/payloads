#!/bin/bash
# bandwidth_test.sh - Test network bandwidth to an iperf server.
if [ -z "$1" ]; then
    echo "Usage: $0 <iperf_server>"
    exit 1
fi
echo "Testing network bandwidth to iperf server $1..."
iperf -c "$1"
