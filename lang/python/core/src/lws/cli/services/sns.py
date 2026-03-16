"""``lws sns`` sub-commands."""

from __future__ import annotations

import asyncio
import json

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
        topic_arn = resource.get("arn", f"arn:aws:sns:us-east-1:000000000000:{topic_name}")
    except Exception:
        topic_arn = f"arn:aws:sns:us-east-1:000000000000:{topic_name}"
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


@app.command("unsubscribe")
def unsubscribe(
    subscription_arn: str = typer.Option(..., "--subscription-arn", help="Subscription ARN"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Unsubscribe from a topic."""
    asyncio.run(_unsubscribe(subscription_arn, port))


async def _unsubscribe(subscription_arn: str, port: int) -> None:
    client = _client(port)
    xml = await client.form_request(
        _SERVICE,
        {"Action": "Unsubscribe", "SubscriptionArn": subscription_arn},
    )
    output_json(xml_to_dict(xml))


@app.command("get-topic-attributes")
def get_topic_attributes(
    topic_arn: str = typer.Option(..., "--topic-arn", help="Topic ARN"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get topic attributes."""
    asyncio.run(_get_topic_attributes(topic_arn, port))


async def _get_topic_attributes(topic_arn: str, port: int) -> None:
    client = _client(port)
    xml = await client.form_request(
        _SERVICE,
        {"Action": "GetTopicAttributes", "TopicArn": topic_arn},
    )
    output_json(xml_to_dict(xml))


@app.command("set-topic-attributes")
def set_topic_attributes(
    topic_arn: str = typer.Option(..., "--topic-arn", help="Topic ARN"),
    attribute_name: str = typer.Option(..., "--attribute-name", help="Attribute name"),
    attribute_value: str = typer.Option(..., "--attribute-value", help="Attribute value"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Set a topic attribute."""
    asyncio.run(_set_topic_attributes(topic_arn, attribute_name, attribute_value, port))


async def _set_topic_attributes(
    topic_arn: str, attribute_name: str, attribute_value: str, port: int
) -> None:
    client = _client(port)
    xml = await client.form_request(
        _SERVICE,
        {
            "Action": "SetTopicAttributes",
            "TopicArn": topic_arn,
            "AttributeName": attribute_name,
            "AttributeValue": attribute_value,
        },
    )
    output_json(xml_to_dict(xml))


@app.command("list-tags-for-resource")
def list_tags_for_resource(
    resource_arn: str = typer.Option(..., "--resource-arn", help="Resource ARN"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List tags for a resource."""
    asyncio.run(_list_tags_for_resource(resource_arn, port))


async def _list_tags_for_resource(resource_arn: str, port: int) -> None:
    client = _client(port)
    xml = await client.form_request(
        _SERVICE,
        {"Action": "ListTagsForResource", "ResourceArn": resource_arn},
    )
    output_json(xml_to_dict(xml))


@app.command("tag-resource")
def tag_resource(
    resource_arn: str = typer.Option(..., "--resource-arn", help="Resource ARN"),
    tags: str = typer.Option(..., "--tags", help="JSON array of tag objects"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Tag a resource."""
    asyncio.run(_tag_resource(resource_arn, tags, port))


async def _tag_resource(resource_arn: str, tags: str, port: int) -> None:
    client = _client(port)
    params: dict[str, str] = {
        "Action": "TagResource",
        "ResourceArn": resource_arn,
    }
    tag_list = json.loads(tags)
    for i, tag in enumerate(tag_list, start=1):
        params[f"Tags.member.{i}.Key"] = tag["Key"]
        params[f"Tags.member.{i}.Value"] = tag["Value"]
    xml = await client.form_request(_SERVICE, params)
    output_json(xml_to_dict(xml))


@app.command("untag-resource")
def untag_resource(
    resource_arn: str = typer.Option(..., "--resource-arn", help="Resource ARN"),
    tag_keys: str = typer.Option(..., "--tag-keys", help="JSON array of tag keys"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Remove tags from a resource."""
    asyncio.run(_untag_resource(resource_arn, tag_keys, port))


async def _untag_resource(resource_arn: str, tag_keys: str, port: int) -> None:
    client = _client(port)
    params: dict[str, str] = {
        "Action": "UntagResource",
        "ResourceArn": resource_arn,
    }
    keys = json.loads(tag_keys)
    for i, key in enumerate(keys, start=1):
        params[f"TagKeys.member.{i}"] = key
    xml = await client.form_request(_SERVICE, params)
    output_json(xml_to_dict(xml))


@app.command("get-subscription-attributes")
def get_subscription_attributes(
    subscription_arn: str = typer.Option(..., "--subscription-arn", help="Subscription ARN"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get subscription attributes."""
    asyncio.run(_get_subscription_attributes(subscription_arn, port))


async def _get_subscription_attributes(subscription_arn: str, port: int) -> None:
    client = _client(port)
    xml = await client.form_request(
        _SERVICE,
        {"Action": "GetSubscriptionAttributes", "SubscriptionArn": subscription_arn},
    )
    output_json(xml_to_dict(xml))


@app.command("set-subscription-attributes")
def set_subscription_attributes(
    subscription_arn: str = typer.Option(..., "--subscription-arn", help="Subscription ARN"),
    attribute_name: str = typer.Option(..., "--attribute-name", help="Attribute name"),
    attribute_value: str = typer.Option(..., "--attribute-value", help="Attribute value"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Set a subscription attribute."""
    asyncio.run(
        _set_subscription_attributes(subscription_arn, attribute_name, attribute_value, port)
    )


async def _set_subscription_attributes(
    subscription_arn: str, attribute_name: str, attribute_value: str, port: int
) -> None:
    client = _client(port)
    xml = await client.form_request(
        _SERVICE,
        {
            "Action": "SetSubscriptionAttributes",
            "SubscriptionArn": subscription_arn,
            "AttributeName": attribute_name,
            "AttributeValue": attribute_value,
        },
    )
    output_json(xml_to_dict(xml))


@app.command("confirm-subscription")
def confirm_subscription(
    topic_arn: str = typer.Option(..., "--topic-arn", help="Topic ARN"),
    token: str = typer.Option(..., "--token", help="Subscription confirmation token"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Confirm a subscription."""
    asyncio.run(_confirm_subscription(topic_arn, token, port))


async def _confirm_subscription(topic_arn: str, token: str, port: int) -> None:
    client = _client(port)
    xml = await client.form_request(
        _SERVICE,
        {"Action": "ConfirmSubscription", "TopicArn": topic_arn, "Token": token},
    )
    output_json(xml_to_dict(xml))


@app.command("list-subscriptions-by-topic")
def list_subscriptions_by_topic(
    topic_arn: str = typer.Option(..., "--topic-arn", help="Topic ARN"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List subscriptions for a topic."""
    asyncio.run(_list_subscriptions_by_topic(topic_arn, port))


async def _list_subscriptions_by_topic(topic_arn: str, port: int) -> None:
    client = _client(port)
    xml = await client.form_request(
        _SERVICE,
        {"Action": "ListSubscriptionsByTopic", "TopicArn": topic_arn},
    )
    output_json(xml_to_dict(xml))
