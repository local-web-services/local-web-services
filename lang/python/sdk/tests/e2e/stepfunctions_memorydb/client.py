"""Test client for stepfunctions_memorydb tests."""

from __future__ import annotations

import pytest

from .constants import (
    PASS_DEFINITION,
    ROLE_ARN,
    TEST_CLUSTER,
    TEST_INPUT,
    TEST_SM,
    _sm_arn,
)


class StepfunctionsMemorydbTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _sfn = lws_session.client("stepfunctions")
        self._sfn = _sfn
        _memorydb = lws_session.client("memorydb")
        self._memorydb = _memorydb

    def create_sm(self, name=TEST_SM):
        resp = self._sfn.create_state_machine(
            name=name, definition=PASS_DEFINITION, roleArn=ROLE_ARN
        )
        return resp["stateMachineArn"]

    def create_cluster(self, name=TEST_CLUSTER):
        pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
        self._memorydb.create_cluster(
            ClusterName=name, NodeType="db.t4g.small", ACLName="open-access"
        )

    def start_execution(self, name=TEST_SM):
        resp = self._sfn.start_execution(stateMachineArn=_sm_arn(name), input=TEST_INPUT)
        return resp["executionArn"]
