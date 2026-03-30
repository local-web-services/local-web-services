"""Given: the index exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the index exists")
def index_exists():
    pytest.skip("Cannot pre-create OpenSearch index in lws")
