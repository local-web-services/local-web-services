"""When: a "SNS" notification is configured on the "glacier" "vault" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "SNS" notification is configured on the "glacier" "vault"')
def configure_sns_notification_on_vault(world):
    pytest.skip("Cannot configure Glacier vault notifications in lws")
