"""Given: the "opensearch" "index" already existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "opensearch" "index" already existed')
def index_already_exists():
    pytest.skip("Cannot pre-create OpenSearch index in lws")
