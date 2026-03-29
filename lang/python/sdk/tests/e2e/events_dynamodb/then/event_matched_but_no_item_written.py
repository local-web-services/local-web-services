"""Then: the event is "MATCHED" but no item is written"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the event is "MATCHED" but no item is written')
def event_matched_but_no_item_written(world):
    pytest.skip("Cannot observe internal event matching state in lws")
