"""Then: the "s3 tables" "namespace" will be deleted and all its tables will be deleted"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_BUCKET, INT_NAMESPACE


@then('the "s3 tables" "namespace" will be deleted and all its tables will be deleted')
def namespace_is_deleted_and_tables_deleted(client: TestClient):
    r = client.get(f"/namespaces/{INT_BUCKET}")
    actual_namespaces = [ns["namespace"] for ns in r.json().get("namespaces", [])]
    expected_namespace = [INT_NAMESPACE]
    assert (
        expected_namespace not in actual_namespaces
    ), f"Expected namespace '{expected_namespace}' to be deleted but found in: {actual_namespaces}"
