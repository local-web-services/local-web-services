"""Test client for stepfunctions_dynamodb tests."""

from __future__ import annotations

from .constants import (
    PASS_DEFINITION,
    ROLE_ARN,
    TEST_INPUT,
    TEST_PK,
    TEST_SM,
    TEST_TABLE,
    _sm_arn,
)


class StepfunctionsDynamodbTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _sfn = lws_session.client("stepfunctions")
        self._sfn = _sfn
        _ddb = lws_session.client("dynamodb")
        self._ddb = _ddb

    def create_sm(self, name=TEST_SM):
        resp = self._sfn.create_state_machine(
            name=name, definition=PASS_DEFINITION, roleArn=ROLE_ARN
        )
        return resp["stateMachineArn"]

    def create_table(self, name=TEST_TABLE):
        self._ddb.create_table(
            TableName=name,
            KeySchema=[{"AttributeName": TEST_PK, "KeyType": "HASH"}],
            AttributeDefinitions=[{"AttributeName": TEST_PK, "AttributeType": "S"}],
            BillingMode="PAY_PER_REQUEST",
        )

    def start_execution(self, name=TEST_SM):
        resp = self._sfn.start_execution(stateMachineArn=_sm_arn(name), input=TEST_INPUT)
        return resp["executionArn"]
