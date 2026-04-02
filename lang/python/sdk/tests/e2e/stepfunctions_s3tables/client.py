"""Test client for stepfunctions_s3tables tests."""

from __future__ import annotations

from .constants import (
    PASS_DEFINITION,
    ROLE_ARN,
    TEST_BUCKET,
    TEST_INPUT,
    TEST_SM,
    _sm_arn,
)


class StepfunctionsS3tablesTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _sfn = lws_session.client("stepfunctions")
        self._sfn = _sfn
        _s3tables = lws_session.client("s3tables")
        self._s3tables = _s3tables

    def create_sm(self, name=TEST_SM):
        resp = self._sfn.create_state_machine(
            name=name, definition=PASS_DEFINITION, roleArn=ROLE_ARN
        )
        return resp["stateMachineArn"]

    def create_table_bucket(self, name=TEST_BUCKET):
        self._s3tables.create_table_bucket(name=name)

    def table_bucket_exists(self, name=TEST_BUCKET):
        resp = self._s3tables.list_table_buckets()
        for bucket in resp.get("tableBuckets", []):
            if bucket["name"] == name:
                return True
        return False

    def start_execution(self, name=TEST_SM):
        resp = self._sfn.start_execution(stateMachineArn=_sm_arn(name), input=TEST_INPUT)
        return resp["executionArn"]
