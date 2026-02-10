"""``lws sns`` sub-commands."""

from __future__ import annotations

import asyncio

import typer

from lws.cli.services.client import LwsClient, exit_with_error, output_json, xml_to_dict

app = typer.Typer(help="SNS commands")

_SERVICE = "sns"


def _client(port: int) -> LwsClient:
    return LwsClient(port=port)


@app.command("publish")
def publish(
    topic_name: str = typer.Option(..., "--topic-name", help="Topic name"),
    message: str = typer.Option(..., "--message", help="Message body"),
    subject: str = typer.Option(None, "--subject", help="Message subject"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Publish a message to a topic."""
    asyncio.run(_publish(topic_name, message, subject, port))


async def _publish(topic_name: str, message: str, subject: str | None, port: int) -> None:
    client = _client(port)
    try:
        resource = await client.resolve_resource(_SERVICE, topic_name)
    except Exception as exc:
        exit_with_error(str(exc))
    topic_arn = resource.get("arn", f"arn:aws:sns:us-east-1:000000000000:{topic_name}")
    params: dict[str, str] = {
        "Action": "Publish",
        "TopicArn": topic_arn,
        "Message": message,
    }
    if subject:
        params["Subject"] = subject
    xml = await client.form_request(_SERVICE, params)
    output_json(xml_to_dict(xml))


@app.command("list-topics")
def list_topics(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List all topics."""
    asyncio.run(_list_topics(port))


async def _list_topics(port: int) -> None:
    client = _client(port)
    try:
        xml = await client.form_request(_SERVICE, {"Action": "ListTopics"})
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(xml_to_dict(xml))


@app.command("list-subscriptions")
def list_subscriptions(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List all subscriptions."""
    asyncio.run(_list_subscriptions(port))


async def _list_subscriptions(port: int) -> None:
    client = _client(port)
    try:
        xml = await client.form_request(_SERVICE, {"Action": "ListSubscriptions"})
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(xml_to_dict(xml))


@app.command("create-topic")
def create_topic(
    name: str = typer.Option(..., "--name", help="Topic name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a topic."""
    asyncio.run(_create_topic(name, port))


async def _create_topic(name: str, port: int) -> None:
    client = _client(port)
    try:
        xml = await client.form_request(
            _SERVICE,
            {"Action": "CreateTopic", "Name": name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(xml_to_dict(xml))


@app.command("delete-topic")
def delete_topic(
    topic_arn: str = typer.Option(..., "--topic-arn", help="Topic ARN"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a topic."""
    asyncio.run(_delete_topic(topic_arn, port))


async def _delete_topic(topic_arn: str, port: int) -> None:
    client = _client(port)
    try:
        xml = await client.form_request(
            _SERVICE,
            {"Action": "DeleteTopic", "TopicArn": topic_arn},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(xml_to_dict(xml))


@app.command("subscribe")
def subscribe(
    topic_arn: str = typer.Option(..., "--topic-arn", help="Topic ARN"),
    protocol: str = typer.Option(..., "--protocol", help="Subscription protocol"),
    endpoint: str = typer.Option(..., "--notification-endpoint", help="Subscription endpoint"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Subscribe an endpoint to a topic."""
    asyncio.run(_subscribe(topic_arn, protocol, endpoint, port))


async def _subscribe(topic_arn: str, protocol: str, endpoint: str, port: int) -> None:
    client = _client(port)
    try:
        xml = await client.form_request(
            _SERVICE,
            {
                "Action": "Subscribe",
                "TopicArn": topic_arn,
                "Protocol": protocol,
                "Endpoint": endpoint,
            },
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(xml_to_dict(xml))
