"""Test client for stepfunctions_cognito tests."""

from __future__ import annotations

from .constants import PASS_DEFINITION, ROLE_ARN, TEST_INPUT, TEST_POOL, TEST_SM, _sm_arn


class StepfunctionsCognitoTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _sfn = lws_session.client("stepfunctions")
        self._sfn = _sfn
        _cognito = lws_session.client("cognito-idp")
        self._cognito = _cognito

    def create_sm(self, name=TEST_SM):
        resp = self._sfn.create_state_machine(
            name=name, definition=PASS_DEFINITION, roleArn=ROLE_ARN
        )
        return resp["stateMachineArn"]

    def create_pool(self, name=TEST_POOL):
        resp = self._cognito.create_user_pool(PoolName=name)
        return resp["UserPool"]["Id"]

    def get_pool_id(self, name=TEST_POOL):
        resp = self._cognito.list_user_pools(MaxResults=60)
        for pool in resp.get("UserPools", []):
            if pool["Name"] == name:
                return pool["Id"]
        return None

    def start_execution(self, name=TEST_SM):
        resp = self._sfn.start_execution(stateMachineArn=_sm_arn(name), input=TEST_INPUT)
        return resp["executionArn"]
