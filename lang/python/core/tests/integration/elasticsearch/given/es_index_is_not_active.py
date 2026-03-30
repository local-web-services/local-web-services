"""Given: the index is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the index is not "ACTIVE"')
def es_index_is_not_active(world):
    pytest.skip("Index management is not available in the core Elasticsearch integration API.")
