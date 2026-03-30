"""Given: an "SNS" notification has been configured on the vault"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "SNS" notification has been configured on the vault')
def glacier_sns_seq_notification_configured():
    pytest.skip("Cannot configure Glacier vault notifications in lws")
