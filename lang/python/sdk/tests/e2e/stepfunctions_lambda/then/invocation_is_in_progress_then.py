"""Then: the invocation will be "IN_PROGRESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation will be "IN_PROGRESS"')
def invocation_is_in_progress_then():
    pytest.skip("Cannot observe internal Lambda invocation IN_PROGRESS state in lws")
