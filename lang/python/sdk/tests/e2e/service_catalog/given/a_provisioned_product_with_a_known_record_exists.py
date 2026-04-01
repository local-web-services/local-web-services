"""Given: a provisioned product with a known record exists"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import given

from ..client import ServiceCatalogTestClient


@given("a provisioned product with a known record exists")
def a_provisioned_product_with_a_known_record_exists(lws_session, world):
    """Provision a product and store the RecordId for later steps."""
    client = ServiceCatalogTestClient(lws_session)
    try:
        result = client.provision_product()
        world["record_id"] = result["RecordDetail"]["RecordId"]
        world["error"] = None
    except ClientError as exc:
        world["record_id"] = None
        world["error"] = exc
