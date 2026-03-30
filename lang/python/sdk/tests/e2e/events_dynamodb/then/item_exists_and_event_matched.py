"""Then: the item "EXISTS" in the table and the event is recorded as "MATCHED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the item "EXISTS" in the table and the event is recorded as "MATCHED"')
def item_exists_and_event_matched(world):
    pytest.skip("Cannot observe internal event routing result in lws")
