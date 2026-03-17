"""
BDD test suite running the canonical example feature files via pytest-bdd.

Step definitions are in conftest.py. Feature files live at the shared
specification path so all four SDK implementations run the same scenarios.
"""

from pytest_bdd import scenarios

scenarios(
    "../../../../specification/example/features/run_state_machine.feature",
    "../../../../specification/example/features/fake.feature",
    "../../../../specification/example/features/chaos.feature",
    "../../../../specification/example/features/iam.feature",
    "../../../../specification/example/features/reset.feature",
    "../../../../specification/example/features/log_capture.feature",
    "../../../../specification/example/features/dynamodb_helper.feature",
    "../../../../specification/example/features/sqs_helper.feature",
    "../../../../specification/example/features/hcl_discovery.feature",
)
