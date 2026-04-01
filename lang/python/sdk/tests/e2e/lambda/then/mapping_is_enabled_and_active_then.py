"""Then: mapping_is_enabled_and_active_then"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the mapping will be "ENABLED" and active')
def mapping_is_enabled_and_active_then(world):
    pytest.skip("Cannot observe ESM ENABLED state in lws")
