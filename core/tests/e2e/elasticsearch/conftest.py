"""Shared fixtures for elasticsearch E2E tests."""

from __future__ import annotations

from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


# ── Step definitions ──────────────────────────────────────────────────


@given(
    parsers.parse('an elasticsearch domain "{domain_name}" was created'),
    target_fixture="given_es_domain",
)
def an_elasticsearch_domain_was_created(domain_name, lws_invoke, e2e_port):
    lws_invoke(
        [
            "es",
            "create-elasticsearch-domain",
            "--domain-name",
            domain_name,
            "--port",
            str(e2e_port),
        ]
    )
    yield {"domain_name": domain_name}
    runner.invoke(
        app,
        [
            "es",
            "delete-elasticsearch-domain",
            "--domain-name",
            domain_name,
            "--port",
            str(e2e_port),
        ],
    )


@then(
    parsers.parse('elasticsearch domain "{domain_name}" will exist'),
)
def elasticsearch_domain_will_exist(domain_name, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "es",
            "describe-elasticsearch-domain",
            "--domain-name",
            domain_name,
            "--port",
            str(e2e_port),
        ]
    )
    actual_domain_name = verify["DomainStatus"]["DomainName"]
    assert actual_domain_name == domain_name


@when(
    parsers.parse('I create elasticsearch domain "{domain_name}"'),
    target_fixture="command_result",
)
def i_create_elasticsearch_domain(domain_name, e2e_port):
    result = runner.invoke(
        app,
        [
            "es",
            "create-elasticsearch-domain",
            "--domain-name",
            domain_name,
            "--port",
            str(e2e_port),
        ],
    )
    yield result
    runner.invoke(
        app,
        [
            "es",
            "delete-elasticsearch-domain",
            "--domain-name",
            domain_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete elasticsearch domain "{domain_name}"'),
    target_fixture="command_result",
)
def i_delete_elasticsearch_domain(domain_name, e2e_port):
    return runner.invoke(
        app,
        [
            "es",
            "delete-elasticsearch-domain",
            "--domain-name",
            domain_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I list elasticsearch domain names",
    target_fixture="command_result",
)
def i_list_elasticsearch_domain_names(e2e_port):
    return runner.invoke(
        app,
        ["es", "list-domain-names", "--port", str(e2e_port)],
    )


@then(
    parsers.parse('the elasticsearch domain list will include "{domain_name}"'),
)
def the_elasticsearch_domain_list_will_include(domain_name, assert_invoke, e2e_port):
    verify = assert_invoke(["es", "list-domain-names", "--port", str(e2e_port)])
    actual_names = [d["DomainName"] for d in verify["DomainNames"]]
    assert domain_name in actual_names


@then(
    parsers.parse('the elasticsearch domain list will not include "{domain_name}"'),
)
def the_elasticsearch_domain_list_will_not_include(domain_name, assert_invoke, e2e_port):
    verify = assert_invoke(["es", "list-domain-names", "--port", str(e2e_port)])
    actual_names = [d["DomainName"] for d in verify["DomainNames"]]
    assert domain_name not in actual_names
