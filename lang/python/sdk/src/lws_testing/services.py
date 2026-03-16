"""Service name constants and lifecycle dwell time presets."""

from __future__ import annotations


class Service:
    """String constants for AWS service names accepted by session builders.

    Usage::

        session.lifecycle(Service.DYNAMODB).create_dwell_ms(LifecycleDwell.TYPICAL).apply()
        session.chaos(Service.S3).error_rate(0.3).apply()
    """

    DYNAMODB = "dynamodb"
    SQS = "sqs"
    S3 = "s3"
    SNS = "sns"
    STEP_FUNCTIONS = "stepfunctions"
    SSM = "ssm"
    SECRETS_MANAGER = "secretsmanager"
    EVENTS = "events"
    API_GATEWAY = "apigateway"


class LifecycleDwell:
    """Pre-defined dwell time presets (in milliseconds) for lifecycle simulation.

    Pass these to :meth:`~lws_testing._builders.lifecycle.LifecycleBuilder.create_dwell_ms`
    or :meth:`~lws_testing._builders.lifecycle.LifecycleBuilder.delete_dwell_ms`.

    Usage::

        session.lifecycle(Service.DYNAMODB)
            .create_dwell_ms(LifecycleDwell.TYPICAL)
            .delete_dwell_ms(LifecycleDwell.FAST)
            .apply()
    """

    INSTANT = 0
    FAST = 100
    TYPICAL = 500
    SLOW = 2000
    VERY_SLOW = 10_000
