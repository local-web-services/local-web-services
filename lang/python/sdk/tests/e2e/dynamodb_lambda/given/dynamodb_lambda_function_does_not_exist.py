"""Given: the function does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the function does not exist")
def dynamodb_lambda_function_does_not_exist(world):
    world["_skip"] = (
        "lws does not reject create_event_source_mapping when the Lambda function does not exist"
    )
