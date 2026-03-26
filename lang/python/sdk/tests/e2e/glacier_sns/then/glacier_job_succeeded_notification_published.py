"""Then: the job is "SUCCEEDED" and the notification is "PUBLISHED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the job is "SUCCEEDED" and the notification is "PUBLISHED"')
def glacier_job_succeeded_notification_published():
    pytest.skip("Cannot trigger internal Glacier->SNS notification in lws")
