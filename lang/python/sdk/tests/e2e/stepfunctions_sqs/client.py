"""Test client for stepfunctions_sqs tests."""

from __future__ import annotations

from .constants import PASS_DEFINITION, ROLE_ARN, TEST_INPUT, TEST_QUEUE, TEST_SM, _sm_arn


class StepfunctionsSqsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _sfn = lws_session.client("stepfunctions")
        self._sfn = _sfn
        _sqs = lws_session.client("sqs")
        self._sqs = _sqs

    def queue_url(self, name=TEST_QUEUE):
        return self._session.queue_url(name)

    def create_sm(self, name=TEST_SM):
        resp = self._sfn.create_state_machine(
            name=name, definition=PASS_DEFINITION, roleArn=ROLE_ARN
        )
        return resp["stateMachineArn"]

    def create_queue(self, name=TEST_QUEUE):
        self._sqs.create_queue(QueueName=name)

    def start_execution(self, name=TEST_SM):
        resp = self._sfn.start_execution(stateMachineArn=_sm_arn(name), input=TEST_INPUT)
        return resp["executionArn"]
