"""Given: the "elasticsearch" "index" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticsearch" "index" was not "ACTIVE"')
def index_is_not_active_given():
    pytest.skip("Cannot control index activity state in lws")
