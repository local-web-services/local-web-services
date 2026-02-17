"""Shared fixtures for dynamodb E2E tests."""

from __future__ import annotations

import json

from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


# ── Step definitions ──────────────────────────────────────────────────


@given(
    parsers.parse('a table "{table_name}" was created'),
    target_fixture="given_table",
)
def a_table_was_created(table_name, lws_invoke, e2e_port):
    lws_invoke(
        [
            "dynamodb",
            "create-table",
            "--table-name",
            table_name,
            "--key-schema",
            '[{"AttributeName":"pk","KeyType":"HASH"}]',
            "--attribute-definitions",
            '[{"AttributeName":"pk","AttributeType":"S"}]',
            "--port",
            str(e2e_port),
        ]
    )
    return {"table_name": table_name}


@given(
    parsers.re(r'an item was put with key "(?P<key>[^"]+)" into table "(?P<table_name>[^"]+)"'),
)
def an_item_was_put(key, table_name, lws_invoke, e2e_port):
    lws_invoke(
        [
            "dynamodb",
            "put-item",
            "--table-name",
            table_name,
            "--item",
            json.dumps({"pk": {"S": key}}),
            "--port",
            str(e2e_port),
        ]
    )


@given(
    parsers.re(
        r'an item was put with key "(?P<key>[^"]+)"'
        r' and data "(?P<data>[^"]+)"'
        r' into table "(?P<table_name>[^"]+)"'
    ),
)
def an_item_was_put_with_data(key, data, table_name, lws_invoke, e2e_port):
    lws_invoke(
        [
            "dynamodb",
            "put-item",
            "--table-name",
            table_name,
            "--item",
            json.dumps({"pk": {"S": key}, "data": {"S": data}}),
            "--port",
            str(e2e_port),
        ]
    )


@given(
    parsers.re(
        r'an item was put with key "(?P<key>[^"]+)"'
        r' and status "(?P<status>[^"]+)"'
        r' into table "(?P<table_name>[^"]+)"'
    ),
)
def an_item_was_put_with_status(key, status, table_name, lws_invoke, e2e_port):
    lws_invoke(
        [
            "dynamodb",
            "put-item",
            "--table-name",
            table_name,
            "--item",
            json.dumps({"pk": {"S": key}, "status": {"S": status}}),
            "--port",
            str(e2e_port),
        ]
    )


