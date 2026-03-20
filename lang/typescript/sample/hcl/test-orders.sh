#!/usr/bin/env bash
set -euo pipefail

LWS=$(which lws)

echo "=== Creating order ==="
CREATE_RESPONSE=$($LWS apigateway test-invoke-method \
  --resource /orders \
  --http-method POST \
  --body '{"customerName": "Alice", "items": ["widget", "gadget"], "total": 49.99}')

echo "$CREATE_RESPONSE" | python3 -m json.tool

ORDER_ID=$(echo "$CREATE_RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin)['body']['orderId'])")
echo "Order ID: $ORDER_ID"

echo ""
echo "=== Starting OrderWorkflow ==="
SFN_INPUT=$(python3 -c "import json; print(json.dumps({'orderId': '$ORDER_ID', 'items': ['widget', 'gadget'], 'total': 49.99}))")

START_RESPONSE=$($LWS stepfunctions start-execution \
  --name OrderWorkflow \
  --input "$SFN_INPUT")

echo "$START_RESPONSE" | python3 -m json.tool

EXEC_ARN=$(echo "$START_RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin)['executionArn'])")

echo ""
echo "=== Polling for workflow completion ==="
for i in $(seq 1 15); do
  DESC_RESPONSE=$($LWS stepfunctions describe-execution \
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
    echo "$DESC_RESPONSE" | python3 -m json.tool
    exit 1
  fi

  sleep 1
done

echo ""
echo "=== Getting order ==="
GET_RESPONSE=$($LWS apigateway test-invoke-method \
  --resource "/orders/$ORDER_ID" \
  --http-method GET)

echo "$GET_RESPONSE" | python3 -m json.tool

echo ""
echo "=== Checking SSM Parameter ==="
$LWS ssm get-parameter --name /orders/config/max-items

echo ""
echo "=== Checking Secret ==="
$LWS secretsmanager get-secret-value --secret-id orders/notification-api-key
