"""Then: the invocation is "IN_PROGRESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation is "IN_PROGRESS"')
def invocation_is_in_progress_then(world):
    pytest.skip("Cannot observe Lambda invocation state in lws")
