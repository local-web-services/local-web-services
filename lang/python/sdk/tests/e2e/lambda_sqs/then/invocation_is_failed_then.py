"""Then: the invocation is "FAILED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation is "FAILED"')
def invocation_is_failed_then(world):
    pytest.skip("Cannot observe Lambda invocation failure in lws")
