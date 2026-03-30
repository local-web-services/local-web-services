"""Given: did in delivery_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("did in delivery_status")
def sns_did_in_delivery_status():
    pytest.skip("Cannot pre-set SNS delivery status in sequence setup")
