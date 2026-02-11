"""SNS wire protocol HTTP routes.

Implements the SNS Action-based form-encoded API that AWS SDKs use.
Each request posts to ``/`` with an ``Action`` parameter that selects
the operation.  Responses use the standard AWS SNS XML format.
"""

from __future__ import annotations

import uuid

from fastapi import FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers.sns.provider import SnsProvider

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


async def _handle_list_subscriptions(provider: SnsProvider, _params: dict[str, str]) -> Response:
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
    """Handle the ``CreateTopic`` action. Idempotent per AWS behaviour."""
    topic_name = params.get("Name", "")
    topic_arn = await provider.create_topic(topic_name)

    xml = (
        "<CreateTopicResponse>"
        "<CreateTopicResult>"
        f"<TopicArn>{topic_arn}</TopicArn>"
        "</CreateTopicResult>"
        f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
        "</CreateTopicResponse>"
    )
    return Response(content=xml, media_type="text/xml")


async def _handle_delete_topic(provider: SnsProvider, params: dict[str, str]) -> Response:
    """Handle the ``DeleteTopic`` action."""
    topic_arn = params.get("TopicArn", "")
    topic_name = topic_arn.rsplit(":", 1)[-1] if ":" in topic_arn else topic_arn
    try:
        await provider.delete_topic(topic_name)
    except KeyError:
        xml = (
            "<ErrorResponse>"
            "<Error>"
            "<Code>NotFound</Code>"
            f"<Message>Topic not found: {topic_arn}</Message>"
            "</Error>"
            f"<RequestId>{uuid.uuid4()}</RequestId>"
            "</ErrorResponse>"
        )
        return Response(content=xml, status_code=404, media_type="text/xml")

    xml = (
        "<DeleteTopicResponse>"
        f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
        "</DeleteTopicResponse>"
    )
    return Response(content=xml, media_type="text/xml")


async def _handle_get_topic_attributes(provider: SnsProvider, params: dict[str, str]) -> Response:
    """Handle the ``GetTopicAttributes`` action."""
    topic_arn = params.get("TopicArn", "")
    topic_name = topic_arn.rsplit(":", 1)[-1] if ":" in topic_arn else topic_arn
    try:
        attrs = await provider.get_topic_attributes(topic_name)
    except KeyError:
        xml = (
            "<ErrorResponse>"
            "<Error>"
            "<Code>NotFound</Code>"
            f"<Message>Topic not found: {topic_arn}</Message>"
            "</Error>"
            f"<RequestId>{uuid.uuid4()}</RequestId>"
            "</ErrorResponse>"
        )
        return Response(content=xml, status_code=404, media_type="text/xml")

    attrs_xml = "".join(
        f"<entry><key>{k}</key><value>{v}</value></entry>" for k, v in attrs.items()
    )
    xml = (
        "<GetTopicAttributesResponse>"
        "<GetTopicAttributesResult>"
        f"<Attributes>{attrs_xml}</Attributes>"
        "</GetTopicAttributesResult>"
        f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
        "</GetTopicAttributesResponse>"
    )
    return Response(content=xml, media_type="text/xml")


async def _handle_list_topics(provider: SnsProvider, _params: dict[str, str]) -> Response:
    """Handle the ``ListTopics`` action."""
    members: list[str] = []
    for topic in provider.list_topics():
        members.append(f"<member><TopicArn>{topic.topic_arn}</TopicArn></member>")

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


async def _handle_set_topic_attributes(provider: SnsProvider, params: dict[str, str]) -> Response:
    """Handle the ``SetTopicAttributes`` action."""
    topic_arn = params.get("TopicArn", "")
    topic_name = topic_arn.rsplit(":", 1)[-1] if ":" in topic_arn else topic_arn
    attr_name = params.get("AttributeName", "")
    attr_value = params.get("AttributeValue", "")
    try:
        await provider.set_topic_attribute(topic_name, attr_name, attr_value)
    except KeyError:
        xml = (
            "<ErrorResponse>"
            "<Error>"
            "<Code>NotFound</Code>"
            f"<Message>Topic not found: {topic_arn}</Message>"
            "</Error>"
            f"<RequestId>{uuid.uuid4()}</RequestId>"
            "</ErrorResponse>"
        )
        return Response(content=xml, status_code=404, media_type="text/xml")

    xml = (
        "<SetTopicAttributesResponse>"
        f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
        "</SetTopicAttributesResponse>"
    )
    return Response(content=xml, media_type="text/xml")


