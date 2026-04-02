"""Test client for stepfunctions_ssm tests."""

from __future__ import annotations

from .constants import (
    PASS_DEFINITION,
    ROLE_ARN,
    TEST_INPUT,
    TEST_PARAM,
    TEST_SM,
    TEST_VALUE,
    _sm_arn,
)


class StepfunctionsSsmTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _sfn = lws_session.client("stepfunctions")
        self._sfn = _sfn
        _ssm = lws_session.client("ssm")
        self._ssm = _ssm

    def create_sm(self, name=TEST_SM):
        from botocore.exceptions import (
            ClientError,
        )  # pylint: disable=import-outside-toplevel

        try:
            resp = self._sfn.create_state_machine(
                name=name, definition=PASS_DEFINITION, roleArn=ROLE_ARN
            )
            return resp["stateMachineArn"]
        except ClientError as exc:
            if exc.response["Error"]["Code"] != "StateMachineAlreadyExists":
                raise
            return _sm_arn(name)

    def create_param(self, name=TEST_PARAM):
        self._ssm.put_parameter(Name=name, Value=TEST_VALUE, Type="String", Overwrite=True)

    def start_execution(self, name=TEST_SM):
        resp = self._sfn.start_execution(stateMachineArn=_sm_arn(name), input=TEST_INPUT)
        return resp["executionArn"]
