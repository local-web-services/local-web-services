"""Given: the index already exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the index already exists")
def es_index_already_exists(world):
    pytest.skip("Index management is not available in the core Elasticsearch integration API.")
