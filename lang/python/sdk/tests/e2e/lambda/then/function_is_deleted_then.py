"""Then: function_is_deleted_then"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "lambda" "function" will be "DELETED"')
def function_is_deleted_then(world):
    pytest.skip("Cannot observe Lambda DELETED state in lws")
