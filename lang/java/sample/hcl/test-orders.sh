#!/usr/bin/env bash
set -euo pipefail

export AWS_ACCESS_KEY_ID=ldk-local
export AWS_SECRET_ACCESS_KEY=ldk-local
export AWS_DEFAULT_REGION=us-east-1

BASE_PORT=3000
SFN_PORT=$((BASE_PORT + 6))
SSM_PORT=$((BASE_PORT + 12))
SM_PORT=$((BASE_PORT + 13))

echo "=== Checking Step Functions State Machine ==="
SFN_ARN=$(aws --endpoint-url "http://localhost:${SFN_PORT}" stepfunctions list-state-machines \
  --query "stateMachines[?name=='OrderWorkflow'].stateMachineArn" \
  --output text)
echo "OrderWorkflow ARN: $SFN_ARN"
if [ -z "$SFN_ARN" ]; then
  echo "ERROR: OrderWorkflow state machine not found"
  exit 1
fi

echo ""
echo "=== Checking SSM Parameter ==="
aws --endpoint-url "http://localhost:${SSM_PORT}" ssm get-parameter --name /orders/config/max-items

echo ""
echo "=== Checking Secret ==="
aws --endpoint-url "http://localhost:${SM_PORT}" secretsmanager get-secret-value --secret-id orders/notification-api-key
