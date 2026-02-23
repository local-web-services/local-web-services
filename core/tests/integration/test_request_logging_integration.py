"""Integration tests for request logging middleware across all providers.

Ensures that all provider routes properly log requests with:
- Service name
- Request/response bodies
- Proper operation extraction
- WebSocket emission
"""

from __future__ import annotations

import asyncio
import logging
from pathlib import Path

import httpx
import pytest

from lws.interfaces import KeyAttribute, KeySchema, TableConfig
from lws.logging.logger import WebSocketLogHandler, get_logger, set_ws_handler
from lws.providers.dynamodb.provider import SqliteDynamoProvider
from lws.providers.dynamodb.routes import create_dynamodb_app
from lws.providers.s3.provider import S3Provider
from lws.providers.s3.routes import create_s3_app
from lws.providers.sqs.provider import QueueConfig, SqsProvider
from lws.providers.sqs.routes import create_sqs_app


@pytest.fixture(autouse=True)
def setup_logging():
    """Configure logging for all tests."""
    logging.basicConfig(level=logging.INFO, force=True)
    # Ensure root logger level is INFO
    logging.getLogger().setLevel(logging.INFO)


@pytest.fixture
def ws_handler():
    """Create and configure a WebSocket log handler."""
    handler = WebSocketLogHandler()
    set_ws_handler(handler)
    yield handler
    set_ws_handler(None)


