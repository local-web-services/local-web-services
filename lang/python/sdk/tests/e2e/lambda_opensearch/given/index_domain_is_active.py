"""Given: the index's domain was "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "opensearch" "index"\'s domain was "ACTIVE"')
def index_domain_is_active():
    pytest.skip("Cannot set up OpenSearch index with active domain in lws")
