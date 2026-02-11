from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestHeadBucket:
    def test_head_bucket(self, e2e_port, lws_invoke):
        # Arrange
        bucket_name = "e2e-head-bkt"
        lws_invoke(["s3api", "create-bucket", "--bucket", bucket_name, "--port", str(e2e_port)])

        # Act
        result = runner.invoke(
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

        # Assert
        assert result.exit_code == 0, result.output
