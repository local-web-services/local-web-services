"""Given: the event source mapping was not "ENABLED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the event source mapping was not "ENABLED"')
def esm_is_not_enabled():
    pytest.skip("Cannot pre-create disabled event source mapping in lws")
