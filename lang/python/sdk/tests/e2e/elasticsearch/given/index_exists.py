"""Given: the "elasticsearch" "index" existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticsearch" "index" existed')
def index_exists():
    pytest.skip("Cannot create an index without connecting to the Elasticsearch endpoint in lws")
