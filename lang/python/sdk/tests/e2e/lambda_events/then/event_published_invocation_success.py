"""Then: the event will be "PUBLISHED" and the invocation will be "SUCCESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the event will be "PUBLISHED" and the invocation will be "SUCCESS"')
def event_published_invocation_success(world):
    pytest.skip("Cannot observe Lambda invocation result in lws")
