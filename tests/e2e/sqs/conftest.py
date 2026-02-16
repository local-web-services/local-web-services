"""Shared fixtures for sqs E2E tests."""

from __future__ import annotations

from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


# ── Step definitions ──────────────────────────────────────────────────


@given(
    parsers.parse('a message was received from queue "{queue_name}"'),
    target_fixture="received_message",
)
def a_message_was_received(queue_name, lws_invoke, e2e_port):
    recv_output = lws_invoke(
        [
            "sqs",
            "receive-message",
            "--queue-name",
            queue_name,
            "--port",
            str(e2e_port),
        ]
    )
    receipt_handle = (
        recv_output.get("ReceiveMessageResponse", {})
        .get("ReceiveMessageResult", {})
        .get("Message", {})
        .get("ReceiptHandle", "")
    )
    return {"queue_name": queue_name, "receipt_handle": receipt_handle}


@given(
    parsers.parse('a message "{body}" was sent to queue "{queue_name}"'),
    target_fixture="given_message",
)
def a_message_was_sent(body, queue_name, lws_invoke, e2e_port):
    lws_invoke(
        [
            "sqs",
            "send-message",
            "--queue-name",
            queue_name,
            "--message-body",
            body,
            "--port",
            str(e2e_port),
        ]
    )
    return {"queue_name": queue_name, "body": body}


@given(
    parsers.parse('a queue "{queue_name}" was created'),
    target_fixture="given_queue",
)
def a_queue_was_created(queue_name, lws_invoke, e2e_port):
    lws_invoke(
        [
            "sqs",
            "create-queue",
            "--queue-name",
            queue_name,
            "--port",
            str(e2e_port),
        ]
    )
    return {"queue_name": queue_name}


