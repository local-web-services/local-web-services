"""Then: the event is "PUBLISHED" and the invocation is "SUCCESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the event is "PUBLISHED" and the invocation is "SUCCESS"')
def event_published_invocation_success(world):
    pytest.skip("Cannot observe Lambda invocation result in lws")
