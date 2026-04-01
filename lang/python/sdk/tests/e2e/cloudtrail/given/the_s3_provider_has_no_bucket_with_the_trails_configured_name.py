"""Given: the S3 provider has no bucket with the trail's configured name"""

from __future__ import annotations

from pytest_bdd import given


@given("the S3 provider has no bucket with the trail's configured name")
def the_s3_provider_has_no_bucket_with_the_trails_configured_name():
    """No-op: reset ensures no S3 buckets exist before each scenario."""
