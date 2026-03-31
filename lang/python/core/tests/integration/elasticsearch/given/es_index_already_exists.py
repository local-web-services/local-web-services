"""Given: the "elasticsearch" "index" already existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticsearch" "index" already existed')
def es_index_already_exists(world):
    pytest.skip("Index management is not available in the core Elasticsearch integration API.")
