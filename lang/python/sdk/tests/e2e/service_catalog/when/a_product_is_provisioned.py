"""When: a product is provisioned"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ServiceCatalogTestClient
from ..constants import TEST_PRODUCT_ID


@when("a product is provisioned")
@when('a "service catalog" "product" is provisioned')
def a_product_is_provisioned(lws_session, world):
    """Call ProvisionProduct with the product ID from world (set by given steps)."""
    client = ServiceCatalogTestClient(lws_session)
    product_id = world.get("product_id", TEST_PRODUCT_ID)
    try:
        result = client.provision_product(product_id=product_id)
        world["result"] = result
        world["error"] = None
    except ClientError as exc:
        world["result"] = None
        world["error"] = exc
