"""Shared fixtures for opensearch E2E tests."""

from __future__ import annotations

from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


# ── Step definitions ──────────────────────────────────────────────────


@given(
    parsers.parse('an opensearch domain "{domain_name}" was created'),
    target_fixture="given_os_domain",
)
def an_opensearch_domain_was_created(domain_name, lws_invoke, e2e_port):
    lws_invoke(
        [
            "opensearch",
            "create-domain",
            "--domain-name",
            domain_name,
            "--port",
            str(e2e_port),
        ]
    )
    yield {"domain_name": domain_name}
    runner.invoke(
        app,
        ["opensearch", "delete-domain", "--domain-name", domain_name, "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I create opensearch domain "{domain_name}"'),
    target_fixture="command_result",
)
def i_create_opensearch_domain(domain_name, e2e_port):
    result = runner.invoke(
        app,
        [
            "opensearch",
            "create-domain",
            "--domain-name",
            domain_name,
            "--port",
            str(e2e_port),
        ],
    )
    yield result
    runner.invoke(
        app,
        ["opensearch", "delete-domain", "--domain-name", domain_name, "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I delete opensearch domain "{domain_name}"'),
    target_fixture="command_result",
)
def i_delete_opensearch_domain(domain_name, e2e_port):
    return runner.invoke(
        app,
        [
            "opensearch",
            "delete-domain",
            "--domain-name",
            domain_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I list opensearch domain names",
    target_fixture="command_result",
)
def i_list_opensearch_domain_names(e2e_port):
    return runner.invoke(
        app,
        ["opensearch", "list-domain-names", "--port", str(e2e_port)],
    )


@then(
    parsers.parse('opensearch domain "{domain_name}" will exist'),
)
def opensearch_domain_will_exist(domain_name, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "opensearch",
            "describe-domain",
            "--domain-name",
            domain_name,
            "--port",
            str(e2e_port),
        ]
    )
    actual_domain_name = verify["DomainStatus"]["DomainName"]
    assert actual_domain_name == domain_name


@then(
    parsers.parse('the opensearch domain list will include "{domain_name}"'),
)
def the_opensearch_domain_list_will_include(domain_name, assert_invoke, e2e_port):
    verify = assert_invoke(["opensearch", "list-domain-names", "--port", str(e2e_port)])
    actual_names = [d["DomainName"] for d in verify["DomainNames"]]
    assert domain_name in actual_names


@then(
    parsers.parse('the opensearch domain list will not include "{domain_name}"'),
)
def the_opensearch_domain_list_will_not_include(domain_name, assert_invoke, e2e_port):
    verify = assert_invoke(["opensearch", "list-domain-names", "--port", str(e2e_port)])
    actual_names = [d["DomainName"] for d in verify["DomainNames"]]
    assert domain_name not in actual_names
