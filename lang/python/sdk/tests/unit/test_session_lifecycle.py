"""Integration tests: verify LwsSession starts services and responds to requests."""

from __future__ import annotations

import pytest

from lws_testing import LwsSession


@pytest.fixture(scope="module")
def session():
    with LwsSession(
        tables=[{"name": "Orders", "partition_key": "id"}],
        queues=["OrderQueue"],
        buckets=["TestBucket"],
    ) as s:
        yield s


def test_dynamodb_client_is_available(session):
    # Arrange / Act
    client = session.client("dynamodb")

    # Assert
    assert client is not None, "Expected value to be set but was None"


def test_dynamodb_put_and_get_item(session):
    # Arrange
    session.reset()
    client = session.client("dynamodb")
    expected_item = {"id": {"S": "order-1"}, "status": {"S": "pending"}}

    # Act
    client.put_item(TableName="Orders", Item=expected_item)
    response = client.get_item(TableName="Orders", Key={"id": {"S": "order-1"}})

    # Assert
    actual_item = response["Item"]
    assert actual_item["id"]["S"] == "order-1", (
        f'Expected {"order-1"!r} but got {actual_item["id"]["S"]!r}'
    )
    assert actual_item["status"]["S"] == "pending", (
        f'Expected {"pending"!r} but got {actual_item["status"]["S"]!r}'
    )


def test_dynamodb_helper_scan(session):
    # Arrange
    session.reset()
    table = session.dynamodb("Orders")
    table.put({"id": {"S": "a"}, "val": {"S": "1"}})
    table.put({"id": {"S": "b"}, "val": {"S": "2"}})

    # Act
    items = table.scan()

    # Assert
    assert len(items) == 2, f"Expected {2!r} but got {len(items)!r}"


def test_s3_put_and_get(session):
    # Arrange
    session.reset()
    bucket = session.s3("TestBucket")
    expected_content = b"hello world"

    # Act
    bucket.put("test/file.txt", expected_content)
    actual_content = bucket.get("test/file.txt")

    # Assert
    assert actual_content == expected_content, (
        f"Expected {expected_content!r} but got {actual_content!r}"
    )


def test_sqs_send_and_receive(session):
    # Arrange
    session.reset()
    queue = session.sqs("OrderQueue")
    expected_body = '{"orderId": "42"}'

    # Act
    queue.send(expected_body)
    messages = queue.receive(max_messages=1)

    # Assert
    assert len(messages) == 1, f"Expected {1!r} but got {len(messages)!r}"
    assert messages[0]["Body"] == expected_body, (
        f'Expected {expected_body!r} but got {messages[0]["Body"]!r}'
    )


def test_session_reset_clears_state(session):
    # Arrange
    table = session.dynamodb("Orders")
    table.put({"id": {"S": "to-be-cleared"}})

    # Act
    session.reset()
    items = table.scan()

    # Assert
    assert len(items) == 0, f"Expected {0!r} but got {len(items)!r}"


def test_all_services_available(session):
    # Arrange / Act / Assert — all core services should have ports
    expected_services = ["dynamodb", "sqs", "s3", "sns", "stepfunctions", "ssm", "secretsmanager"]
    for svc in expected_services:
        client = session.client(svc)
        assert client is not None, f"Expected service {svc!r} to be available"


def test_vanilla_boto3_client_is_redirected_to_lws(session):
    # Arrange — env vars are set by the session; a plain boto3 client should
    # hit LWS without any explicit endpoint_url
    import boto3

    # Act
    vanilla_client = boto3.client("dynamodb", region_name="us-east-1")
    response = vanilla_client.list_tables()

    # Assert — LWS responded (real AWS would also return this key, but if the
    # env var wasn't set the call would fail with NoCredentialsError or timeout)
    assert "TableNames" in response, f'Expected {"TableNames"!r} to be in {response!r}'


def test_env_vars_are_restored_after_session_closes():
    # Arrange — capture state before any session starts
    import os

    expected_key = "AWS_ENDPOINT_URL_DYNAMODB"
    value_before = os.environ.get(expected_key)

    # Act
    with LwsSession(tables=[{"name": "Tmp", "partition_key": "id"}]):
        actual_during = os.environ.get(expected_key)

    actual_after = os.environ.get(expected_key)

    # Assert
    assert actual_during is not None, "Expected env var to be set during session"
    assert actual_after == value_before, "Expected env var to be restored after session"


def test_queue_url_returns_local_url(session):
    # Arrange
    expected_queue_name = "OrderQueue"

    # Act
    actual_url = session.queue_url(expected_queue_name)

    # Assert
    assert "127.0.0.1" in actual_url, f'Expected {"127.0.0.1"!r} to be in {actual_url!r}'
    assert expected_queue_name in actual_url, (
        f"Expected {expected_queue_name!r} to be in {actual_url!r}"
    )
