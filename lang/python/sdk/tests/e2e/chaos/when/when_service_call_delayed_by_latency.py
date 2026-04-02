"""When: a "service" call is delayed by "chaos" "latency" injection"""

from __future__ import annotations

from pytest_bdd import when


@when('a "service" call is delayed by "chaos" "latency" injection')
def when_service_call_delayed_by_latency(lws_session, world):
    """Attempt a service call expected to be delayed by chaos latency injection."""
    import boto3
    import botocore.config

    port = lws_session._ports.get("dynamodb", lws_session._mgmt_port)
    client = boto3.client(
        "dynamodb",
        region_name="us-east-1",
        endpoint_url=f"http://127.0.0.1:{port}",
        aws_access_key_id="test",
        aws_secret_access_key="test",
        config=botocore.config.Config(retries={"max_attempts": 1}),
    )
    try:
        world["result"] = client.list_tables()
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
