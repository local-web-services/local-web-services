"""Shared fixtures for secretsmanager E2E tests."""

from __future__ import annotations

from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


# ── Step definitions ──────────────────────────────────────────────────


@given(
    parsers.parse('a secret "{name}" was created with value "{value}"'),
    target_fixture="given_secret",
)
def a_secret_was_created(name, value, lws_invoke, e2e_port):
    lws_invoke(
        [
            "secretsmanager",
            "create-secret",
            "--name",
            name,
            "--secret-string",
            value,
            "--port",
            str(e2e_port),
        ]
    )
    return {"name": name, "value": value}


@when(
    parsers.parse('I create secret "{name}" with value "{value}"'),
    target_fixture="command_result",
)
def i_create_secret(name, value, e2e_port):
    return runner.invoke(
        app,
        [
            "secretsmanager",
            "create-secret",
            "--name",
            name,
            "--secret-string",
            value,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I create secret "{name}" with value "{value}" and description "{description}"'),
    target_fixture="command_result",
)
def i_create_secret_with_description(name, value, description, e2e_port):
    return runner.invoke(
        app,
        [
            "secretsmanager",
            "create-secret",
            "--name",
            name,
            "--secret-string",
            value,
            "--description",
            description,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete secret "{name}" with force delete without recovery'),
    target_fixture="command_result",
)
def i_delete_secret_force(name, e2e_port):
    return runner.invoke(
        app,
        [
            "secretsmanager",
            "delete-secret",
            "--secret-id",
            name,
            "--force-delete-without-recovery",
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I describe secret "{name}"'),
    target_fixture="command_result",
)
def i_describe_secret(name, e2e_port):
    return runner.invoke(
        app,
        [
            "secretsmanager",
            "describe-secret",
            "--secret-id",
            name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I get resource policy for "{name}"'),
    target_fixture="command_result",
)
def i_get_resource_policy(name, e2e_port):
    return runner.invoke(
        app,
        [
            "secretsmanager",
            "get-resource-policy",
            "--secret-id",
            name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I get secret value for "{name}"'),
    target_fixture="command_result",
)
def i_get_secret_value(name, e2e_port):
    return runner.invoke(
        app,
        [
            "secretsmanager",
            "get-secret-value",
            "--secret-id",
            name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I list secret version IDs for "{name}"'),
    target_fixture="command_result",
)
def i_list_secret_version_ids(name, e2e_port):
    return runner.invoke(
        app,
        [
            "secretsmanager",
            "list-secret-version-ids",
            "--secret-id",
            name,
            "--port",
            str(e2e_port),
        ],
    )


@when("I list secrets", target_fixture="command_result")
def i_list_secrets(e2e_port):
    return runner.invoke(
        app,
        ["secretsmanager", "list-secrets", "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I put secret value "{value}" for "{name}"'),
    target_fixture="command_result",
)
def i_put_secret_value(value, name, e2e_port):
    return runner.invoke(
        app,
        [
            "secretsmanager",
            "put-secret-value",
            "--secret-id",
            name,
            "--secret-string",
            value,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I restore secret "{name}"'),
    target_fixture="command_result",
)
def i_restore_secret(name, e2e_port):
    return runner.invoke(
        app,
        [
            "secretsmanager",
            "restore-secret",
            "--secret-id",
            name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I tag secret "{name}" with tags {tags_json}'),
    target_fixture="command_result",
)
def i_tag_secret(name, tags_json, e2e_port):
    return runner.invoke(
        app,
        [
            "secretsmanager",
            "tag-resource",
            "--secret-id",
            name,
            "--tags",
            tags_json,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I untag secret "{name}" with tag keys {keys_json}'),
    target_fixture="command_result",
)
def i_untag_secret(name, keys_json, e2e_port):
    return runner.invoke(
        app,
        [
            "secretsmanager",
            "untag-resource",
            "--secret-id",
            name,
            "--tag-keys",
            keys_json,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I update secret "{name}" with value "{value}"'),
    target_fixture="command_result",
)
def i_update_secret(name, value, e2e_port):
    return runner.invoke(
        app,
        [
            "secretsmanager",
            "update-secret",
            "--secret-id",
            name,
            "--secret-string",
            value,
            "--port",
            str(e2e_port),
        ],
    )


@then(
    parsers.parse('secret "{name}" will appear in describe-secret'),
)
def secret_will_appear_in_describe(name, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "secretsmanager",
            "describe-secret",
            "--secret-id",
            name,
            "--port",
            str(e2e_port),
        ]
    )
    actual_name = verify["Name"]
    assert actual_name == name


@then(
    parsers.parse('secret "{name}" will have value "{expected_value}"'),
)
def secret_will_have_value(name, expected_value, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "secretsmanager",
            "get-secret-value",
            "--secret-id",
            name,
            "--port",
            str(e2e_port),
        ]
    )
    actual_value = verify["SecretString"]
    assert actual_value == expected_value


@then(
    parsers.parse('secret "{name}" will not appear in list-secrets'),
)
def secret_will_not_appear_in_list(name, assert_invoke, e2e_port):
    verify = assert_invoke(["secretsmanager", "list-secrets", "--port", str(e2e_port)])
    actual_names = [s["Name"] for s in verify.get("SecretList", [])]
    assert name not in actual_names


@given(
    parsers.parse('tags {tags_json} were added to secret "{name}"'),
)
def tags_were_added_to_secret(tags_json, name, lws_invoke, e2e_port):
    lws_invoke(
        [
            "secretsmanager",
            "tag-resource",
            "--secret-id",
            name,
            "--tags",
            tags_json,
            "--port",
            str(e2e_port),
        ]
    )


@then(
    parsers.parse('the output will contain secret name "{expected_name}"'),
)
def the_output_will_contain_secret_name(expected_name, command_result, parse_output):
    actual_name = parse_output(command_result.output)["Name"]
    assert actual_name == expected_name


@then(
    parsers.parse('the output will contain secret value "{expected_value}"'),
)
def the_output_will_contain_secret_value(expected_value, command_result, parse_output):
    actual_value = parse_output(command_result.output)["SecretString"]
    assert actual_value == expected_value


@then(
    parsers.parse('the secret list will include "{expected_name}"'),
)
def the_secret_list_will_include(expected_name, command_result, parse_output):
    actual_names = [s["Name"] for s in parse_output(command_result.output)["SecretList"]]
    assert expected_name in actual_names


@given(
    parsers.parse('the secret "{name}" was deleted'),
)
def the_secret_was_deleted(name, lws_invoke, e2e_port):
    lws_invoke(
        [
            "secretsmanager",
            "delete-secret",
            "--secret-id",
            name,
            "--port",
            str(e2e_port),
        ]
    )
