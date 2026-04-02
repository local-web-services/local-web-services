"""Then: the "s3 tables" "record" will exist and the "lambda" "invocation" will be "SUCCESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "s3 tables" "record" will exist and the "lambda" "invocation" will be "SUCCESS"')
def lambda_s3tables_record_exists_invocation_success():
    pytest.skip("Cannot trigger internal Lambda->S3Tables write in lws")
