"""Given: the subscription is not "CONFIRMED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the subscription is not "CONFIRMED"')
def subscription_is_not_confirmed_given():
    pytest.skip(
        "Cannot reliably produce a non-CONFIRMED subscription without external confirmation flow"
    )
