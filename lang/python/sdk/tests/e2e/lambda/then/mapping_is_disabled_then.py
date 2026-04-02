"""Then: mapping_is_disabled_then"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "lambda" "event source mapping" will be "DISABLED" and inactive')
def mapping_is_disabled_then(world):
    pytest.skip("Cannot observe ESM DISABLED state in lws")
