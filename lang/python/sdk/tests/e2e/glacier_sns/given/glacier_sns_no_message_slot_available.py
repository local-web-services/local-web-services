"""Given: no "sns" "message" "slot" was "available" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no "sns" "message" "slot" was "available"')
def glacier_sns_no_message_slot_available():
    pytest.skip("Cannot configure Glacier vault notifications in lws")
