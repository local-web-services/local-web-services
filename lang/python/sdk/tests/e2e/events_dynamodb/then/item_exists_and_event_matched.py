"""Then: the item will exist in the "dynamodb" "table" and the event will be recorded as "MATCHED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the item will exist in the "dynamodb" "table" and the event will be recorded as "MATCHED"')
def item_exists_and_event_matched(world):
    pytest.skip("Cannot observe internal event routing result in lws")
