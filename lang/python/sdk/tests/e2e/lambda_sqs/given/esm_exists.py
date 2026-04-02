"""Given: the "lambda" "event source mapping" existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "event source mapping" existed')
def esm_exists():
    pytest.skip("Cannot pre-create event source mapping in lws")
