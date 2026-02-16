"""Shared fixtures for sns E2E tests."""

from __future__ import annotations

from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


def _extract_topic_arn(data: dict, topic_name: str) -> str:
    default_arn = f"arn:aws:sns:us-east-1:000000000000:{topic_name}"
    return (
        data.get("CreateTopicResponse", {})
        .get("CreateTopicResult", {})
        .get("TopicArn", default_arn)
    )


def _extract_subscription_arn(data: dict) -> str:
    return data.get("SubscribeResponse", {}).get("SubscribeResult", {}).get("SubscriptionArn", "")


# Topic ARN registry keyed by topic name, populated by given steps.
_topic_arns: dict[str, str] = {}
# Subscription ARN registry keyed by topic name, populated by given steps.
_subscription_arns: dict[str, str] = {}


# ── Step definitions ──────────────────────────────────────────────────


@given(
    parsers.parse('a topic "{topic_name}" was created'),
    target_fixture="given_topic",
)
def a_topic_was_created(topic_name, lws_invoke, e2e_port):
    data = lws_invoke(["sns", "create-topic", "--name", topic_name, "--port", str(e2e_port)])
    topic_arn = _extract_topic_arn(data, topic_name)
    _topic_arns[topic_name] = topic_arn
    return {"topic_name": topic_name, "topic_arn": topic_arn}


@given(
    parsers.parse('an SQS subscription to "{endpoint}" was added to topic "{topic_name}"'),
    target_fixture="given_subscription",
)
def an_sqs_subscription_was_added(endpoint, topic_name, lws_invoke, e2e_port):
    topic_arn = _topic_arns[topic_name]
    sub_data = lws_invoke(
        [
            "sns",
            "subscribe",
            "--topic-arn",
            topic_arn,
            "--protocol",
            "sqs",
            "--notification-endpoint",
            endpoint,
            "--port",
            str(e2e_port),
        ]
    )
    subscription_arn = _extract_subscription_arn(sub_data)
    _subscription_arns[topic_name] = subscription_arn
    return {"subscription_arn": subscription_arn, "topic_arn": topic_arn}


