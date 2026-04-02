"""Then: mapping_in_creating_state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'the "lambda" "event source mapping" will be in "CREATING" state and linked to a "lambda" "function"'
)
def mapping_in_creating_state(world):
    pytest.skip("Cannot observe ESM CREATING state in lws")
