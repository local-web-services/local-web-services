"""Shared fixtures for events E2E tests."""

from __future__ import annotations

import json

from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


# ── Step definitions ──────────────────────────────────────────────────


@given(
    parsers.parse('a rule "{name}" was created on event bus "{bus_name}"'),
    target_fixture="given_rule",
)
def a_rule_was_created(name, bus_name, lws_invoke, e2e_port):
    pattern = json.dumps({"source": ["e2e.test"]})
    lws_invoke(
        [
            "events",
            "put-rule",
            "--name",
            name,
            "--event-bus-name",
            bus_name,
            "--event-pattern",
            pattern,
            "--port",
            str(e2e_port),
        ]
    )
    return {"name": name, "bus_name": bus_name}


@given(
    parsers.parse('an event bus "{name}" was created'),
    target_fixture="given_event_bus",
)
def an_event_bus_was_created(name, lws_invoke, e2e_port):
    lws_invoke(["events", "create-event-bus", "--name", name, "--port", str(e2e_port)])
    return {"name": name}


@then(
    parsers.parse('event bus "{name}" will appear in list-event-buses'),
)
def event_bus_will_appear(name, assert_invoke, e2e_port):
    verify = assert_invoke(["events", "list-event-buses", "--port", str(e2e_port)])
    actual_names = [b["Name"] for b in verify.get("EventBuses", [])]
    assert name in actual_names


@then(
    parsers.parse('event bus "{name}" will not appear in list-event-buses'),
)
def event_bus_will_not_appear(name, assert_invoke, e2e_port):
    verify = assert_invoke(["events", "list-event-buses", "--port", str(e2e_port)])
    actual_names = [b["Name"] for b in verify.get("EventBuses", [])]
    assert name not in actual_names


