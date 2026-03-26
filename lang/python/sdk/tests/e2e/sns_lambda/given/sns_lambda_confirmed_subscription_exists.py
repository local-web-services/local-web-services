"""Given: a confirmed subscription exists for the topic"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a confirmed subscription exists for the topic")
def sns_lambda_confirmed_subscription_exists():
    pytest.skip("Cannot configure SNS subscription to Lambda in lws")