async def _handle_list_tags_for_resource(
    _provider: SnsProvider, _params: dict[str, str]
) -> Response:
    """Handle the ``ListTagsForResource`` action."""
    xml = (
        "<ListTagsForResourceResponse>"
        "<ListTagsForResourceResult>"
        "<Tags/>"
        "</ListTagsForResourceResult>"
        f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
        "</ListTagsForResourceResponse>"
    )
    return Response(content=xml, media_type="text/xml")


async def _handle_tag_resource(_provider: SnsProvider, _params: dict[str, str]) -> Response:
    """Handle the ``TagResource`` action."""
    xml = (
        "<TagResourceResponse>"
        f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
        "</TagResourceResponse>"
    )
    return Response(content=xml, media_type="text/xml")


async def _handle_untag_resource(_provider: SnsProvider, _params: dict[str, str]) -> Response:
    """Handle the ``UntagResource`` action."""
    xml = (
        "<UntagResourceResponse>"
        f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
        "</UntagResourceResponse>"
    )
    return Response(content=xml, media_type="text/xml")


async def _handle_unsubscribe(provider: SnsProvider, params: dict[str, str]) -> Response:
    """Handle the ``Unsubscribe`` action."""
    subscription_arn = params.get("SubscriptionArn", "")
    found = await provider.unsubscribe(subscription_arn)
    if not found:
        xml = (
            "<ErrorResponse>"
            "<Error>"
            "<Code>NotFound</Code>"
            f"<Message>Subscription not found: {subscription_arn}</Message>"
            "</Error>"
            f"<RequestId>{uuid.uuid4()}</RequestId>"
            "</ErrorResponse>"
        )
        return Response(content=xml, status_code=404, media_type="text/xml")

    xml = (
        "<UnsubscribeResponse>"
        f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
        "</UnsubscribeResponse>"
    )
    return Response(content=xml, media_type="text/xml")


async def _handle_get_subscription_attributes(
    provider: SnsProvider, params: dict[str, str]
) -> Response:
    """Handle the ``GetSubscriptionAttributes`` action."""
    subscription_arn = params.get("SubscriptionArn", "")
    try:
        attrs = await provider.get_subscription_attributes(subscription_arn)
    except KeyError:
        xml = (
            "<ErrorResponse>"
            "<Error>"
            "<Code>NotFound</Code>"
            f"<Message>Subscription not found: {subscription_arn}</Message>"
            "</Error>"
            f"<RequestId>{uuid.uuid4()}</RequestId>"
            "</ErrorResponse>"
        )
        return Response(content=xml, status_code=404, media_type="text/xml")

    attrs_xml = "".join(
        f"<entry><key>{k}</key><value>{v}</value></entry>" for k, v in attrs.items()
    )
    xml = (
        "<GetSubscriptionAttributesResponse>"
        "<GetSubscriptionAttributesResult>"
        f"<Attributes>{attrs_xml}</Attributes>"
        "</GetSubscriptionAttributesResult>"
        f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
        "</GetSubscriptionAttributesResponse>"
    )
    return Response(content=xml, media_type="text/xml")


async def _handle_set_subscription_attributes(
    provider: SnsProvider, params: dict[str, str]
) -> Response:
    """Handle the ``SetSubscriptionAttributes`` action."""
    subscription_arn = params.get("SubscriptionArn", "")
    attr_name = params.get("AttributeName", "")
    attr_value = params.get("AttributeValue", "")
    try:
        await provider.set_subscription_attribute(subscription_arn, attr_name, attr_value)
    except KeyError:
        xml = (
            "<ErrorResponse>"
            "<Error>"
            "<Code>NotFound</Code>"
            f"<Message>Subscription not found: {subscription_arn}</Message>"
            "</Error>"
            f"<RequestId>{uuid.uuid4()}</RequestId>"
            "</ErrorResponse>"
        )
        return Response(content=xml, status_code=404, media_type="text/xml")

    xml = (
        "<SetSubscriptionAttributesResponse>"
        f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
        "</SetSubscriptionAttributesResponse>"
    )
    return Response(content=xml, media_type="text/xml")


