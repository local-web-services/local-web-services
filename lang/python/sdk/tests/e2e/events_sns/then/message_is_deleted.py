"""Then: the message will be deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the message will be deleted")
def message_is_deleted(world):
    pytest.skip("Cannot observe message deletion from SNS in lws")
