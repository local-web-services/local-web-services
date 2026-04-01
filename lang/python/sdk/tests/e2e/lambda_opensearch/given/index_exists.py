"""Given: the "opensearch" "index" existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "opensearch" "index" existed')
def index_exists():
    pytest.skip("Cannot pre-create OpenSearch index in lws")
