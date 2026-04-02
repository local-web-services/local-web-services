"""Integration tests for Organizations provider YAML config loading."""

from __future__ import annotations

import json
import pathlib

import pytest
from starlette.testclient import TestClient

from lws.providers.organizations.routes import create_organizations_app

_CONFIG_YAML = """\
organization:
  id: o-inttest12345
  master_account_id: "000000000000"
  feature_set: ALL

roots:
  - id: r-0001
    name: Root

ous:
  - id: ou-prod-0001
    name: Production
    parent: r-0001
  - id: ou-dev-0002
    name: Development
    parent: r-0001

accounts:
  - id: "111111111111"
    name: prod-payments
    email: prod-payments@example.com
    ou: ou-prod-0001
    tags:
      env: prod
  - id: "222222222222"
    name: dev-tools
    email: dev-tools@example.com
    ou: ou-dev-0002
  - id: "333333333333"
    name: dev-infra
    email: dev-infra@example.com
    ou: ou-dev-0002
    status: SUSPENDED
"""

_TARGET = "AmazonOrganizationsV20161128"


def _post(client: TestClient, action: str, body: dict) -> tuple[int, dict]:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"{_TARGET}.{action}",
        },
        content=json.dumps(body),
    )
    return resp.status_code, resp.json()


@pytest.fixture
def config_file(tmp_path: pathlib.Path) -> str:
    p = tmp_path / "org.yaml"
    p.write_text(_CONFIG_YAML)
    return str(p)


@pytest.fixture
def config_client(config_file: str) -> TestClient:
    app, _ = create_organizations_app(config_path=config_file)
    return TestClient(app, raise_server_exceptions=False)


class TestProviderPrePopulatedFromYamlConfig:
    def test_describe_organization_returns_defined_org(self, config_client: TestClient) -> None:
        # Arrange — app started with config_file fixture

        # Act
        status, body = _post(config_client, "DescribeOrganization", {})

        # Assert
        actual_org_id = body.get("Organization", {}).get("Id")
        expected_org_id = "o-inttest12345"
        assert status == 200
        assert actual_org_id == expected_org_id

    def test_list_roots_returns_defined_root(self, config_client: TestClient) -> None:
        # Arrange — app started with config_file fixture

        # Act
        status, body = _post(config_client, "ListRoots", {})

        # Assert
        actual_root_ids = [r["Id"] for r in body.get("Roots", [])]
        expected_root_id = "r-0001"
        assert status == 200
        assert expected_root_id in actual_root_ids

    def test_list_accounts_returns_all_accounts(self, config_client: TestClient) -> None:
        # Arrange — app started with config_file fixture

        # Act
        status, body = _post(config_client, "ListAccounts", {})

        # Assert
        actual_account_ids = {a["Id"] for a in body.get("Accounts", [])}
        expected_account_ids = {"111111111111", "222222222222", "333333333333"}
        assert status == 200
        assert actual_account_ids == expected_account_ids

    def test_list_tags_for_resource_returns_account_tags(self, config_client: TestClient) -> None:
        # Arrange — app started with config_file fixture

        # Act
        status, body = _post(config_client, "ListTagsForResource", {"ResourceId": "111111111111"})

        # Assert
        actual_tags = {t["Key"]: t["Value"] for t in body.get("Tags", [])}
        expected_tags = {"env": "prod"}
        assert status == 200
        assert actual_tags == expected_tags

    def test_suspended_account_has_correct_status(self, config_client: TestClient) -> None:
        # Arrange — app started with config_file fixture

        # Act
        status, body = _post(config_client, "DescribeAccount", {"AccountId": "333333333333"})

        # Assert
        actual_status = body.get("Account", {}).get("Status")
        expected_status = "SUSPENDED"
        assert status == 200
        assert actual_status == expected_status


class TestProviderStartsEmptyWithoutConfig:
    def test_describe_organization_returns_not_in_use_exception(self) -> None:
        # Arrange
        app, _ = create_organizations_app()
        client = TestClient(app, raise_server_exceptions=False)

        # Act
        status, body = _post(client, "DescribeOrganization", {})

        # Assert
        actual_error_type = body.get("__type")
        expected_error_type = "AWSOrganizationsNotInUseException"
        assert actual_error_type == expected_error_type
