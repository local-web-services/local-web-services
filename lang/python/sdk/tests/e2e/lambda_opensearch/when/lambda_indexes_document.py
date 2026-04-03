"""When: the "lambda" "function" indexes a document into the OpenSearch index during invocation"""

from __future__ import annotations

from pytest_bdd import when


@when('the "lambda" "function" indexes a document into the OpenSearch index during invocation')
def lambda_indexes_document(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    # Act
    try:
        if not invocation_id:
            raise RuntimeError("No invocation is IN_PROGRESS")
        if not world.get("opensearch_index_exists", False):
            raise RuntimeError("OpenSearch index does not exist")
        if lws_session.capacity("opensearch").is_exhausted():
            raise RuntimeError("No document slot is available")
        lws_session.inject_state_unchecked("lambda", "invocation", invocation_id, "SUCCESS")
        world["error"] = None
    except Exception as exc:
        world["error"] = exc
