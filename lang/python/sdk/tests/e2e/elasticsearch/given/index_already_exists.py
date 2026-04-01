"""Given: the "elasticsearch" "index" already existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticsearch" "index" already existed')
def index_already_exists():
    pytest.skip("Cannot create an index without connecting to the Elasticsearch endpoint in lws")
