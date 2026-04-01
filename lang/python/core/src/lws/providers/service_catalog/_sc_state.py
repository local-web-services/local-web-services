"""AWS Service Catalog in-memory state classes."""

from __future__ import annotations

import time

_DEFAULT_PRODUCT_ID = "prod-e2etest0"
_DEFAULT_ARTIFACT_ID = "pa-e2etest00"
_DEFAULT_LAUNCH_PATH_ID = "lp-e2etest00"
_DEFAULT_PRODUCT_NAME = "e2e-test-product-1"


class _ProvisioningArtifact:
    """A single provisioning artifact (template version) for a product."""

    def __init__(self, artifact_id: str, name: str) -> None:
        """Initialise the artifact."""
        self.artifact_id = artifact_id
        self.name = name
        self.description = ""
        self.created_time = time.time()
        self.artifact_type = "CLOUD_FORMATION_TEMPLATE"


class _Product:
    """A Service Catalog product."""

    def __init__(
        self,
        product_id: str,
        name: str,
        description: str = "",
        artifact_id: str | None = None,
        launch_path_id: str | None = None,
    ) -> None:
        """Initialise the product."""
        self.product_id = product_id
        self.name = name
        self.description = description
        self.owner = "local"
        self.created_time = time.time()
        self.launch_path_id = launch_path_id or ("lp-" + product_id[5:])
        self.artifacts: list[_ProvisioningArtifact] = [
            _ProvisioningArtifact(artifact_id or ("pa-" + product_id[5:]), "v1")
        ]


class _Record:
    """A provisioned product record."""

    def __init__(self, record_id: str, provisioned_product_id: str, product_id: str) -> None:
        """Initialise the record."""
        self.record_id = record_id
        self.provisioned_product_id = provisioned_product_id
        self.product_id = product_id
        self.status = "SUCCEEDED"
        self.created_time = time.time()


class _ScState:
    """In-memory store for AWS Service Catalog resources."""

    def __init__(self) -> None:
        """Initialise state with a default test product."""
        self._products: dict[str, _Product] = {}
        self._records: dict[str, _Record] = {}
        self._seed_default_product()

    def _seed_default_product(self) -> None:
        """Seed the catalogue with a default test product."""
        product = _Product(
            _DEFAULT_PRODUCT_ID,
            _DEFAULT_PRODUCT_NAME,
            artifact_id=_DEFAULT_ARTIFACT_ID,
            launch_path_id=_DEFAULT_LAUNCH_PATH_ID,
        )
        self._products[product.product_id] = product

    @property
    def products(self) -> dict[str, _Product]:
        """Return the products store keyed by product ID."""
        return self._products

    @property
    def records(self) -> dict[str, _Record]:
        """Return the records store keyed by record ID."""
        return self._records

    def reset(self) -> None:
        """Reset all state and re-seed the default product."""
        self._products = {}
        self._records = {}
        self._seed_default_product()
