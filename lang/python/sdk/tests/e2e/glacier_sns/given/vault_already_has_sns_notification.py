"""Given: the vault already has an "SNS" notification configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the vault already has an "SNS" notification configured')
def vault_already_has_sns_notification():
    pytest.skip("Cannot configure Glacier vault notifications in lws")