class TestRequestLoggingIntegration:
    """Test that all provider routes log requests with full details."""

    # DynamoDB Tests

    @pytest.fixture
    async def dynamodb_provider(self, tmp_path: Path, ws_handler: WebSocketLogHandler):
        """Create DynamoDB provider."""
        p = SqliteDynamoProvider(
            data_dir=tmp_path,
            tables=[
                TableConfig(
                    table_name="TestTable",
                    key_schema=KeySchema(partition_key=KeyAttribute(name="pk", type="S")),
                )
            ],
        )
        await p.start()
        yield p
        await p.stop()

    @pytest.fixture
    def dynamodb_app(self, dynamodb_provider, ws_handler: WebSocketLogHandler):
        """Create DynamoDB app."""
        return create_dynamodb_app(dynamodb_provider)

    @pytest.fixture
    async def dynamodb_client(self, dynamodb_app):
        """Create DynamoDB HTTP client."""
        transport = httpx.ASGITransport(app=dynamodb_app)
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            yield c

    async def test_dynamodb_put_item_logs_request_and_response(
        self, dynamodb_client: httpx.AsyncClient, ws_handler: WebSocketLogHandler
    ):
        """Verify DynamoDB PutItem operation logs with request/response bodies."""
        # Arrange
        expected_service = "dynamodb"
        expected_method = "POST"
        expected_status_code = 200
        expected_handler = "PutItem"
        expected_table_name = "TestTable"
        expected_backlog_count = 1

        # Act
        response = await dynamodb_client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.PutItem"},
            json={
                "TableName": expected_table_name,
                "Item": {"pk": {"S": "test123"}, "data": {"S": "hello world"}},
            },
        )

        # Assert
        assert response.status_code == expected_status_code

        backlog = ws_handler.backlog()
        assert len(backlog) == expected_backlog_count

        entry = backlog[0]
        actual_service = entry["service"]
        actual_method = entry["method"]
        actual_status_code = entry["status_code"]
        actual_handler = entry["handler"]
        assert actual_service == expected_service
        assert actual_method == expected_method
        assert actual_status_code == expected_status_code
        assert actual_handler == expected_handler
        assert "request_body" in entry
        assert expected_table_name in entry["request_body"]
        assert "response_body" in entry

    async def test_dynamodb_get_item_logs_request_and_response(
        self, dynamodb_client: httpx.AsyncClient, ws_handler: WebSocketLogHandler
    ):
        """Verify DynamoDB GetItem operation logs with full details."""
        # Arrange
        expected_service = "dynamodb"
        expected_handler = "GetItem"
        expected_status_code = 200
        expected_backlog_count = 1
        expected_pk = "get123"
        table_name = "TestTable"

        # First put an item
        await dynamodb_client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.PutItem"},
            json={
                "TableName": table_name,
                "Item": {"pk": {"S": expected_pk}, "value": {"N": "42"}},
            },
        )

        ws_handler._buffer.clear()

        # Act
        response = await dynamodb_client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.GetItem"},
            json={"TableName": table_name, "Key": {"pk": {"S": expected_pk}}},
        )

        # Assert
        assert response.status_code == expected_status_code

        backlog = ws_handler.backlog()
        assert len(backlog) == expected_backlog_count

        entry = backlog[0]
        actual_service = entry["service"]
        actual_handler = entry["handler"]
        assert actual_service == expected_service
        assert actual_handler == expected_handler
        assert "request_body" in entry
        assert expected_pk in entry["request_body"]
        assert "response_body" in entry
        assert "Item" in entry["response_body"]

    # SQS Tests

    @pytest.fixture
    async def sqs_provider(self, ws_handler: WebSocketLogHandler):
        """Create SQS provider."""
        p = SqsProvider(
            queues=[QueueConfig(queue_name="TestQueue", is_fifo=False)],
        )
        await p.start()
        yield p
        await p.stop()

    @pytest.fixture
    def sqs_app(self, sqs_provider, ws_handler: WebSocketLogHandler):
        """Create SQS app."""
        return create_sqs_app(sqs_provider)

    @pytest.fixture
    async def sqs_client(self, sqs_app):
        """Create SQS HTTP client."""
        transport = httpx.ASGITransport(app=sqs_app)
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            yield c

    async def test_sqs_send_message_logs_request_and_response(
        self, sqs_client: httpx.AsyncClient, ws_handler: WebSocketLogHandler
    ):
        """Verify SQS SendMessage operation logs with request/response bodies."""
        # Arrange
        expected_service = "sqs"
        expected_method = "POST"
        expected_status_code = 200
        expected_handler = "SendMessage"
        expected_message_body_fragment = "MessageBody=Hello+from+integration+test"
        expected_backlog_count = 1

        # Act
        response = await sqs_client.post(
            "/",
            data={
                "Action": "SendMessage",
                "QueueUrl": "http://localhost:3002/000000000000/TestQueue",
                "MessageBody": "Hello from integration test",
            },
        )

        # Assert
        assert response.status_code == expected_status_code

        backlog = ws_handler.backlog()
        assert len(backlog) == expected_backlog_count

        entry = backlog[0]
        actual_service = entry["service"]
        actual_method = entry["method"]
        actual_status_code = entry["status_code"]
        actual_handler = entry["handler"]
        assert actual_service == expected_service
        assert actual_method == expected_method
        assert actual_status_code == expected_status_code
        assert actual_handler == expected_handler
        assert "request_body" in entry
        assert expected_message_body_fragment in entry["request_body"]
        assert "response_body" in entry

    # S3 Tests

    @pytest.fixture
    async def s3_provider(self, tmp_path: Path, ws_handler: WebSocketLogHandler):
        """Create S3 provider."""
        p = S3Provider(data_dir=tmp_path, buckets=["test-bucket"])
        await p.start()
        yield p
        await p.stop()

    @pytest.fixture
    def s3_app(self, s3_provider, ws_handler: WebSocketLogHandler):
        """Create S3 app."""
        return create_s3_app(s3_provider)

    @pytest.fixture
    async def s3_client(self, s3_app):
        """Create S3 HTTP client."""
        transport = httpx.ASGITransport(app=s3_app)
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            yield c

    async def test_s3_put_object_logs_request_and_response(
        self, s3_client: httpx.AsyncClient, ws_handler: WebSocketLogHandler
    ):
        """Verify S3 PutObject operation logs with request/response bodies."""
        # Arrange
        expected_service = "s3"
        expected_method = "PUT"
        expected_status_code = 200
        expected_request_body_fragment = "Hello S3!"
        expected_response_body = ""
        expected_backlog_count = 1

        # Act
        response = await s3_client.put(
            "/test-bucket/test-file.txt",
            content=b"Hello S3!",
            headers={"Content-Type": "text/plain"},
        )

        # Assert
        assert response.status_code == expected_status_code

        backlog = ws_handler.backlog()
        assert len(backlog) == expected_backlog_count

        entry = backlog[0]
        actual_service = entry["service"]
        actual_method = entry["method"]
        actual_status_code = entry["status_code"]
        actual_response_body = entry["response_body"]
        assert actual_service == expected_service
        assert actual_method == expected_method
        assert actual_status_code == expected_status_code
        assert "request_body" in entry
        assert expected_request_body_fragment in entry["request_body"]
        assert "response_body" in entry
        assert actual_response_body == expected_response_body

    # WebSocket Streaming Tests

    async def test_websocket_receives_live_logs(self, ws_handler: WebSocketLogHandler):
        """Verify WebSocket clients receive logs as they're emitted."""
        # Arrange
        expected_service = "test"
        expected_request_body = '{"test": "request"}'
        expected_response_body = '{"test": "response"}'

        queue = ws_handler.subscribe()

        # Act
        logger = get_logger("test.websocket")
        logger.log_http_request(
            method="POST",
            path="/test",
            handler_name="TestHandler",
            duration_ms=15.5,
            status_code=201,
            service=expected_service,
            request_body=expected_request_body,
            response_body=expected_response_body,
        )

        # Assert
        entry = await asyncio.wait_for(queue.get(), timeout=1.0)
        actual_service = entry["service"]
        actual_request_body = entry["request_body"]
        actual_response_body = entry["response_body"]
        assert actual_service == expected_service
        assert actual_request_body == expected_request_body
        assert actual_response_body == expected_response_body

        ws_handler.unsubscribe(queue)

    async def test_multiple_clients_receive_same_log(self, ws_handler: WebSocketLogHandler):
        """Verify all connected clients receive the same log entries."""
        # Arrange
        expected_service = "shared"

        q1 = ws_handler.subscribe()
        q2 = ws_handler.subscribe()

        # Act
        logger = get_logger("test.multicast")
        logger.log_http_request(
            method="GET",
            path="/shared",
            handler_name="SharedHandler",
            duration_ms=5.0,
            status_code=200,
            service=expected_service,
        )

        # Assert
        entry1 = await asyncio.wait_for(q1.get(), timeout=1.0)
        entry2 = await asyncio.wait_for(q2.get(), timeout=1.0)

        actual_service_1 = entry1["service"]
        actual_service_2 = entry2["service"]
        assert actual_service_1 == expected_service
        assert actual_service_2 == expected_service
        assert entry1["message"] == entry2["message"]

        ws_handler.unsubscribe(q1)
        ws_handler.unsubscribe(q2)
