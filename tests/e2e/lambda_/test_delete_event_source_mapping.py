"""E2E test for Lambda delete-event-source-mapping CLI command."""

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestDeleteEventSourceMapping:
    def test_create_then_delete_event_source_mapping(self, e2e_port, lws_invoke, parse_output):
        # Arrange
        expected_function_name = "e2e-del-esm-fn"
        expected_arn = "arn:aws:sqs:us-east-1:000000000000:e2e-del-esm-queue"
        create_body = lws_invoke(
            [
                "lambda",
                "create-event-source-mapping",
                "--function-name",
                expected_function_name,
                "--event-source-arn",
                expected_arn,
                "--port",
                str(e2e_port),
            ]
        )
        esm_uuid = create_body["UUID"]

        # Act
        result = runner.invoke(
            app,
            [
                "lambda",
                "delete-event-source-mapping",
                "--uuid",
                esm_uuid,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
