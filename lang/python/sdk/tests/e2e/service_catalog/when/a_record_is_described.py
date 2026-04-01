"""When: a record is described"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ServiceCatalogTestClient


@when("a record is described")
def a_record_is_described(lws_session, world):
    """Call DescribeRecord with the record ID from world (set by given steps)."""
    client = ServiceCatalogTestClient(lws_session)
    record_id = world.get("record_id", "rec-missing")
    try:
        result = client.describe_record(record_id=record_id)
        world["result"] = result
        world["error"] = None
    except ClientError as exc:
        world["result"] = None
        world["error"] = exc
