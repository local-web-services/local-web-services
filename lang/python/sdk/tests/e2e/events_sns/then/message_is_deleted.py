"""Then: the "sns" "message" will be "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "sns" "message" will be "DELETED"')
def message_is_deleted(world):
    pytest.skip("Cannot observe message deletion from SNS in lws")
