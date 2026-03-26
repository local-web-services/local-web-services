"""Given: the index's domain is "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the index\'s domain is "ACTIVE"')
def index_domain_is_active():
    pytest.skip("Cannot set up OpenSearch index with active domain in lws")
