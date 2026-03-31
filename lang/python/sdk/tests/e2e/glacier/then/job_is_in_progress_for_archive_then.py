"""Then: the "glacier" "JOB" will be "InProgress" for the given archive"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "glacier" "JOB" will be "InProgress" for the given archive')
def job_is_in_progress_for_archive_then():
    pytest.skip("Cannot observe InProgress job state for archive in lws")
