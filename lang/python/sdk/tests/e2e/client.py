"""Test client for e2e tests."""

from __future__ import annotations

from .constants import (
    EVENT_PATTERN,
    PASS_DEFINITION,
    ROLE_ARN,
    TEST_BUCKET,
    TEST_BUS,
    TEST_INPUT,
    TEST_PARAM,
    TEST_PARAM_VALUE,
    TEST_PK,
    TEST_QUEUE,
    TEST_RULE,
    TEST_SECRET,
    TEST_SECRET_VALUE,
    TEST_SM,
    TEST_TABLE,
    TEST_TOPIC,
    _sm_arn,
)


class E2eTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _sqs = lws_session.client("sqs")
        self._sqs = _sqs
        _sns = lws_session.client("sns")
        self._sns = _sns
        _events = lws_session.client("events")
        self._events = _events
        _sfn = lws_session.client("stepfunctions")
        self._sfn = _sfn
        _dynamo = lws_session.client("dynamodb")
        self._dynamo = _dynamo
        _s3 = lws_session.client("s3")
        self._s3 = _s3
        _ssm = lws_session.client("ssm")
        self._ssm = _ssm
        _secretsmanager = lws_session.client("secretsmanager")
        self._secretsmanager = _secretsmanager

    def queue_url(self, name=TEST_QUEUE):
        return self._session.queue_url(name)

    def create_queue(self, name=TEST_QUEUE):
        self._sqs.create_queue(QueueName=name)

    def create_topic(self, name=TEST_TOPIC):
        resp = self._sns.create_topic(Name=name)
        return resp["TopicArn"]

    def create_bus(self, name=TEST_BUS):
        self._events.create_event_bus(Name=name)

    def create_rule(self, bus_name=TEST_BUS, rule_name=TEST_RULE):
        self._events.put_rule(
            Name=rule_name,
            EventBusName=bus_name,
            EventPattern=EVENT_PATTERN,
            State="ENABLED",
        )

    def create_sm(self, name=TEST_SM, sm_type="STANDARD"):
        resp = self._sfn.create_state_machine(
            name=name, definition=PASS_DEFINITION, roleArn=ROLE_ARN, type=sm_type
        )
        return resp["stateMachineArn"]

    def start_execution(self, sm_name=TEST_SM):
        sm_arn = _sm_arn(sm_name)
        resp = self._sfn.start_execution(stateMachineArn=sm_arn, input=TEST_INPUT)
        return resp["executionArn"]

    def create_table(self, name=TEST_TABLE):
        self._dynamo.create_table(
            TableName=name,
            KeySchema=[{"AttributeName": TEST_PK, "KeyType": "HASH"}],
            AttributeDefinitions=[{"AttributeName": TEST_PK, "AttributeType": "S"}],
            BillingMode="PAY_PER_REQUEST",
        )

    def create_bucket(self, name=TEST_BUCKET):
        self._s3.create_bucket(Bucket=name)

    def create_param(self, name=TEST_PARAM):
        self._ssm.put_parameter(Name=name, Value=TEST_PARAM_VALUE, Type="String")

    def create_secret(self, name=TEST_SECRET):
        self._secretsmanager.create_secret(Name=name, SecretString=TEST_SECRET_VALUE)
