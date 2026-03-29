"""Given: the index already exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the index already exists")
def index_already_exists():
    pytest.skip("Cannot pre-create OpenSearch index in lws")