@when(
    parsers.parse('I batch get item with key "{key}" from table "{table_name}"'),
    target_fixture="command_result",
)
def i_batch_get_item(key, table_name, e2e_port):
    request_items = json.dumps({table_name: {"Keys": [{"pk": {"S": key}}]}})
    return runner.invoke(
        app,
        [
            "dynamodb",
            "batch-get-item",
            "--request-items",
            request_items,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I batch write items with keys "{key1}" and "{key2}" into table "{table_name}"'),
    target_fixture="command_result",
)
def i_batch_write_items(key1, key2, table_name, e2e_port):
    request_items = json.dumps(
        {
            table_name: [
                {"PutRequest": {"Item": {"pk": {"S": key1}, "data": {"S": "val1"}}}},
                {"PutRequest": {"Item": {"pk": {"S": key2}, "data": {"S": "val2"}}}},
            ]
        }
    )
    return runner.invoke(
        app,
        [
            "dynamodb",
            "batch-write-item",
            "--request-items",
            request_items,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I create a table "{table_name}"'),
    target_fixture="command_result",
)
def i_create_a_table(table_name, e2e_port):
    return runner.invoke(
        app,
        [
            "dynamodb",
            "create-table",
            "--table-name",
            table_name,
            "--key-schema",
            '[{"AttributeName":"pk","KeyType":"HASH"}]',
            "--attribute-definitions",
            '[{"AttributeName":"pk","AttributeType":"S"}]',
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete item with key "{key}" from table "{table_name}"'),
    target_fixture="command_result",
)
def i_delete_item(key, table_name, e2e_port):
    return runner.invoke(
        app,
        [
            "dynamodb",
            "delete-item",
            "--table-name",
            table_name,
            "--key",
            json.dumps({"pk": {"S": key}}),
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete table "{table_name}"'),
    target_fixture="command_result",
)
def i_delete_table(table_name, e2e_port):
    return runner.invoke(
        app,
        [
            "dynamodb",
            "delete-table",
            "--table-name",
            table_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I describe table "{table_name}"'),
    target_fixture="command_result",
)
def i_describe_table(table_name, e2e_port):
    return runner.invoke(
        app,
        [
            "dynamodb",
            "describe-table",
            "--table-name",
            table_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I get item with key "{key}" from table "{table_name}"'),
    target_fixture="command_result",
)
def i_get_item(key, table_name, e2e_port):
    return runner.invoke(
        app,
        [
            "dynamodb",
            "get-item",
            "--table-name",
            table_name,
            "--key",
            json.dumps({"pk": {"S": key}}),
            "--port",
            str(e2e_port),
        ],
    )


@when("I list tables", target_fixture="command_result")
def i_list_tables(e2e_port):
    return runner.invoke(
        app,
        ["dynamodb", "list-tables", "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I put an item with key "{key}" and data "{data}" into table "{table_name}"'),
    target_fixture="command_result",
)
def i_put_an_item(key, data, table_name, e2e_port):
    return runner.invoke(
        app,
        [
            "dynamodb",
            "put-item",
            "--table-name",
            table_name,
            "--item",
            json.dumps({"pk": {"S": key}, "data": {"S": data}}),
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I query table "{table_name}" for key "{key}"'),
    target_fixture="command_result",
)
def i_query_table(table_name, key, e2e_port):
    return runner.invoke(
        app,
        [
            "dynamodb",
            "query",
            "--table-name",
            table_name,
            "--key-condition-expression",
            "pk = :v",
            "--expression-attribute-values",
            json.dumps({":v": {"S": key}}),
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I scan table "{table_name}"'),
    target_fixture="command_result",
)
def i_scan_table(table_name, e2e_port):
    return runner.invoke(
        app,
        [
            "dynamodb",
            "scan",
            "--table-name",
            table_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I transact get item with key "{key}" from table "{table_name}"'),
    target_fixture="command_result",
)
def i_transact_get_item(key, table_name, e2e_port):
    transact_items = json.dumps(
        [
            {
                "Get": {
                    "TableName": table_name,
                    "Key": {"pk": {"S": key}},
                }
            }
        ]
    )
    return runner.invoke(
        app,
        [
            "dynamodb",
            "transact-get-items",
            "--transact-items",
            transact_items,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse(
        'I transact write with condition check on key "{guard_key}" and put key'
        ' "{put_key}" with data "{data}" in table "{table_name}"'
    ),
    target_fixture="command_result",
)
def i_transact_write_items(guard_key, put_key, data, table_name, e2e_port):
    transact_items = json.dumps(
        [
            {
                "ConditionCheck": {
                    "TableName": table_name,
                    "Key": {"pk": {"S": guard_key}},
                    "ConditionExpression": "attribute_exists(pk)",
                }
            },
            {
                "Put": {
                    "TableName": table_name,
                    "Item": {
                        "pk": {"S": put_key},
                        "data": {"S": data},
                    },
                }
            },
        ]
    )
    return runner.invoke(
        app,
        [
            "dynamodb",
            "transact-write-items",
            "--transact-items",
            transact_items,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse(
        'I update item with key "{key}" setting data to "{data}" in table "{table_name}"'
    ),
    target_fixture="command_result",
)
def i_update_item(key, data, table_name, e2e_port):
    return runner.invoke(
        app,
        [
            "dynamodb",
            "update-item",
            "--table-name",
            table_name,
            "--key",
            json.dumps({"pk": {"S": key}}),
            "--update-expression",
            "SET #d = :val",
            "--expression-attribute-values",
            json.dumps({":val": {"S": data}}),
            "--expression-attribute-names",
            json.dumps({"#d": "data"}),
            "--port",
            str(e2e_port),
        ],
    )


@then(
    parsers.parse('item with key "{key}" in table "{table_name}" will have data "{expected_data}"'),
)
def item_will_have_data(key, table_name, expected_data, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "dynamodb",
            "get-item",
            "--table-name",
            table_name,
            "--key",
            json.dumps({"pk": {"S": key}}),
            "--port",
            str(e2e_port),
        ]
    )
    actual_data = verify["Item"]["data"]["S"]
    assert actual_data == expected_data


@then(
    parsers.parse('item with key "{key}" will not exist in table "{table_name}"'),
)
def item_will_not_exist(key, table_name, e2e_port, parse_output):
    result = runner.invoke(
        app,
        [
            "dynamodb",
            "get-item",
            "--table-name",
            table_name,
            "--key",
            json.dumps({"pk": {"S": key}}),
            "--port",
            str(e2e_port),
        ],
    )
    body = parse_output(result.output)
    assert "Item" not in body


@then(
    parsers.parse("the query result will contain at least {count:d} item"),
)
def query_result_will_contain_at_least(count, command_result, parse_output):
    body = parse_output(command_result.output)
    assert body["Count"] >= count


@then(
    parsers.parse("the scan result will contain at least {count:d} items"),
)
def scan_result_will_contain_at_least(count, command_result, parse_output):
    body = parse_output(command_result.output)
    assert body["Count"] >= count


@then(
    parsers.parse('the scan result will include key "{key}"'),
)
def scan_result_will_include_key(key, command_result, parse_output):
    body = parse_output(command_result.output)
    actual_pks = [item["pk"]["S"] for item in body["Items"]]
    assert key in actual_pks


@then(
    parsers.parse('table "{table_name}" will exist'),
)
def table_will_exist(table_name, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "dynamodb",
            "describe-table",
            "--table-name",
            table_name,
            "--port",
            str(e2e_port),
        ]
    )
    actual_name = verify["Table"]["TableName"]
    assert actual_name == table_name


@then(
    parsers.parse('table "{table_name}" will have {count:d} items'),
)
def table_will_have_n_items(table_name, count, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "dynamodb",
            "scan",
            "--table-name",
            table_name,
            "--port",
            str(e2e_port),
        ]
    )
    actual_count = verify["Count"]
    assert actual_count == count


@then(
    parsers.parse('table "{table_name}" will not appear in list-tables'),
)
def table_will_not_appear(table_name, assert_invoke, e2e_port):
    verify = assert_invoke(["dynamodb", "list-tables", "--port", str(e2e_port)])
    actual_tables = verify.get("TableNames", [])
    assert table_name not in actual_tables


@then(
    parsers.parse('the first query result will have data "{expected_data}"'),
)
def the_first_query_result_will_have_data(expected_data, command_result, parse_output):
    body = parse_output(command_result.output)
    actual_data = body["Items"][0]["data"]["S"]
    assert actual_data == expected_data


@then(
    parsers.parse('the output will contain item data "{expected_data}"'),
)
def the_output_will_contain_item_data(expected_data, command_result, parse_output):
    body = parse_output(command_result.output)
    actual_data = body["Item"]["data"]["S"]
    assert actual_data == expected_data


@then(
    parsers.parse('the output will contain table name "{expected_name}"'),
)
def the_output_will_contain_table_name(expected_name, command_result, parse_output):
    body = parse_output(command_result.output)
    if "TableDescription" in body:
        actual_name = body["TableDescription"]["TableName"]
    else:
        actual_name = body["Table"]["TableName"]
    assert actual_name == expected_name


@then("the output will contain a TransactionCanceledException")
def the_output_will_contain_transaction_cancelled(command_result, parse_output):
    body = parse_output(command_result.output)
    expected_error = "com.amazonaws.dynamodb.v20120810#TransactionCanceledException"
    actual_error = body["__type"]
    assert actual_error == expected_error


@then(
    parsers.parse('the table list will include "{table_name}"'),
)
def the_table_list_will_include(table_name, command_result, parse_output):
    actual_tables = parse_output(command_result.output)["TableNames"]
    assert table_name in actual_tables


# ── Step definitions for new commands ────────────────────────────────

_DDB_ARN_PREFIX = "arn:aws:dynamodb:us-east-1:000000000000:table"


@given(
    parsers.parse('table "{table_name}" was tagged with key "{tag_key}" and value "{tag_value}"'),
)
def table_was_tagged(table_name, tag_key, tag_value, lws_invoke, e2e_port):
    arn = f"{_DDB_ARN_PREFIX}/{table_name}"
    tags_json = json.dumps([{"Key": tag_key, "Value": tag_value}])
    lws_invoke(
        [
            "dynamodb",
            "tag-resource",
            "--resource-arn",
            arn,
            "--tags",
            tags_json,
            "--port",
            str(e2e_port),
        ]
    )


@when(
    parsers.parse('I update table "{table_name}" with billing mode "{billing_mode}"'),
    target_fixture="command_result",
)
def i_update_table(table_name, billing_mode, e2e_port):
    return runner.invoke(
        app,
        [
            "dynamodb",
            "update-table",
            "--table-name",
            table_name,
            "--billing-mode",
            billing_mode,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I describe time to live for table "{table_name}"'),
    target_fixture="command_result",
)
def i_describe_time_to_live(table_name, e2e_port):
    return runner.invoke(
        app,
        [
            "dynamodb",
            "describe-time-to-live",
            "--table-name",
            table_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I update time to live for table "{table_name}"'),
    target_fixture="command_result",
)
def i_update_time_to_live(table_name, e2e_port):
    ttl_spec = json.dumps({"Enabled": True, "AttributeName": "ttl"})
    return runner.invoke(
        app,
        [
            "dynamodb",
            "update-time-to-live",
            "--table-name",
            table_name,
            "--time-to-live-specification",
            ttl_spec,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I describe continuous backups for table "{table_name}"'),
    target_fixture="command_result",
)
def i_describe_continuous_backups(table_name, e2e_port):
    return runner.invoke(
        app,
        [
            "dynamodb",
            "describe-continuous-backups",
            "--table-name",
            table_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I tag table "{table_name}" with key "{tag_key}" and value "{tag_value}"'),
    target_fixture="command_result",
)
def i_tag_resource(table_name, tag_key, tag_value, e2e_port):
    arn = f"{_DDB_ARN_PREFIX}/{table_name}"
    tags_json = json.dumps([{"Key": tag_key, "Value": tag_value}])
    return runner.invoke(
        app,
        [
            "dynamodb",
            "tag-resource",
            "--resource-arn",
            arn,
            "--tags",
            tags_json,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I untag table "{table_name}" removing key "{tag_key}"'),
    target_fixture="command_result",
)
def i_untag_resource(table_name, tag_key, e2e_port):
    arn = f"{_DDB_ARN_PREFIX}/{table_name}"
    tag_keys_json = json.dumps([tag_key])
    return runner.invoke(
        app,
        [
            "dynamodb",
            "untag-resource",
            "--resource-arn",
            arn,
            "--tag-keys",
            tag_keys_json,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I list tags of table "{table_name}"'),
    target_fixture="command_result",
)
def i_list_tags_of_resource(table_name, e2e_port):
    arn = f"{_DDB_ARN_PREFIX}/{table_name}"
    return runner.invoke(
        app,
        [
            "dynamodb",
            "list-tags-of-resource",
            "--resource-arn",
            arn,
            "--port",
            str(e2e_port),
        ],
    )