async def _handle_confirm_subscription(_provider: SnsProvider, params: dict[str, str]) -> Response:
    """Handle the ``ConfirmSubscription`` action.

    This is a stub for local development — subscriptions are auto-confirmed.
    """
    topic_arn = params.get("TopicArn", "")
    subscription_arn = f"{topic_arn}:{uuid.uuid4().hex[:8]}"
    xml = (
        "<ConfirmSubscriptionResponse>"
        "<ConfirmSubscriptionResult>"
        f"<SubscriptionArn>{subscription_arn}</SubscriptionArn>"
        "</ConfirmSubscriptionResult>"
        f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
        "</ConfirmSubscriptionResponse>"
    )
    return Response(content=xml, media_type="text/xml")


async def _handle_list_subscriptions_by_topic(
    provider: SnsProvider, params: dict[str, str]
) -> Response:
    """Handle the ``ListSubscriptionsByTopic`` action."""
    topic_arn = params.get("TopicArn", "")
    topic_name = topic_arn.rsplit(":", 1)[-1] if ":" in topic_arn else topic_arn
    try:
        subscriptions = provider.list_subscriptions_by_topic(topic_name)
    except KeyError:
        xml = (
            "<ErrorResponse>"
            "<Error>"
            "<Code>NotFound</Code>"
            f"<Message>Topic not found: {topic_arn}</Message>"
            "</Error>"
            f"<RequestId>{uuid.uuid4()}</RequestId>"
            "</ErrorResponse>"
        )
        return Response(content=xml, status_code=404, media_type="text/xml")

    members: list[str] = []
    for sub in subscriptions:
        members.append(
            "<member>"
            f"<TopicArn>{topic_arn}</TopicArn>"
            f"<Protocol>{sub.protocol}</Protocol>"
            f"<SubscriptionArn>{sub.subscription_arn}</SubscriptionArn>"
            f"<Endpoint>{sub.endpoint}</Endpoint>"
            "</member>"
        )

    xml = (
        "<ListSubscriptionsByTopicResponse>"
        "<ListSubscriptionsByTopicResult>"
        f"<Subscriptions>{''.join(members)}</Subscriptions>"
        "</ListSubscriptionsByTopicResult>"
        f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
        "</ListSubscriptionsByTopicResponse>"
    )
    return Response(content=xml, media_type="text/xml")


_ACTION_HANDLERS = {
    "Publish": _handle_publish,
    "Subscribe": _handle_subscribe,
    "ListSubscriptions": _handle_list_subscriptions,
    "CreateTopic": _handle_create_topic,
    "DeleteTopic": _handle_delete_topic,
    "GetTopicAttributes": _handle_get_topic_attributes,
    "SetTopicAttributes": _handle_set_topic_attributes,
    "ListTopics": _handle_list_topics,
    "ListTagsForResource": _handle_list_tags_for_resource,
    "TagResource": _handle_tag_resource,
    "UntagResource": _handle_untag_resource,
    "Unsubscribe": _handle_unsubscribe,
    "GetSubscriptionAttributes": _handle_get_subscription_attributes,
    "SetSubscriptionAttributes": _handle_set_subscription_attributes,
    "ConfirmSubscription": _handle_confirm_subscription,
    "ListSubscriptionsByTopic": _handle_list_subscriptions_by_topic,
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
            _logger.warning("Unknown SNS action: %s", action)
            xml = (
                "<ErrorResponse>"
                "<Error>"
                "<Type>Sender</Type>"
                "<Code>InvalidAction</Code>"
                f"<Message>lws: SNS operation '{action}' is not yet implemented</Message>"
                "</Error>"
                f"<RequestId>{uuid.uuid4()}</RequestId>"
                "</ErrorResponse>"
            )
            return Response(content=xml, status_code=400, media_type="text/xml")

        return await handler(provider, params)

    return app
