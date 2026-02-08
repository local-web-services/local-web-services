"""``lws sqs`` sub-commands."""

from __future__ import annotations

import asyncio

import typer

from ldk.cli.services.client import LwsClient, exit_with_error, output_json, xml_to_dict

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
    except Exception as exc:
        exit_with_error(str(exc))
    queue_url = resource.get("queue_url", "")
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
    except Exception as exc:
        exit_with_error(str(exc))
    queue_url = resource.get("queue_url", "")
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
    except Exception as exc:
        exit_with_error(str(exc))
    queue_url = resource.get("queue_url", "")
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
    except Exception as exc:
        exit_with_error(str(exc))
    queue_url = resource.get("queue_url", "")
    xml = await client.form_request(
        _SERVICE,
        {"Action": "GetQueueAttributes", "QueueUrl": queue_url},
    )
    output_json(xml_to_dict(xml))
