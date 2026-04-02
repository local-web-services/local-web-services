"""Given: mapping_is_not_enabled"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "event source mapping" was not "ENABLED"')
def mapping_is_not_enabled():
    pytest.skip("Cannot observe ESM state in lws without real event source")
