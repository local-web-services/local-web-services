"""``lws sqs`` sub-commands."""

from __future__ import annotations

import asyncio
import json

import typer

from lws.cli.services.client import LwsClient, exit_with_error, output_json, xml_to_dict

app = typer.Typer(help="SQS commands")

_SERVICE = "sqs"


def _client(port: int) -> LwsClient:
    return LwsClient(port=port)


@app.command("send-message")
def send_message(
    queue_name: str = typer.Option(..., "--queue-name", help="Queue name"),
    message_body: str = typer.Option(..., "--message-body", help="Message body"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Send a message to a queue."""
    asyncio.run(_send_message(queue_name, message_body, port))


async def _send_message(queue_name: str, message_body: str, port: int) -> None:
    client = _client(port)
    try:
        resource = await client.resolve_resource(_SERVICE, queue_name)
        queue_url = resource.get("queue_url", "")
    except Exception:
        svc_port = await client.service_port(_SERVICE)
        queue_url = f"http://localhost:{svc_port}/000000000000/{queue_name}"
    xml = await client.form_request(
        _SERVICE,
        {"Action": "SendMessage", "QueueUrl": queue_url, "MessageBody": message_body},
    )
    output_json(xml_to_dict(xml))


@app.command("receive-message")
def receive_message(
    queue_name: str = typer.Option(..., "--queue-name", help="Queue name"),
    max_messages: int = typer.Option(1, "--max-number-of-messages", help="Max messages"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Receive messages from a queue."""
    asyncio.run(_receive_message(queue_name, max_messages, port))


async def _receive_message(queue_name: str, max_messages: int, port: int) -> None:
    client = _client(port)
    try:
        resource = await client.resolve_resource(_SERVICE, queue_name)
        queue_url = resource.get("queue_url", "")
    except Exception:
        svc_port = await client.service_port(_SERVICE)
        queue_url = f"http://localhost:{svc_port}/000000000000/{queue_name}"
    xml = await client.form_request(
        _SERVICE,
        {
            "Action": "ReceiveMessage",
            "QueueUrl": queue_url,
            "MaxNumberOfMessages": str(max_messages),
        },
    )
    output_json(xml_to_dict(xml))


@app.command("delete-message")
def delete_message(
    queue_name: str = typer.Option(..., "--queue-name", help="Queue name"),
    receipt_handle: str = typer.Option(..., "--receipt-handle", help="Receipt handle"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a message from a queue."""
    asyncio.run(_delete_message(queue_name, receipt_handle, port))


async def _delete_message(queue_name: str, receipt_handle: str, port: int) -> None:
    client = _client(port)
    try:
        resource = await client.resolve_resource(_SERVICE, queue_name)
        queue_url = resource.get("queue_url", "")
    except Exception:
        svc_port = await client.service_port(_SERVICE)
        queue_url = f"http://localhost:{svc_port}/000000000000/{queue_name}"
    xml = await client.form_request(
        _SERVICE,
        {
            "Action": "DeleteMessage",
            "QueueUrl": queue_url,
            "ReceiptHandle": receipt_handle,
        },
    )
    output_json(xml_to_dict(xml))


@app.command("get-queue-attributes")
def get_queue_attributes(
    queue_name: str = typer.Option(..., "--queue-name", help="Queue name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get queue attributes."""
    asyncio.run(_get_queue_attributes(queue_name, port))


async def _get_queue_attributes(queue_name: str, port: int) -> None:
    client = _client(port)
    try:
        resource = await client.resolve_resource(_SERVICE, queue_name)
        queue_url = resource.get("queue_url", "")
    except Exception:
        svc_port = await client.service_port(_SERVICE)
        queue_url = f"http://localhost:{svc_port}/000000000000/{queue_name}"
    xml = await client.form_request(
        _SERVICE,
        {"Action": "GetQueueAttributes", "QueueUrl": queue_url},
    )
    output_json(xml_to_dict(xml))


@app.command("create-queue")
def create_queue(
    queue_name: str = typer.Option(..., "--queue-name", help="Queue name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a queue."""
    asyncio.run(_create_queue(queue_name, port))


async def _create_queue(queue_name: str, port: int) -> None:
    client = _client(port)
    try:
        xml = await client.form_request(
            _SERVICE,
            {"Action": "CreateQueue", "QueueName": queue_name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(xml_to_dict(xml))


@app.command("delete-queue")
def delete_queue(
    queue_name: str = typer.Option(..., "--queue-name", help="Queue name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a queue."""
    asyncio.run(_delete_queue(queue_name, port))


async def _delete_queue(queue_name: str, port: int) -> None:
    client = _client(port)
    try:
        svc_port = await client.service_port(_SERVICE)
        queue_url = f"http://localhost:{svc_port}/000000000000/{queue_name}"
        xml = await client.form_request(
            _SERVICE,
            {"Action": "DeleteQueue", "QueueUrl": queue_url},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(xml_to_dict(xml))


@app.command("list-queues")
def list_queues(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List all queues."""
    asyncio.run(_list_queues(port))


async def _list_queues(port: int) -> None:
    client = _client(port)
    try:
        xml = await client.form_request(
            _SERVICE,
            {"Action": "ListQueues"},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(xml_to_dict(xml))


@app.command("purge-queue")
def purge_queue(
    queue_name: str = typer.Option(..., "--queue-name", help="Queue name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Purge all messages from a queue."""
    asyncio.run(_purge_queue(queue_name, port))


async def _purge_queue(queue_name: str, port: int) -> None:
    client = _client(port)
    try:
        svc_port = await client.service_port(_SERVICE)
        queue_url = f"http://localhost:{svc_port}/000000000000/{queue_name}"
        xml = await client.form_request(
            _SERVICE,
            {"Action": "PurgeQueue", "QueueUrl": queue_url},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(xml_to_dict(xml))


@app.command("get-queue-url")
def get_queue_url(
    queue_name: str = typer.Option(..., "--queue-name", help="Queue name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get the URL of a queue."""
    asyncio.run(_get_queue_url(queue_name, port))


async def _get_queue_url(queue_name: str, port: int) -> None:
    client = _client(port)
    xml = await client.form_request(
        _SERVICE,
        {"Action": "GetQueueUrl", "QueueName": queue_name},
    )
    output_json(xml_to_dict(xml))


@app.command("set-queue-attributes")
def set_queue_attributes(
    queue_name: str = typer.Option(..., "--queue-name", help="Queue name"),
    attributes: str = typer.Option(..., "--attributes", help="JSON object of attributes"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Set attributes on a queue."""
    asyncio.run(_set_queue_attributes(queue_name, attributes, port))


async def _set_queue_attributes(queue_name: str, attributes: str, port: int) -> None:
    client = _client(port)
    try:
        resource = await client.resolve_resource(_SERVICE, queue_name)
        queue_url = resource.get("queue_url", "")
    except Exception:
        svc_port = await client.service_port(_SERVICE)
        queue_url = f"http://localhost:{svc_port}/000000000000/{queue_name}"
    params: dict[str, str] = {
        "Action": "SetQueueAttributes",
        "QueueUrl": queue_url,
    }
    attrs = json.loads(attributes)
    for i, (key, value) in enumerate(attrs.items(), start=1):
        params[f"Attribute.{i}.Name"] = key
        params[f"Attribute.{i}.Value"] = value
    xml = await client.form_request(_SERVICE, params)
    output_json(xml_to_dict(xml))


@app.command("send-message-batch")
def send_message_batch(
    queue_name: str = typer.Option(..., "--queue-name", help="Queue name"),
    entries: str = typer.Option(..., "--entries", help="JSON array of entries"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Send a batch of messages to a queue."""
    asyncio.run(_send_message_batch(queue_name, entries, port))


async def _send_message_batch(queue_name: str, entries: str, port: int) -> None:
    client = _client(port)
    try:
        resource = await client.resolve_resource(_SERVICE, queue_name)
        queue_url = resource.get("queue_url", "")
    except Exception:
        svc_port = await client.service_port(_SERVICE)
        queue_url = f"http://localhost:{svc_port}/000000000000/{queue_name}"
    params: dict[str, str] = {
        "Action": "SendMessageBatch",
        "QueueUrl": queue_url,
    }
    items = json.loads(entries)
    for i, entry in enumerate(items, start=1):
        params[f"SendMessageBatchRequestEntry.{i}.Id"] = entry["Id"]
        params[f"SendMessageBatchRequestEntry.{i}.MessageBody"] = entry["MessageBody"]
    xml = await client.form_request(_SERVICE, params)
    output_json(xml_to_dict(xml))


@app.command("delete-message-batch")
def delete_message_batch(
    queue_name: str = typer.Option(..., "--queue-name", help="Queue name"),
    entries: str = typer.Option(..., "--entries", help="JSON array of entries"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a batch of messages from a queue."""
    asyncio.run(_delete_message_batch(queue_name, entries, port))


async def _delete_message_batch(queue_name: str, entries: str, port: int) -> None:
    client = _client(port)
    try:
        resource = await client.resolve_resource(_SERVICE, queue_name)
        queue_url = resource.get("queue_url", "")
    except Exception:
        svc_port = await client.service_port(_SERVICE)
        queue_url = f"http://localhost:{svc_port}/000000000000/{queue_name}"
    params: dict[str, str] = {
        "Action": "DeleteMessageBatch",
        "QueueUrl": queue_url,
    }
    items = json.loads(entries)
    for i, entry in enumerate(items, start=1):
        params[f"DeleteMessageBatchRequestEntry.{i}.Id"] = entry["Id"]
        params[f"DeleteMessageBatchRequestEntry.{i}.ReceiptHandle"] = entry["ReceiptHandle"]
    xml = await client.form_request(_SERVICE, params)
    output_json(xml_to_dict(xml))


@app.command("change-message-visibility")
def change_message_visibility(
    queue_name: str = typer.Option(..., "--queue-name", help="Queue name"),
    receipt_handle: str = typer.Option(..., "--receipt-handle", help="Receipt handle"),
    visibility_timeout: int = typer.Option(..., "--visibility-timeout", help="Visibility timeout"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Change the visibility timeout of a message."""
    asyncio.run(_change_message_visibility(queue_name, receipt_handle, visibility_timeout, port))


async def _change_message_visibility(
    queue_name: str, receipt_handle: str, visibility_timeout: int, port: int
) -> None:
    client = _client(port)
    try:
        resource = await client.resolve_resource(_SERVICE, queue_name)
        queue_url = resource.get("queue_url", "")
    except Exception:
        svc_port = await client.service_port(_SERVICE)
        queue_url = f"http://localhost:{svc_port}/000000000000/{queue_name}"
    xml = await client.form_request(
        _SERVICE,
        {
            "Action": "ChangeMessageVisibility",
            "QueueUrl": queue_url,
            "ReceiptHandle": receipt_handle,
            "VisibilityTimeout": str(visibility_timeout),
        },
    )
    output_json(xml_to_dict(xml))


@app.command("change-message-visibility-batch")
def change_message_visibility_batch(
    queue_name: str = typer.Option(..., "--queue-name", help="Queue name"),
    entries: str = typer.Option(..., "--entries", help="JSON array of entries"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Change visibility timeout for a batch of messages."""
    asyncio.run(_change_message_visibility_batch(queue_name, entries, port))


async def _change_message_visibility_batch(queue_name: str, entries: str, port: int) -> None:
    client = _client(port)
    try:
        resource = await client.resolve_resource(_SERVICE, queue_name)
        queue_url = resource.get("queue_url", "")
    except Exception:
        svc_port = await client.service_port(_SERVICE)
        queue_url = f"http://localhost:{svc_port}/000000000000/{queue_name}"
    params: dict[str, str] = {
        "Action": "ChangeMessageVisibilityBatch",
        "QueueUrl": queue_url,
    }
    items = json.loads(entries)
    for i, entry in enumerate(items, start=1):
        params[f"ChangeMessageVisibilityBatchRequestEntry.{i}.Id"] = entry["Id"]
        params[f"ChangeMessageVisibilityBatchRequestEntry.{i}.ReceiptHandle"] = entry[
            "ReceiptHandle"
        ]
        params[f"ChangeMessageVisibilityBatchRequestEntry.{i}.VisibilityTimeout"] = str(
            entry["VisibilityTimeout"]
        )
    xml = await client.form_request(_SERVICE, params)
    output_json(xml_to_dict(xml))


@app.command("list-queue-tags")
def list_queue_tags(
    queue_name: str = typer.Option(..., "--queue-name", help="Queue name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List tags on a queue."""
    asyncio.run(_list_queue_tags(queue_name, port))


async def _list_queue_tags(queue_name: str, port: int) -> None:
    client = _client(port)
    try:
        resource = await client.resolve_resource(_SERVICE, queue_name)
        queue_url = resource.get("queue_url", "")
    except Exception:
        svc_port = await client.service_port(_SERVICE)
        queue_url = f"http://localhost:{svc_port}/000000000000/{queue_name}"
    xml = await client.form_request(
        _SERVICE,
        {"Action": "ListQueueTags", "QueueUrl": queue_url},
    )
    output_json(xml_to_dict(xml))


@app.command("tag-queue")
def tag_queue(
    queue_name: str = typer.Option(..., "--queue-name", help="Queue name"),
    tags: str = typer.Option(..., "--tags", help="JSON object of tags"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Tag a queue."""
    asyncio.run(_tag_queue(queue_name, tags, port))


async def _tag_queue(queue_name: str, tags: str, port: int) -> None:
    client = _client(port)
    try:
        resource = await client.resolve_resource(_SERVICE, queue_name)
        queue_url = resource.get("queue_url", "")
    except Exception:
        svc_port = await client.service_port(_SERVICE)
        queue_url = f"http://localhost:{svc_port}/000000000000/{queue_name}"
    params: dict[str, str] = {
        "Action": "TagQueue",
        "QueueUrl": queue_url,
    }
    tag_dict = json.loads(tags)
    for i, (key, value) in enumerate(tag_dict.items(), start=1):
        params[f"Tag.{i}.Key"] = key
        params[f"Tag.{i}.Value"] = value
    xml = await client.form_request(_SERVICE, params)
    output_json(xml_to_dict(xml))


@app.command("untag-queue")
def untag_queue(
    queue_name: str = typer.Option(..., "--queue-name", help="Queue name"),
    tag_keys: str = typer.Option(..., "--tag-keys", help="JSON array of tag keys"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Remove tags from a queue."""
    asyncio.run(_untag_queue(queue_name, tag_keys, port))


async def _untag_queue(queue_name: str, tag_keys: str, port: int) -> None:
    client = _client(port)
    try:
        resource = await client.resolve_resource(_SERVICE, queue_name)
        queue_url = resource.get("queue_url", "")
    except Exception:
        svc_port = await client.service_port(_SERVICE)
        queue_url = f"http://localhost:{svc_port}/000000000000/{queue_name}"
    params: dict[str, str] = {
        "Action": "UntagQueue",
        "QueueUrl": queue_url,
    }
    keys = json.loads(tag_keys)
    for i, key in enumerate(keys, start=1):
        params[f"TagKey.{i}"] = key
    xml = await client.form_request(_SERVICE, params)
    output_json(xml_to_dict(xml))


@app.command("list-dead-letter-source-queues")
def list_dead_letter_source_queues(
    queue_name: str = typer.Option(..., "--queue-name", help="Queue name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List dead-letter source queues."""
    asyncio.run(_list_dead_letter_source_queues(queue_name, port))


async def _list_dead_letter_source_queues(queue_name: str, port: int) -> None:
    client = _client(port)
    try:
        resource = await client.resolve_resource(_SERVICE, queue_name)
        queue_url = resource.get("queue_url", "")
    except Exception:
        svc_port = await client.service_port(_SERVICE)
        queue_url = f"http://localhost:{svc_port}/000000000000/{queue_name}"
    xml = await client.form_request(
        _SERVICE,
        {"Action": "ListDeadLetterSourceQueues", "QueueUrl": queue_url},
    )
    output_json(xml_to_dict(xml))
