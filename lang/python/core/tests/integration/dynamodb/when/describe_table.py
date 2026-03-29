"""When: a table is described"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import TEST_TABLE, _store


@when("a table is described")
def describe_table(client: TestClient, world: dict):
    r = DynamodbTestClient(client).post("DescribeTable", {"TableName": TEST_TABLE})
    _store(world, r)
