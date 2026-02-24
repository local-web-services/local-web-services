"""local-web-services testing SDK.

In-process pytest fixtures and boto3 helpers for testing AWS applications
against real LWS service implementations without needing a running ldk dev.

Usage::

    from lws_testing import LwsSession

    # Auto-detect CDK or HCL project in current directory
    with LwsSession.from_cdk("../") as session: ...
    with LwsSession.from_hcl("../") as session: ...

    # Explicit resource declaration
    with LwsSession(
        tables=[{"name": "Orders", "partition_key": "id"}],
        queues=["OrderQueue"],
        buckets=["ReceiptsBucket"],
    ) as session: ...
"""

from __future__ import annotations

from lws_testing.session import LwsSession

__all__ = ["LwsSession"]
