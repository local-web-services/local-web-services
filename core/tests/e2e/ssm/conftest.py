"""Shared fixtures for ssm E2E tests."""

from __future__ import annotations

from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


# ── Step definitions ──────────────────────────────────────────────────


@given(
    parsers.parse('a parameter "{name}" was created with value "{value}" and type "{param_type}"'),
    target_fixture="given_param",
)
def a_parameter_was_created(name, value, param_type, lws_invoke, e2e_port):
    lws_invoke(
        [
            "ssm",
            "put-parameter",
            "--name",
            name,
            "--value",
            value,
            "--type",
            param_type,
            "--port",
            str(e2e_port),
        ]
    )
    return {"name": name, "value": value}


@when(
    parsers.parse('I add tags {tags_json} to parameter "{name}"'),
    target_fixture="command_result",
)
def i_add_tags_to_parameter(tags_json, name, e2e_port):
    return runner.invoke(
        app,
        [
            "ssm",
            "add-tags-to-resource",
            "--resource-type",
            "Parameter",
            "--resource-id",
            name,
            "--tags",
            tags_json,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete parameter "{name}"'),
    target_fixture="command_result",
)
def i_delete_parameter(name, e2e_port):
    return runner.invoke(
        app,
        ["ssm", "delete-parameter", "--name", name, "--port", str(e2e_port)],
    )


@when(
    parsers.parse("I delete parameters {names_json}"),
    target_fixture="command_result",
)
def i_delete_parameters(names_json, e2e_port):
    return runner.invoke(
        app,
        ["ssm", "delete-parameters", "--names", names_json, "--port", str(e2e_port)],
    )


@when("I describe parameters", target_fixture="command_result")
def i_describe_parameters(e2e_port):
    return runner.invoke(
        app,
        ["ssm", "describe-parameters", "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I get parameter "{name}"'),
    target_fixture="command_result",
)
def i_get_parameter(name, e2e_port):
    return runner.invoke(
        app,
        ["ssm", "get-parameter", "--name", name, "--port", str(e2e_port)],
    )


@when(
    parsers.re(r"I get parameters (?P<names_json>\[.+\])"),
    target_fixture="command_result",
)
def i_get_parameters(names_json, e2e_port):
    return runner.invoke(
        app,
        ["ssm", "get-parameters", "--names", names_json, "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I get parameters by path "{path}"'),
    target_fixture="command_result",
)
def i_get_parameters_by_path(path, e2e_port):
    return runner.invoke(
        app,
        ["ssm", "get-parameters-by-path", "--path", path, "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I list tags for parameter "{name}"'),
    target_fixture="command_result",
)
def i_list_tags_for_parameter(name, e2e_port):
    return runner.invoke(
        app,
        [
            "ssm",
            "list-tags-for-resource",
            "--resource-type",
            "Parameter",
            "--resource-id",
            name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I put parameter "{name}" with value "{value}" and type "{param_type}"'),
    target_fixture="command_result",
)
def i_put_parameter(name, value, param_type, e2e_port):
    return runner.invoke(
        app,
        [
            "ssm",
            "put-parameter",
            "--name",
            name,
            "--value",
            value,
            "--type",
            param_type,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse(
        'I put parameter "{name}" with value "{value}" and type "{param_type}"'
        ' and description "{description}"'
    ),
    target_fixture="command_result",
)
def i_put_parameter_with_description(name, value, param_type, description, e2e_port):
    return runner.invoke(
        app,
        [
            "ssm",
            "put-parameter",
            "--name",
            name,
            "--value",
            value,
            "--type",
            param_type,
            "--description",
            description,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse(
        'I put parameter "{name}" with value "{value}" and type "{param_type}" with overwrite'
    ),
    target_fixture="command_result",
)
def i_put_parameter_with_overwrite(name, value, param_type, e2e_port):
    return runner.invoke(
        app,
        [
            "ssm",
            "put-parameter",
            "--name",
            name,
            "--value",
            value,
            "--type",
            param_type,
            "--overwrite",
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I remove tag keys {keys_json} from parameter "{name}"'),
    target_fixture="command_result",
)
def i_remove_tags_from_parameter(keys_json, name, e2e_port):
    return runner.invoke(
        app,
        [
            "ssm",
            "remove-tags-from-resource",
            "--resource-type",
            "Parameter",
            "--resource-id",
            name,
            "--tag-keys",
            keys_json,
            "--port",
            str(e2e_port),
        ],
    )


@then(
    parsers.parse('parameter "{name}" will have value "{expected_value}"'),
)
def parameter_will_have_value(name, expected_value, assert_invoke, e2e_port):
    verify = assert_invoke(["ssm", "get-parameter", "--name", name, "--port", str(e2e_port)])
    actual_value = verify["Parameter"]["Value"]
    assert actual_value == expected_value


@then(
    parsers.parse('parameter "{name}" will not appear in describe-parameters'),
)
def parameter_will_not_appear(name, assert_invoke, e2e_port):
    verify = assert_invoke(["ssm", "describe-parameters", "--port", str(e2e_port)])
    actual_names = [p["Name"] for p in verify["Parameters"]]
    assert name not in actual_names


@given(
    parsers.parse('tags {tags_json} were added to parameter "{name}"'),
)
def tags_were_added_to_parameter(tags_json, name, lws_invoke, e2e_port):
    lws_invoke(
        [
            "ssm",
            "add-tags-to-resource",
            "--resource-type",
            "Parameter",
            "--resource-id",
            name,
            "--tags",
            tags_json,
            "--port",
            str(e2e_port),
        ]
    )


@then(
    parsers.parse('the output will contain parameter value "{expected_value}"'),
)
def the_output_will_contain_parameter_value(expected_value, command_result, parse_output):
    actual_value = parse_output(command_result.output)["Parameter"]["Value"]
    assert actual_value == expected_value


@then(
    parsers.parse('the parameter list will include "{name}"'),
)
def the_parameter_list_will_include(name, command_result, parse_output):
    actual_names = [p["Name"] for p in parse_output(command_result.output)["Parameters"]]
    assert name in actual_names


@then(
    parsers.parse('parameter "{name}" will have tag "{key}" with value "{value}"'),
)
def parameter_will_have_tag(name, key, value, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "ssm",
            "list-tags-for-resource",
            "--resource-type",
            "Parameter",
            "--resource-id",
            name,
            "--port",
            str(e2e_port),
        ]
    )
    tags = verify.get("TagList", [])
    expected_tag = {"Key": key, "Value": value}
    assert expected_tag in tags


@then(
    parsers.parse('parameter "{name}" will not have tag "{key}"'),
)
def parameter_will_not_have_tag(name, key, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "ssm",
            "list-tags-for-resource",
            "--resource-type",
            "Parameter",
            "--resource-id",
            name,
            "--port",
            str(e2e_port),
        ]
    )
    tags = verify.get("TagList", [])
    actual_keys = [t["Key"] for t in tags]
    assert key not in actual_keys
