"""Then: function_becomes_active_or_failed"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "lambda" "function" becomes "ACTIVE" or "FAILED" non-deterministically')
def function_becomes_active_or_failed(world):
    pytest.skip("Cannot observe Lambda PENDING resolution in lws")
