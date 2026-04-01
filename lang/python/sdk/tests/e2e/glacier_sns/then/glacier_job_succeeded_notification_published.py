"""Then: the "glacier" "job" will be "SUCCEEDED" and the notification will be "PUBLISHED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "glacier" "job" will be "SUCCEEDED" and the notification will be "PUBLISHED"')
def glacier_job_succeeded_notification_published():
    pytest.skip("Cannot trigger internal Glacier->SNS notification in lws")
