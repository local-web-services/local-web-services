"""Given: mapping_is_not_creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "event source mapping" was not "CREATING"')
def mapping_is_not_creating():
    pytest.skip("Cannot observe ESM state transitions in lws")
