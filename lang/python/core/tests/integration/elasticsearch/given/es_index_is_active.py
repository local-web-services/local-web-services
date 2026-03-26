"""Given: the index is "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the index is "ACTIVE"')
def es_index_is_active(world):
    pytest.skip("Index management is not available in the core Elasticsearch integration API.")