@when(
    parsers.parse('I create event bus "{name}"'),
    target_fixture="command_result",
)
def i_create_event_bus(name, e2e_port):
    return runner.invoke(
        app,
        ["events", "create-event-bus", "--name", name, "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I delete event bus "{name}"'),
    target_fixture="command_result",
)
def i_delete_event_bus(name, e2e_port):
    return runner.invoke(
        app,
        ["events", "delete-event-bus", "--name", name, "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I delete rule "{name}"'),
    target_fixture="command_result",
)
def i_delete_rule(name, e2e_port):
    return runner.invoke(
        app,
        ["events", "delete-rule", "--name", name, "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I describe event bus "{name}"'),
    target_fixture="command_result",
)
def i_describe_event_bus(name, e2e_port):
    return runner.invoke(
        app,
        ["events", "describe-event-bus", "--name", name, "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I describe rule "{name}" on event bus "{bus_name}"'),
    target_fixture="command_result",
)
def i_describe_rule(name, bus_name, e2e_port):
    return runner.invoke(
        app,
        [
            "events",
            "describe-rule",
            "--name",
            name,
            "--event-bus-name",
            bus_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I disable rule "{name}" on event bus "{bus_name}"'),
    target_fixture="command_result",
)
def i_disable_rule(name, bus_name, e2e_port):
    return runner.invoke(
        app,
        [
            "events",
            "disable-rule",
            "--name",
            name,
            "--event-bus-name",
            bus_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I enable rule "{name}" on event bus "{bus_name}"'),
    target_fixture="command_result",
)
def i_enable_rule(name, bus_name, e2e_port):
    return runner.invoke(
        app,
        [
            "events",
            "enable-rule",
            "--name",
            name,
            "--event-bus-name",
            bus_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I list event buses",
    target_fixture="command_result",
)
def i_list_event_buses(e2e_port):
    return runner.invoke(
        app,
        ["events", "list-event-buses", "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I list rules on event bus "{bus_name}"'),
    target_fixture="command_result",
)
def i_list_rules(bus_name, e2e_port):
    return runner.invoke(
        app,
        [
            "events",
            "list-rules",
            "--event-bus-name",
            bus_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I list tags for resource "{arn}"'),
    target_fixture="command_result",
)
def i_list_tags_for_resource(arn, e2e_port):
    return runner.invoke(
        app,
        [
            "events",
            "list-tags-for-resource",
            "--resource-arn",
            arn,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I list targets by rule "{name}" on event bus "{bus_name}"'),
    target_fixture="command_result",
)
def i_list_targets_by_rule(name, bus_name, e2e_port):
    return runner.invoke(
        app,
        [
            "events",
            "list-targets-by-rule",
            "--rule",
            name,
            "--event-bus-name",
            bus_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I put events to the default bus",
    target_fixture="command_result",
)
def i_put_events(e2e_port):
    entries = json.dumps(
        [
            {
                "Source": "e2e.test",
                "DetailType": "TestEvent",
                "Detail": '{"key": "value"}',
                "EventBusName": "default",
            }
        ]
    )
    return runner.invoke(
        app,
        ["events", "put-events", "--entries", entries, "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I put rule "{name}" on event bus "{bus_name}"'),
    target_fixture="command_result",
)
def i_put_rule(name, bus_name, e2e_port):
    pattern = json.dumps({"source": ["e2e.test"]})
    return runner.invoke(
        app,
        [
            "events",
            "put-rule",
            "--name",
            name,
            "--event-bus-name",
            bus_name,
            "--event-pattern",
            pattern,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I put targets on rule "{name}" on event bus "{bus_name}"'),
    target_fixture="command_result",
)
def i_put_targets(name, bus_name, e2e_port):
    targets = json.dumps([{"Id": "t1", "Arn": "arn:aws:lambda:us-east-1:000000000000:function:fn"}])
    return runner.invoke(
        app,
        [
            "events",
            "put-targets",
            "--rule",
            name,
            "--targets",
            targets,
            "--event-bus-name",
            bus_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I remove targets from rule "{name}" on event bus "{bus_name}"'),
    target_fixture="command_result",
)
def i_remove_targets(name, bus_name, e2e_port):
    ids = json.dumps(["t1"])
    return runner.invoke(
        app,
        [
            "events",
            "remove-targets",
            "--rule",
            name,
            "--ids",
            ids,
            "--event-bus-name",
            bus_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I tag resource "{arn}"'),
    target_fixture="command_result",
)
def i_tag_resource(arn, e2e_port):
    tags = json.dumps([{"Key": "env", "Value": "test"}])
    return runner.invoke(
        app,
        [
            "events",
            "tag-resource",
            "--resource-arn",
            arn,
            "--tags",
            tags,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I untag resource "{arn}"'),
    target_fixture="command_result",
)
def i_untag_resource(arn, e2e_port):
    tag_keys = json.dumps(["env"])
    return runner.invoke(
        app,
        [
            "events",
            "untag-resource",
            "--resource-arn",
            arn,
            "--tag-keys",
            tag_keys,
            "--port",
            str(e2e_port),
        ],
    )


@given(
    parsers.parse('resource "{arn}" was tagged'),
)
def resource_was_tagged(arn, lws_invoke, e2e_port):
    tags = json.dumps([{"Key": "env", "Value": "test"}])
    lws_invoke(
        [
            "events",
            "tag-resource",
            "--resource-arn",
            arn,
            "--tags",
            tags,
            "--port",
            str(e2e_port),
        ]
    )


@then(
    parsers.parse('rule "{name}" will appear in list-rules on event bus "{bus_name}"'),
)
def rule_will_appear(name, bus_name, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "events",
            "list-rules",
            "--event-bus-name",
            bus_name,
            "--port",
            str(e2e_port),
        ]
    )
    actual_names = [r["Name"] for r in verify.get("Rules", [])]
    assert name in actual_names


@then(
    parsers.parse('rule "{name}" will not appear in list-rules on event bus "{bus_name}"'),
)
def rule_will_not_appear(name, bus_name, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "events",
            "list-rules",
            "--event-bus-name",
            bus_name,
            "--port",
            str(e2e_port),
        ]
    )
    actual_names = [r["Name"] for r in verify.get("Rules", [])]
    assert name not in actual_names


@given(
    parsers.parse('targets were added to rule "{name}" on event bus "{bus_name}"'),
)
def targets_were_added_to_rule(name, bus_name, lws_invoke, e2e_port):
    targets = json.dumps([{"Id": "t1", "Arn": "arn:aws:lambda:us-east-1:000000000000:function:fn"}])
    lws_invoke(
        [
            "events",
            "put-targets",
            "--rule",
            name,
            "--targets",
            targets,
            "--event-bus-name",
            bus_name,
            "--port",
            str(e2e_port),
        ]
    )


@then("the failed entry count will be 0")
def the_failed_entry_count_will_be_zero(command_result, parse_output):
    actual_failed = parse_output(command_result.output).get("FailedEntryCount", -1)
    assert actual_failed == 0


@then(
    parsers.parse('the output will contain event bus "{name}"'),
)
def the_output_will_contain_event_bus(name, command_result, parse_output):
    actual_names = [b["Name"] for b in parse_output(command_result.output).get("EventBuses", [])]
    assert name in actual_names


@then("the output will contain a Rules key")
def the_output_will_contain_rules_key(command_result, parse_output):
    assert "Rules" in parse_output(command_result.output)


@then(
    parsers.parse('rule "{name}" will have a target in list-targets-by-rule'),
)
def rule_will_have_target(name, given_rule, assert_invoke, e2e_port):
    bus_name = given_rule["bus_name"]
    verify = assert_invoke(
        [
            "events",
            "list-targets-by-rule",
            "--rule",
            name,
            "--event-bus-name",
            bus_name,
            "--port",
            str(e2e_port),
        ]
    )
    targets = verify.get("Targets", [])
    assert len(targets) > 0


@then(
    parsers.parse('rule "{name}" will have no targets'),
)
def rule_will_have_no_targets(name, given_rule, assert_invoke, e2e_port):
    bus_name = given_rule["bus_name"]
    verify = assert_invoke(
        [
            "events",
            "list-targets-by-rule",
            "--rule",
            name,
            "--event-bus-name",
            bus_name,
            "--port",
            str(e2e_port),
        ]
    )
    targets = verify.get("Targets", [])
    assert len(targets) == 0


@then(
    parsers.parse('rule "{name}" will have state "{expected_state}"'),
)
def rule_will_have_state(name, expected_state, given_rule, assert_invoke, e2e_port):
    bus_name = given_rule["bus_name"]
    verify = assert_invoke(
        [
            "events",
            "describe-rule",
            "--name",
            name,
            "--event-bus-name",
            bus_name,
            "--port",
            str(e2e_port),
        ]
    )
    actual_state = verify["State"]
    assert actual_state == expected_state


@then(
    parsers.parse('event bus "{name}" will have tag "{key}" with value "{value}"'),
)
def event_bus_will_have_tag(name, key, value, assert_invoke, e2e_port):
    arn = f"arn:aws:events:us-east-1:000000000000:event-bus/{name}"
    verify = assert_invoke(
        [
            "events",
            "list-tags-for-resource",
            "--resource-arn",
            arn,
            "--port",
            str(e2e_port),
        ]
    )
    tags = verify.get("Tags", [])
    actual_value = next(
        (t["Value"] for t in tags if t.get("Key") == key),
        None,
    )
    assert actual_value == value


@then(
    parsers.parse('event bus "{name}" will not have tag "{key}"'),
)
def event_bus_will_not_have_tag(name, key, assert_invoke, e2e_port):
    arn = f"arn:aws:events:us-east-1:000000000000:event-bus/{name}"
    verify = assert_invoke(
        [
            "events",
            "list-tags-for-resource",
            "--resource-arn",
            arn,
            "--port",
            str(e2e_port),
        ]
    )
    tags = verify.get("Tags", [])
    actual_keys = [t["Key"] for t in tags]
    assert key not in actual_keys
