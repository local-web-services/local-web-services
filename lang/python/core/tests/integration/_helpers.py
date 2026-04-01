"""Shared helpers for integration tests."""

from __future__ import annotations

import json

from starlette.testclient import TestClient

_TARGET = "AmazonOrganizationsV20161128"

CUSTOM_SEED_YAML = """\
organization:
  id: o-custom12345
  master_account_id: "000000000000"
  feature_set: ALL

roots:
  - id: r-0001
    name: Root

ous: []

accounts:
  - id: "111111111111"
    name: acct-one
    email: acct-one@example.com
    ou: r-0001
  - id: "222222222222"
    name: acct-two
    email: acct-two@example.com
    ou: r-0001
  - id: "333333333333"
    name: acct-three
    email: acct-three@example.com
    ou: r-0001
"""


def post(config_client: TestClient, action: str, body: dict) -> tuple[int, dict]:
    resp = config_client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"{_TARGET}.{action}",
        },
        content=json.dumps(body),
    )
    return resp.status_code, resp.json()


def cfn_post(cfn_client: TestClient, action: str, **params: str) -> tuple[int, str]:
    """POST a form-encoded CloudFormation request and return (status_code, body_text)."""
    resp = cfn_client.post("/", data={"Action": action, **params})
    return resp.status_code, resp.text
