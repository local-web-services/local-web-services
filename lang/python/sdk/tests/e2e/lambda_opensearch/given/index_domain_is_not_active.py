"""Given: the index's domain is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the index\'s domain is not "ACTIVE"')
def index_domain_is_not_active():
    pytest.skip("Cannot set up OpenSearch index with non-active domain in lws")
