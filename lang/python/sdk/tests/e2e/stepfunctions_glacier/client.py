"""Test client for stepfunctions_glacier tests."""

from __future__ import annotations

from .constants import PASS_DEFINITION, ROLE_ARN, TEST_INPUT, TEST_SM, TEST_VAULT, _sm_arn


class StepfunctionsGlacierTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _sfn = lws_session.client("stepfunctions")
        self._sfn = _sfn
        _glacier = lws_session.client("glacier")
        self._glacier = _glacier

    def create_sm(self, name=TEST_SM):
        resp = self._sfn.create_state_machine(
            name=name, definition=PASS_DEFINITION, roleArn=ROLE_ARN
        )
        return resp["stateMachineArn"]

    def create_vault(self, name=TEST_VAULT):
        self._glacier.create_vault(accountId="-", vaultName=name)

    def vault_exists(self, name=TEST_VAULT):
        resp = self._glacier.list_vaults(accountId="-")
        for vault in resp.get("VaultList", []):
            if vault["VaultName"] == name:
                return True
        return False

    def start_execution(self, name=TEST_SM):
        resp = self._sfn.start_execution(stateMachineArn=_sm_arn(name), input=TEST_INPUT)
        return resp["executionArn"]
