"""Given: no "sns" "subscription" was "CONFIRMED" for the "sns" "topic" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "sns" "subscription" was "CONFIRMED" for the "sns" "topic"')
def sns_lambda_confirmed_subscription_exists():
    pytest.skip("Cannot configure SNS subscription to Lambda in lws")
