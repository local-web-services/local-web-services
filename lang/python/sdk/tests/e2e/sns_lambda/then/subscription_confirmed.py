"""Then: the subscription is "CONFIRMED" and the function will be invoked on published messages"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the subscription is "CONFIRMED" and the function will be invoked on published messages')
def subscription_confirmed():
    pytest.skip("Cannot configure SNS subscription to Lambda in lws")
