"""Given: a "SNS" notification is configured on the "glacier" "vault" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "SNS" notification is configured on the "glacier" "vault"')
def glacier_sns_seq_notification_configured():
    pytest.skip("Cannot configure Glacier vault notifications in lws")
