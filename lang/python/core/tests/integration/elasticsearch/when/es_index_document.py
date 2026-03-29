"""When: a document is indexed in an active index"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("a document is indexed in an active index")
def es_index_document(client: TestClient, world: dict):
    pytest.skip("Document indexing is not available in the core Elasticsearch integration API.")
