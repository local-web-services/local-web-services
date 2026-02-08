"""SNS wire protocol HTTP routes.

Implements the SNS Action-based form-encoded API that AWS SDKs use.
Each request posts to ``/`` with an ``Action`` parameter that selects
the operation.  Responses use the standard AWS SNS XML format.
"""

from __future__ import annotations

import uuid

from fastapi import FastAPI, Request, Response

from ldk.logging.logger import get_logger
from ldk.logging.middleware import RequestLoggingMiddleware
from ldk.providers.sns.provider import SnsProvider

_logger = get_logger("ldk.sns")


async def _parse_form(request: Request) -> dict[str, str]:
    """Parse the form-encoded body of an SNS request."""
    form = await request.form()
    return {k: str(v) for k, v in form.items()}


# ------------------------------------------------------------------
# Action handlers
# ------------------------------------------------------------------


async def _handle_publish(provider: SnsProvider, params: dict[str, str]) -> Response:
    """Handle the ``Publish`` action."""
    topic_arn = params.get("TopicArn", "")
    # Derive topic name from the ARN (last segment after the colon)
    topic_name = topic_arn.rsplit(":", 1)[-1] if ":" in topic_arn else topic_arn
    message = params.get("Message", "")
    subject = params.get("Subject") or None

    message_attributes = _parse_message_attributes(params)

    message_id = await provider.publish(
        topic_name=topic_name,
        message=message,
        subject=subject,
        message_attributes=message_attributes or None,
    )

    xml = (
        "<PublishResponse>"
        "<PublishResult>"
        f"<MessageId>{message_id}</MessageId>"
        "</PublishResult>"
        f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
        "</PublishResponse>"
    )
    return Response(content=xml, media_type="text/xml")


async def _handle_subscribe(provider: SnsProvider, params: dict[str, str]) -> Response:
    """Handle the ``Subscribe`` action."""
    topic_arn = params.get("TopicArn", "")
    topic_name = topic_arn.rsplit(":", 1)[-1] if ":" in topic_arn else topic_arn
    protocol = params.get("Protocol", "")
    endpoint = params.get("Endpoint", "")

    subscription_arn = await provider.subscribe(
        topic_name=topic_name,
        protocol=protocol,
        endpoint=endpoint,
    )

    xml = (
        "<SubscribeResponse>"
        "<SubscribeResult>"
        f"<SubscriptionArn>{subscription_arn}</SubscriptionArn>"
        "</SubscribeResult>"
        f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
        "</SubscribeResponse>"
    )
    return Response(content=xml, media_type="text/xml")


async def _handle_list_subscriptions(provider: SnsProvider, params: dict[str, str]) -> Response:
    """Handle the ``ListSubscriptions`` action."""
    members: list[str] = []
    for topic in provider.list_topics():
        for sub in topic.subscribers:
            members.append(
                "<member>"
                f"<TopicArn>{topic.topic_arn}</TopicArn>"
                f"<Protocol>{sub.protocol}</Protocol>"
                f"<SubscriptionArn>{sub.subscription_arn}</SubscriptionArn>"
                f"<Endpoint>{sub.endpoint}</Endpoint>"
                "</member>"
            )

    xml = (
        "<ListSubscriptionsResponse>"
        "<ListSubscriptionsResult>"
        f"<Subscriptions>{''.join(members)}</Subscriptions>"
        "</ListSubscriptionsResult>"
        f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
        "</ListSubscriptionsResponse>"
    )
    return Response(content=xml, media_type="text/xml")


async def _handle_create_topic(provider: SnsProvider, params: dict[str, str]) -> Response:
    """Handle the ``CreateTopic`` action.

    For local development this is a no-op if the topic already exists.
    """
    topic_name = params.get("Name", "")
    try:
        topic = provider.get_topic(topic_name)
        topic_arn = topic.topic_arn
    except KeyError:
        # Topic doesn't exist -- in a real implementation we'd create it,
        # but for local dev we return a synthesised ARN.
        topic_arn = f"arn:aws:sns:us-east-1:000000000000:{topic_name}"

    xml = (
        "<CreateTopicResponse>"
        "<CreateTopicResult>"
        f"<TopicArn>{topic_arn}</TopicArn>"
        "</CreateTopicResult>"
        f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
        "</CreateTopicResponse>"
    )
    return Response(content=xml, media_type="text/xml")


async def _handle_list_topics(provider: SnsProvider, params: dict[str, str]) -> Response:
    """Handle the ``ListTopics`` action."""
    members: list[str] = []
    for topic in provider.list_topics():
        members.append("<member>" f"<TopicArn>{topic.topic_arn}</TopicArn>" "</member>")

    xml = (
        "<ListTopicsResponse>"
        "<ListTopicsResult>"
        f"<Topics>{''.join(members)}</Topics>"
        "</ListTopicsResult>"
        f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
        "</ListTopicsResponse>"
    )
    return Response(content=xml, media_type="text/xml")


# ------------------------------------------------------------------
# Action dispatch table
# ------------------------------------------------------------------

_ACTION_HANDLERS = {
    "Publish": _handle_publish,
    "Subscribe": _handle_subscribe,
    "ListSubscriptions": _handle_list_subscriptions,
    "CreateTopic": _handle_create_topic,
    "ListTopics": _handle_list_topics,
}


# ------------------------------------------------------------------
# Message attribute parsing
# ------------------------------------------------------------------


def _parse_message_attributes(params: dict[str, str]) -> dict:
    """Parse ``MessageAttributes.entry.N.*`` form parameters.

    AWS SNS form-encoded requests use a numbered entry pattern::

        MessageAttributes.entry.1.Name=color
        MessageAttributes.entry.1.Value.DataType=String
        MessageAttributes.entry.1.Value.StringValue=red
    """
    attributes: dict = {}
    n = 1
    while True:
        prefix = f"MessageAttributes.entry.{n}"
        attr_name = params.get(f"{prefix}.Name")
        if attr_name is None:
            break
        data_type = params.get(f"{prefix}.Value.DataType", "String")
        string_value = params.get(f"{prefix}.Value.StringValue", "")
        attributes[attr_name] = {
            "DataType": data_type,
            "StringValue": string_value,
        }
        n += 1
    return attributes


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


def create_sns_app(provider: SnsProvider) -> FastAPI:
    """Create a FastAPI application that speaks the SNS wire protocol."""
    app = FastAPI(title="LDK SNS")
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="sns")

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        params = await _parse_form(request)
        action = params.get("Action", "")
        handler = _ACTION_HANDLERS.get(action)
        if handler is None:
            xml = (
                "<ErrorResponse>"
                "<Error>"
                "<Code>InvalidAction</Code>"
                f"<Message>Unknown action: {action}</Message>"
                "</Error>"
                f"<RequestId>{uuid.uuid4()}</RequestId>"
                "</ErrorResponse>"
            )
            return Response(content=xml, status_code=400, media_type="text/xml")

        return await handler(provider, params)

    return app
