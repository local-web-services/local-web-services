"""E2E test for S3 abort-multipart-upload CLI command."""

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestAbortMultipartUpload:
    def test_abort_multipart_upload(self, e2e_port, lws_invoke):
        # Arrange
        bucket = "e2e-abort-mp"
        key = "e2e-abort.bin"
        lws_invoke(["s3api", "create-bucket", "--bucket", bucket, "--port", str(e2e_port)])
        create_body = lws_invoke(
            [
                "s3api",
                "create-multipart-upload",
                "--bucket",
                bucket,
                "--key",
                key,
                "--port",
                str(e2e_port),
            ]
        )
        upload_id = create_body["InitiateMultipartUploadResult"]["UploadId"]

        # Act
        result = runner.invoke(
            app,
            [
                "s3api",
                "abort-multipart-upload",
                "--bucket",
                bucket,
                "--key",
                key,
                "--upload-id",
                upload_id,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
