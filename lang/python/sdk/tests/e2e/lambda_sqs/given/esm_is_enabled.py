"""Given: the event source mapping is "ENABLED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the event source mapping is "ENABLED"')
def esm_is_enabled():
    pytest.skip("Cannot pre-create event source mapping in lws")
