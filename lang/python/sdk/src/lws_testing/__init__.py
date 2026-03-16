"""local-web-services testing SDK.

In-process pytest fixtures and boto3 helpers for testing AWS applications
against real LWS service implementations without needing a running ldk dev.

Usage::

    from lws_testing import LwsSession, DynamoTable, SqsQueue

    # Typed resource specs (recommended)
    with LwsSession(
        DynamoTable("Orders", hash_key="id"),
        SqsQueue("OrderQueue"),
    ) as session: ...

    # Auto-detect CDK or HCL project in current directory
    with LwsSession.from_cdk("../") as session: ...
    with LwsSession.from_hcl("../") as session: ...

    # Legacy dict-based resource declaration (still supported)
    with LwsSession(
        tables=[{"name": "Orders", "partition_key": "id"}],
        queues=["OrderQueue"],
        buckets=["ReceiptsBucket"],
    ) as session: ...
"""

from __future__ import annotations

from lws_testing._spec import (
    DynamoTable,
    S3Bucket,
    Secret,
    SnsTopic,
    SqsQueue,
    SsmParameter,
    StateMachine,
)
from lws_testing.services import LifecycleDwell, Service
from lws_testing.session import LwsSession

__all__ = [
    "LwsSession",
    "DynamoTable",
    "SqsQueue",
    "S3Bucket",
    "SnsTopic",
    "SsmParameter",
    "Secret",
    "StateMachine",
    "Service",
    "LifecycleDwell",
]
