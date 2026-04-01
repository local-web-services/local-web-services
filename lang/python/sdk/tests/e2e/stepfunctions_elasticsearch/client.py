"""Test client for stepfunctions_elasticsearch tests."""

from __future__ import annotations

from .constants import PASS_DEFINITION, ROLE_ARN, TEST_DOMAIN, TEST_INPUT, TEST_SM, _sm_arn


class StepfunctionsElasticsearchTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _sfn = lws_session.client("stepfunctions")
        self._sfn = _sfn
        _es = lws_session.client("es")
        self._es = _es

    def create_sm(self, name=TEST_SM):
        resp = self._sfn.create_state_machine(
            name=name, definition=PASS_DEFINITION, roleArn=ROLE_ARN
        )
        return resp["stateMachineArn"]

    def create_domain(self, name=TEST_DOMAIN):
        self._es.create_elasticsearch_domain(DomainName=name)

    def start_execution(self, name=TEST_SM):
        resp = self._sfn.start_execution(stateMachineArn=_sm_arn(name), input=TEST_INPUT)
        return resp["executionArn"]
