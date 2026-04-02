"""Test client for Service Catalog e2e tests."""

from __future__ import annotations

from botocore.exceptions import ClientError

from .constants import TEST_ARTIFACT_ID, TEST_PRODUCT_ID, TEST_PROVISIONED_PRODUCT_NAME


class ServiceCatalogTestClient:
    """Helper client for Service Catalog BDD steps."""

    def __init__(self, lws_session) -> None:
        self._client = lws_session.client("servicecatalog")

    def provision_product(self, product_id: str = TEST_PRODUCT_ID) -> dict:
        """Provision a product and return the full response."""
        try:
            return self._client.provision_product(
                ProductId=product_id,
                ProvisioningArtifactId=TEST_ARTIFACT_ID,
                ProvisionedProductName=TEST_PROVISIONED_PRODUCT_NAME,
            )
        except ClientError:
            raise

    def describe_record(self, record_id: str) -> dict:
        """Describe a record and return the full response."""
        return self._client.describe_record(Id=record_id)