@when(
    parsers.parse('I confirm subscription for topic "{topic_name}" with token "{token}"'),
    target_fixture="command_result",
)
def i_confirm_subscription(topic_name, token, e2e_port):
    topic_arn = _topic_arns[topic_name]
    return runner.invoke(
        app,
        [
            "sns",
            "confirm-subscription",
            "--topic-arn",
            topic_arn,
            "--token",
            token,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I create topic "{topic_name}"'),
    target_fixture="command_result",
)
def i_create_topic(topic_name, e2e_port):
    return runner.invoke(
        app,
        ["sns", "create-topic", "--name", topic_name, "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I delete the topic "{topic_name}"'),
    target_fixture="command_result",
)
def i_delete_topic(topic_name, e2e_port):
    topic_arn = _topic_arns[topic_name]
    return runner.invoke(
        app,
        ["sns", "delete-topic", "--topic-arn", topic_arn, "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I get subscription attributes for the subscription on topic "{topic_name}"'),
    target_fixture="command_result",
)
def i_get_subscription_attributes(topic_name, e2e_port):
    subscription_arn = _subscription_arns[topic_name]
    return runner.invoke(
        app,
        [
            "sns",
            "get-subscription-attributes",
            "--subscription-arn",
            subscription_arn,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I get topic attributes for topic "{topic_name}"'),
    target_fixture="command_result",
)
def i_get_topic_attributes(topic_name, e2e_port):
    topic_arn = _topic_arns[topic_name]
    return runner.invoke(
        app,
        [
            "sns",
            "get-topic-attributes",
            "--topic-arn",
            topic_arn,
            "--port",
            str(e2e_port),
        ],
    )


@when("I list subscriptions", target_fixture="command_result")
def i_list_subscriptions(e2e_port):
    return runner.invoke(
        app,
        ["sns", "list-subscriptions", "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I list subscriptions by topic "{topic_name}"'),
    target_fixture="command_result",
)
def i_list_subscriptions_by_topic(topic_name, e2e_port):
    topic_arn = _topic_arns[topic_name]
    return runner.invoke(
        app,
        [
            "sns",
            "list-subscriptions-by-topic",
            "--topic-arn",
            topic_arn,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I list tags for resource "{topic_name}"'),
    target_fixture="command_result",
)
def i_list_tags_for_resource(topic_name, e2e_port):
    topic_arn = _topic_arns[topic_name]
    return runner.invoke(
        app,
        [
            "sns",
            "list-tags-for-resource",
            "--resource-arn",
            topic_arn,
            "--port",
            str(e2e_port),
        ],
    )


@when("I list topics", target_fixture="command_result")
def i_list_topics(e2e_port):
    return runner.invoke(
        app,
        ["sns", "list-topics", "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I publish message "{message}" to topic "{topic_name}"'),
    target_fixture="command_result",
)
def i_publish_message(message, topic_name, e2e_port):
    return runner.invoke(
        app,
        [
            "sns",
            "publish",
            "--topic-name",
            topic_name,
            "--message",
            message,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse(
        'I set subscription attribute "{attr_name}" to "{attr_value}"'
        ' for the subscription on topic "{topic_name}"'
    ),
    target_fixture="command_result",
)
def i_set_subscription_attributes(attr_name, attr_value, topic_name, e2e_port):
    subscription_arn = _subscription_arns[topic_name]
    return runner.invoke(
        app,
        [
            "sns",
            "set-subscription-attributes",
            "--subscription-arn",
            subscription_arn,
            "--attribute-name",
            attr_name,
            "--attribute-value",
            attr_value,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I set topic attribute "{attr_name}" to "{attr_value}" for topic "{topic_name}"'),
    target_fixture="command_result",
)
def i_set_topic_attributes(attr_name, attr_value, topic_name, e2e_port):
    topic_arn = _topic_arns[topic_name]
    return runner.invoke(
        app,
        [
            "sns",
            "set-topic-attributes",
            "--topic-arn",
            topic_arn,
            "--attribute-name",
            attr_name,
            "--attribute-value",
            attr_value,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse(
        'I subscribe "{endpoint}" with protocol "{protocol}" to the topic "{topic_name}"'
    ),
    target_fixture="command_result",
)
def i_subscribe(endpoint, protocol, topic_name, e2e_port):
    topic_arn = _topic_arns[topic_name]
    return runner.invoke(
        app,
        [
            "sns",
            "subscribe",
            "--topic-arn",
            topic_arn,
            "--protocol",
            protocol,
            "--notification-endpoint",
            endpoint,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse("I tag resource \"{topic_name}\" with tags '{tags_json}'"),
    target_fixture="command_result",
)
def i_tag_resource(topic_name, tags_json, e2e_port):
    topic_arn = _topic_arns[topic_name]
    return runner.invoke(
        app,
        [
            "sns",
            "tag-resource",
            "--resource-arn",
            topic_arn,
            "--tags",
            tags_json,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I unsubscribe the subscription on topic "{topic_name}"'),
    target_fixture="command_result",
)
def i_unsubscribe(topic_name, e2e_port):
    subscription_arn = _subscription_arns[topic_name]
    return runner.invoke(
        app,
        [
            "sns",
            "unsubscribe",
            "--subscription-arn",
            subscription_arn,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse("I untag resource \"{topic_name}\" with tag keys '{keys_json}'"),
    target_fixture="command_result",
)
def i_untag_resource(topic_name, keys_json, e2e_port):
    topic_arn = _topic_arns[topic_name]
    return runner.invoke(
        app,
        [
            "sns",
            "untag-resource",
            "--resource-arn",
            topic_arn,
            "--tag-keys",
            keys_json,
            "--port",
            str(e2e_port),
        ],
    )


@given(
    parsers.parse("tags '{tags_json}' were added to topic \"{topic_name}\""),
)
def tags_were_added_to_topic(tags_json, topic_name, lws_invoke, e2e_port):
    topic_arn = _topic_arns[topic_name]
    lws_invoke(
        [
            "sns",
            "tag-resource",
            "--resource-arn",
            topic_arn,
            "--tags",
            tags_json,
            "--port",
            str(e2e_port),
        ]
    )


@then("the output will contain a ListSubscriptionsResponse")
def the_output_will_contain_list_subscriptions_response(command_result, parse_output):
    data = parse_output(command_result.output)
    assert "ListSubscriptionsResponse" in data


@then("the output will contain a PublishResponse")
def the_output_will_contain_publish_response(command_result, parse_output):
    data = parse_output(command_result.output)
    assert "PublishResponse" in data


@then(
    parsers.parse('the topic "{topic_name}" will appear in the topic list'),
)
def the_topic_will_appear(topic_name, assert_invoke, e2e_port):
    data = assert_invoke(["sns", "list-topics", "--port", str(e2e_port)])
    topics = (
        data.get("ListTopicsResponse", {})
        .get("ListTopicsResult", {})
        .get("Topics", {})
        .get("member", [])
    )
    if isinstance(topics, dict):
        topics = [topics]
    actual_arns = [t.get("TopicArn", "") for t in topics]
    assert any(topic_name in a for a in actual_arns)


@then(
    parsers.parse('the topic "{topic_name}" will have a subscription in the subscription list'),
)
def the_topic_will_have_subscription(topic_name, assert_invoke, e2e_port):
    topic_arn = _topic_arns[topic_name]
    data = assert_invoke(["sns", "list-subscriptions", "--port", str(e2e_port)])
    subs = (
        data.get("ListSubscriptionsResponse", {})
        .get("ListSubscriptionsResult", {})
        .get("Subscriptions", {})
        .get("member", [])
    )
    if isinstance(subs, dict):
        subs = [subs]
    actual_topic_arns = [s.get("TopicArn", "") for s in subs]
    assert topic_arn in actual_topic_arns


@then(
    parsers.parse('the topic "{topic_name}" will not appear in the topic list'),
)
def the_topic_will_not_appear(topic_name, assert_invoke, e2e_port):
    data = assert_invoke(["sns", "list-topics", "--port", str(e2e_port)])
    topics = (
        data.get("ListTopicsResponse", {})
        .get("ListTopicsResult", {})
        .get("Topics", {})
        .get("member", [])
    )
    if isinstance(topics, dict):
        topics = [topics]
    actual_arns = [t.get("TopicArn", "") for t in topics]
    assert not any(topic_name in a for a in actual_arns)
