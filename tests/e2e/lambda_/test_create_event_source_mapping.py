"""E2E test for Lambda create-event-source-mapping CLI command."""

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestCreateEventSourceMapping:
    def test_create_list_delete_event_source_mapping(self, e2e_port, parse_output, assert_invoke):
        # Arrange
        expected_function_name = "e2e-esm-function"
        expected_arn = "arn:aws:sqs:us-east-1:000000000000:e2e-esm-queue"
        expected_batch_size = 5

        # Act - create
        create_result = runner.invoke(
            app,
            [
                "lambda",
                "create-event-source-mapping",
                "--function-name",
                expected_function_name,
                "--event-source-arn",
                expected_arn,
                "--batch-size",
                str(expected_batch_size),
                "--port",
                str(e2e_port),
            ],
        )

        # Assert - create succeeded
        assert create_result.exit_code == 0, create_result.output
        created = parse_output(create_result.output)
        esm_uuid = created["UUID"]
        assert esm_uuid

        # Assert - list contains the mapping
        list_body = assert_invoke(["lambda", "list-event-source-mappings", "--port", str(e2e_port)])
        actual_uuids = [m["UUID"] for m in list_body["EventSourceMappings"]]
        assert esm_uuid in actual_uuids

        # Act - delete
        delete_result = runner.invoke(
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

        # Assert - delete succeeded
        assert delete_result.exit_code == 0, delete_result.output