@when(
    parsers.parse(
        'I change the visibility timeout to "{timeout}" for the received message'
        ' in queue "{queue_name}"'
    ),
    target_fixture="command_result",
)
def i_change_message_visibility(timeout, queue_name, received_message, e2e_port):
    return runner.invoke(
        app,
        [
            "sqs",
            "change-message-visibility",
            "--queue-name",
            queue_name,
            "--receipt-handle",
            received_message["receipt_handle"],
            "--visibility-timeout",
            timeout,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse(
        'I change message visibility in batch with timeout "{timeout}"'
        ' for the received message in queue "{queue_name}"'
    ),
    target_fixture="command_result",
)
def i_change_message_visibility_batch(timeout, queue_name, received_message, e2e_port):
    entries_json = (
        '[{"Id":"1","ReceiptHandle":"'
        + received_message["receipt_handle"]
        + '","VisibilityTimeout":'
        + timeout
        + "}]"
    )
    return runner.invoke(
        app,
        [
            "sqs",
            "change-message-visibility-batch",
            "--queue-name",
            queue_name,
            "--entries",
            entries_json,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I create a queue named "{queue_name}"'),
    target_fixture="command_result",
)
def i_create_a_queue(queue_name, e2e_port):
    return runner.invoke(
        app,
        [
            "sqs",
            "create-queue",
            "--queue-name",
            queue_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete messages in batch for the received message in queue "{queue_name}"'),
    target_fixture="command_result",
)
def i_delete_message_batch(queue_name, received_message, e2e_port):
    entries_json = '[{"Id":"1","ReceiptHandle":"' + received_message["receipt_handle"] + '"}]'
    return runner.invoke(
        app,
        [
            "sqs",
            "delete-message-batch",
            "--queue-name",
            queue_name,
            "--entries",
            entries_json,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete the queue "{queue_name}"'),
    target_fixture="command_result",
)
def i_delete_the_queue(queue_name, e2e_port):
    return runner.invoke(
        app,
        [
            "sqs",
            "delete-queue",
            "--queue-name",
            queue_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete the received message from queue "{queue_name}"'),
    target_fixture="command_result",
)
def i_delete_the_received_message(queue_name, received_message, e2e_port):
    return runner.invoke(
        app,
        [
            "sqs",
            "delete-message",
            "--queue-name",
            queue_name,
            "--receipt-handle",
            received_message["receipt_handle"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I get queue attributes for "{queue_name}"'),
    target_fixture="command_result",
)
def i_get_queue_attributes(queue_name, e2e_port):
    return runner.invoke(
        app,
        [
            "sqs",
            "get-queue-attributes",
            "--queue-name",
            queue_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I get the queue URL for "{queue_name}"'),
    target_fixture="command_result",
)
def i_get_the_queue_url(queue_name, e2e_port):
    return runner.invoke(
        app,
        [
            "sqs",
            "get-queue-url",
            "--queue-name",
            queue_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I list dead letter source queues for "{queue_name}"'),
    target_fixture="command_result",
)
def i_list_dead_letter_source_queues(queue_name, e2e_port):
    return runner.invoke(
        app,
        [
            "sqs",
            "list-dead-letter-source-queues",
            "--queue-name",
            queue_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I list queue tags for "{queue_name}"'),
    target_fixture="command_result",
)
def i_list_queue_tags(queue_name, e2e_port):
    return runner.invoke(
        app,
        [
            "sqs",
            "list-queue-tags",
            "--queue-name",
            queue_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse("I list queues"),
    target_fixture="command_result",
)
def i_list_queues(e2e_port):
    return runner.invoke(
        app,
        [
            "sqs",
            "list-queues",
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I purge queue "{queue_name}"'),
    target_fixture="command_result",
)
def i_purge_queue(queue_name, e2e_port):
    return runner.invoke(
        app,
        [
            "sqs",
            "purge-queue",
            "--queue-name",
            queue_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I receive a message from queue "{queue_name}"'),
    target_fixture="command_result",
)
def i_receive_a_message(queue_name, e2e_port):
    return runner.invoke(
        app,
        [
            "sqs",
            "receive-message",
            "--queue-name",
            queue_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I send a message "{body}" to queue "{queue_name}"'),
    target_fixture="command_result",
)
def i_send_a_message(body, queue_name, e2e_port):
    return runner.invoke(
        app,
        [
            "sqs",
            "send-message",
            "--queue-name",
            queue_name,
            "--message-body",
            body,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse(
        "I send a message batch with entries '{entries_json}'" ' to queue "{queue_name}"'
    ),
    target_fixture="command_result",
)
def i_send_message_batch(entries_json, queue_name, e2e_port):
    return runner.invoke(
        app,
        [
            "sqs",
            "send-message-batch",
            "--queue-name",
            queue_name,
            "--entries",
            entries_json,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse("I set queue attributes '{attributes_json}'" ' on queue "{queue_name}"'),
    target_fixture="command_result",
)
def i_set_queue_attributes(attributes_json, queue_name, e2e_port):
    return runner.invoke(
        app,
        [
            "sqs",
            "set-queue-attributes",
            "--queue-name",
            queue_name,
            "--attributes",
            attributes_json,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse("I tag queue \"{queue_name}\" with tags '{tags_json}'"),
    target_fixture="command_result",
)
def i_tag_queue(queue_name, tags_json, e2e_port):
    return runner.invoke(
        app,
        [
            "sqs",
            "tag-queue",
            "--queue-name",
            queue_name,
            "--tags",
            tags_json,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse("I untag queue \"{queue_name}\" with tag keys '{keys_json}'"),
    target_fixture="command_result",
)
def i_untag_queue(queue_name, keys_json, e2e_port):
    return runner.invoke(
        app,
        [
            "sqs",
            "untag-queue",
            "--queue-name",
            queue_name,
            "--tag-keys",
            keys_json,
            "--port",
            str(e2e_port),
        ],
    )


@given(
    parsers.parse("queue \"{queue_name}\" was tagged with '{tags_json}'"),
)
def queue_was_tagged(queue_name, tags_json, lws_invoke, e2e_port):
    lws_invoke(
        [
            "sqs",
            "tag-queue",
            "--queue-name",
            queue_name,
            "--tags",
            tags_json,
            "--port",
            str(e2e_port),
        ]
    )


@then(
    parsers.parse('queue "{queue_name}" will contain a message with body "{expected_body}"'),
)
def queue_will_contain_message(queue_name, expected_body, assert_invoke, e2e_port):
    verify = assert_invoke(
        ["sqs", "receive-message", "--queue-name", queue_name, "--port", str(e2e_port)]
    )
    actual_body = (
        verify.get("ReceiveMessageResponse", {})
        .get("ReceiveMessageResult", {})
        .get("Message", {})
        .get("Body")
    )
    assert actual_body == expected_body


@then(
    parsers.parse('queue "{queue_name}" will have approximate message count "{expected_count}"'),
)
def queue_will_have_message_count(queue_name, expected_count, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "sqs",
            "get-queue-attributes",
            "--queue-name",
            queue_name,
            "--port",
            str(e2e_port),
        ]
    )
    attrs = (
        verify.get("GetQueueAttributesResponse", {})
        .get("GetQueueAttributesResult", {})
        .get("Attribute", [])
    )
    if isinstance(attrs, dict):
        attrs = [attrs]
    actual_count = next(
        (a["Value"] for a in attrs if a.get("Name") == "ApproximateNumberOfMessages"),
        None,
    )
    assert actual_count == expected_count


@then(
    parsers.parse('the output will contain "{expected_key}"'),
)
def the_output_will_contain_key(expected_key, command_result, parse_output):
    data = parse_output(command_result.output)
    assert expected_key in data


@then(
    parsers.parse('the output will contain a message with body "{expected_body}"'),
)
def the_output_will_contain_message(expected_body, command_result, parse_output):
    actual_body = (
        parse_output(command_result.output)
        .get("ReceiveMessageResponse", {})
        .get("ReceiveMessageResult", {})
        .get("Message", {})
        .get("Body")
    )
    assert actual_body == expected_body


@then(
    parsers.parse('the output will contain queue "{queue_name}"'),
)
def the_output_will_contain_queue(queue_name, command_result, parse_output):
    data = parse_output(command_result.output)
    urls = data.get("ListQueuesResponse", {}).get("ListQueuesResult", {}).get("QueueUrl", [])
    if isinstance(urls, str):
        urls = [urls]
    assert any(queue_name in u for u in urls)


@then(
    parsers.parse('the queue "{queue_name}" will appear in the queue list'),
)
def the_queue_will_appear(queue_name, assert_invoke, e2e_port):
    data = assert_invoke(["sqs", "list-queues", "--port", str(e2e_port)])
    urls = data.get("ListQueuesResponse", {}).get("ListQueuesResult", {}).get("QueueUrl", [])
    if isinstance(urls, str):
        urls = [urls]
    assert any(queue_name in u for u in urls)


@then(
    parsers.parse('the queue "{queue_name}" will not appear in the queue list'),
)
def the_queue_will_not_appear(queue_name, assert_invoke, e2e_port):
    data = assert_invoke(["sqs", "list-queues", "--port", str(e2e_port)])
    urls = data.get("ListQueuesResponse", {}).get("ListQueuesResult", {}).get("QueueUrl", [])
    if isinstance(urls, str):
        urls = [urls]
    assert not any(queue_name in u for u in urls)
