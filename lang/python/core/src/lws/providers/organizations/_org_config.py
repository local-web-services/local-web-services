"""YAML config loader for the Organizations provider."""

from __future__ import annotations

import time

import yaml

from lws.providers.organizations._org_helpers import (
    _account_arn,
    _org_arn,
    _ou_arn,
    _root_arn,
)
from lws.providers.organizations._org_state import _OrganizationsState


def load_organizations_config(config_path: str) -> _OrganizationsState:
    """Parse a YAML config file and return a pre-populated _OrganizationsState."""
    with open(config_path, encoding="utf-8") as fh:
        data = yaml.safe_load(fh)

    state = _OrganizationsState()

    org_cfg = data.get("organization", {})
    org_id = org_cfg["id"]
    master_account_id = str(org_cfg.get("master_account_id", "000000000000"))
    feature_set = org_cfg.get("feature_set", "ALL")

    state.organization = {
        "Id": org_id,
        "Arn": _org_arn(org_id),
        "FeatureSet": feature_set,
        "MasterAccountId": master_account_id,
        "MasterAccountArn": (
            f"arn:aws:organizations::{master_account_id}:account/{org_id}/{master_account_id}"
        ),
        "MasterAccountEmail": "master@example.com",
        "AvailablePolicyTypes": [{"Type": "SERVICE_CONTROL_POLICY", "Status": "ENABLED"}],
    }

    for root_cfg in data.get("roots", []):
        root_id = root_cfg["id"]
        state.root = {
            "Id": root_id,
            "Arn": _root_arn(org_id, root_id),
            "Name": root_cfg.get("name", "Root"),
            "PolicyTypes": [{"Type": "SERVICE_CONTROL_POLICY", "Status": "ENABLED"}],
        }
        break  # only one root is supported

    for ou_cfg in data.get("ous", []):
        ou_id = ou_cfg["id"]
        state.ous[ou_id] = {
            "Id": ou_id,
            "Arn": _ou_arn(org_id, ou_id),
            "Name": ou_cfg["name"],
            "ParentId": ou_cfg["parent"],
        }

    joined_timestamp = time.time()
    for acct_cfg in data.get("accounts", []):
        account_id = str(acct_cfg["id"])
        status = acct_cfg.get("status", "ACTIVE")
        state.accounts[account_id] = {
            "Id": account_id,
            "Arn": _account_arn(account_id),
            "Name": acct_cfg["name"],
            "Email": acct_cfg.get("email", f"{acct_cfg['name']}@example.com"),
            "Status": status,
            "JoinedMethod": "CREATED",
            "JoinedTimestamp": joined_timestamp,
        }
        state.account_parents[account_id] = acct_cfg["ou"]

        tags = acct_cfg.get("tags", {})
        if tags:
            state.resource_tags[account_id] = dict(tags)

    return state
