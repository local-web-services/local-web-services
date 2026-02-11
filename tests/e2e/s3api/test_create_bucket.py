from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestCreateBucket:
    def test_create_bucket(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        bucket_name = "e2e-create-bkt"

        # Act
        result = runner.invoke(
            app,
            [
                "s3api",
                "create-bucket",
                "--bucket",
                bucket_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify_result = runner.invoke(
            app,
            [
                "s3api",
                "head-bucket",
                "--bucket",
                bucket_name,
                "--port",
                str(e2e_port),
            ],
        )
        assert verify_result.exit_code == 0, verify_result.output
