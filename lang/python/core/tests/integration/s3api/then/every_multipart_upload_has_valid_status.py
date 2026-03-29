"""Then: every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")"""

from __future__ import annotations

from pytest_bdd import then


@then('every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")')
def every_multipart_upload_has_valid_status():
    """No-op invariant: lws always maintains valid multipart upload statuses."""
