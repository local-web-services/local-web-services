"""When: the "lambda" "function" fails to write because the table is being deleted"""

from __future__ import annotations

from pytest_bdd import when


@when('the "lambda" "function" fails to write because the table is being deleted')
def lambda_s3tables_function_fails_write_table_deleting(world):
    world["result"] = None
    world["error"] = RuntimeError(
        "Cannot trigger internal Lambda->S3Tables write failure in lws: "
        "table deletion write failures are not observable via the lws API."
    )
