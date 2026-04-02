"""Given: mapping_is_enabled"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "event source mapping" was "ENABLED"')
def mapping_is_enabled():
    pytest.skip("Cannot observe ESM ENABLED state in lws without real event source")
