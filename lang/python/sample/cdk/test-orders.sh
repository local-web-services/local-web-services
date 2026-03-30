#!/usr/bin/env bash
set -euo pipefail

export AWS_ACCESS_KEY_ID=ldk-local
export AWS_SECRET_ACCESS_KEY=ldk-local
export AWS_DEFAULT_REGION=us-east-1

BASE_PORT=3000
APIGW_PORT=$BASE_PORT
SNS_PORT=$((BASE_PORT + 4))
SQS_PORT=$((BASE_PORT + 2))
SFN_PORT=$((BASE_PORT + 6))
SSM_PORT=$((BASE_PORT + 12))
SM_PORT=$((BASE_PORT + 13))

echo "=== Subscribing notification queue to SNS topic ==="
TOPIC_ARN="arn:ldk:sns:local:000000000000:order-notifications"
QUEUE_URL="http://localhost:${SQS_PORT}/000000000000/order-notification-queue"
curl -sf -X POST "http://localhost:${SNS_PORT}/" \
  --data-urlencode "Action=Subscribe" \
  --data-urlencode "TopicArn=${TOPIC_ARN}" \
  --data-urlencode "Protocol=sqs" \
  --data-urlencode "Endpoint=${QUEUE_URL}" > /dev/null

echo "=== Creating order ==="
CREATE_RESPONSE=$(curl -sf -X POST "http://localhost:${APIGW_PORT}/orders" \
  -H "Content-Type: application/json" \
  -d '{"customerName": "Alice", "items": ["widget", "gadget"], "total": 49.99}')

echo "$CREATE_RESPONSE" | python3 -m json.tool

ORDER_ID=$(echo "$CREATE_RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin)['orderId'])")
echo "Order ID: $ORDER_ID"

echo ""
echo "=== Starting OrderWorkflow ==="
SFN_ARN=$(curl -sf -X POST "http://localhost:${SFN_PORT}/" \
  -H "Content-Type: application/x-amz-json-1.0" \
  -H "X-Amz-Target: AmazonStates.ListStateMachines" \
  -d '{}' | python3 -c "import sys,json; machines=json.load(sys.stdin)['stateMachines']; print([m['stateMachineArn'] for m in machines if m['name']=='OrderWorkflow'][0])")

SFN_INPUT=$(python3 -c "import json; print(json.dumps({'orderId': '$ORDER_ID', 'items': ['widget', 'gadget'], 'total': 49.99}))")
EXEC_NAME="order-$(echo "$ORDER_ID" | tr -d '-')"

START_RESPONSE=$(curl -sf -X POST "http://localhost:${SFN_PORT}/" \
  -H "Content-Type: application/x-amz-json-1.0" \
  -H "X-Amz-Target: AmazonStates.StartExecution" \
  -d "{\"stateMachineArn\": \"${SFN_ARN}\", \"name\": \"${EXEC_NAME}\", \"input\": ${SFN_INPUT}}")

echo "$START_RESPONSE"

EXEC_ARN=$(echo "$START_RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin)['executionArn'])")

echo ""
echo "=== Polling for workflow completion ==="
for i in $(seq 1 15); do
  DESC_RESPONSE=$(curl -sf -X POST "http://localhost:${SFN_PORT}/" \
    -H "Content-Type: application/x-amz-json-1.0" \
    -H "X-Amz-Target: AmazonStates.DescribeExecution" \
    -d "{\"executionArn\": \"${EXEC_ARN}\"}")

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
curl -sf -X POST "http://localhost:${SSM_PORT}/" \
  -H "Content-Type: application/x-amz-json-1.1" \
  -H "X-Amz-Target: AmazonSSM.GetParameter" \
  -d '{"Name": "/orders/config/max-items"}' | python3 -m json.tool

echo ""
echo "=== Checking Secret ==="
curl -sf -X POST "http://localhost:${SM_PORT}/" \
  -H "Content-Type: application/x-amz-json-1.1" \
  -H "X-Amz-Target: secretsmanager.GetSecretValue" \
  -d '{"SecretId": "orders/notification-api-key"}' | python3 -m json.tool
