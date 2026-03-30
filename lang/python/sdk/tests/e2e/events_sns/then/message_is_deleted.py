"""Then: the message is "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the message is "DELETED"')
def message_is_deleted(world):
    pytest.skip("Cannot observe message deletion from SNS in lws")
