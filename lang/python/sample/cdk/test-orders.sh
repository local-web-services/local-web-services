#!/usr/bin/env bash
set -euo pipefail

export AWS_ACCESS_KEY_ID=ldk-local
export AWS_SECRET_ACCESS_KEY=ldk-local
export AWS_DEFAULT_REGION=us-east-1

BASE_PORT=3000
APIGW_PORT=$BASE_PORT
SFN_PORT=$((BASE_PORT + 6))
SSM_PORT=$((BASE_PORT + 12))
SM_PORT=$((BASE_PORT + 13))

echo "=== Creating order ==="
CREATE_RESPONSE=$(curl -sf -X POST "http://localhost:${APIGW_PORT}/orders" \
  -H "Content-Type: application/json" \
  -d '{"customerName": "Alice", "items": ["widget", "gadget"], "total": 49.99}')

echo "$CREATE_RESPONSE" | python3 -m json.tool

ORDER_ID=$(echo "$CREATE_RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin)['orderId'])")
echo "Order ID: $ORDER_ID"

echo ""
echo "=== Starting OrderWorkflow ==="
SFN_ARN=$(aws --endpoint-url "http://localhost:${SFN_PORT}" stepfunctions list-state-machines \
  --query "stateMachines[?name=='OrderWorkflow'].stateMachineArn" \
  --output text)

SFN_INPUT=$(python3 -c "import json; print(json.dumps({'orderId': '$ORDER_ID', 'items': ['widget', 'gadget'], 'total': 49.99}))")

START_RESPONSE=$(aws --endpoint-url "http://localhost:${SFN_PORT}" stepfunctions start-execution \
  --state-machine-arn "$SFN_ARN" \
  --name "order-$(echo "$ORDER_ID" | tr -d '-')" \
  --input "$SFN_INPUT")

echo "$START_RESPONSE"

EXEC_ARN=$(echo "$START_RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin)['executionArn'])")

echo ""
echo "=== Polling for workflow completion ==="
for i in $(seq 1 15); do
  DESC_RESPONSE=$(aws --endpoint-url "http://localhost:${SFN_PORT}" stepfunctions describe-execution \
    --execution-arn "$EXEC_ARN")

  STATUS=$(echo "$DESC_RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin)['status'])")
  echo "  Attempt $i: $STATUS"

  if [ "$STATUS" = "SUCCEEDED" ]; then
    echo ""
    echo "Workflow output:"
    echo "$DESC_RESPONSE" | python3 -c "import sys,json; d=json.load(sys.stdin); print(json.dumps(json.loads(d.get('output','{}')), indent=2))"
    break
  elif [ "$STATUS" = "FAILED" ] || [ "$STATUS" = "TIMED_OUT" ] || [ "$STATUS" = "ABORTED" ]; then
    echo "Workflow failed:"
    echo "$DESC_RESPONSE"
    exit 1
  fi

  sleep 1
done

echo ""
echo "=== Getting order ==="
GET_RESPONSE=$(curl -sf "http://localhost:${APIGW_PORT}/orders/${ORDER_ID}")
echo "$GET_RESPONSE" | python3 -m json.tool

echo ""
echo "=== Checking SSM Parameter ==="
aws --endpoint-url "http://localhost:${SSM_PORT}" ssm get-parameter --name /orders/config/max-items

echo ""
echo "=== Checking Secret ==="
aws --endpoint-url "http://localhost:${SM_PORT}" secretsmanager get-secret-value --secret-id orders/notification-api-key
