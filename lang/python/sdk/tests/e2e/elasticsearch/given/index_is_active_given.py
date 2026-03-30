"""Given: the index is "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the index is "ACTIVE"')
def index_is_active_given():
    pytest.skip("Cannot observe index ACTIVE state without connecting to endpoint in lws")
