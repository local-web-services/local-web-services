"""Given: the "glacier" "vault" has a "SNS" notification configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "glacier" "vault" has a "SNS" notification configured')
def vault_has_sns_notification():
    pytest.skip("Cannot configure Glacier vault notifications in lws")
