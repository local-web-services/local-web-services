"""Then: the invocation is "SUCCESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation is "SUCCESS"')
def invocation_is_success_then(world):
    pytest.skip("Cannot observe Lambda invocation success in lws")
