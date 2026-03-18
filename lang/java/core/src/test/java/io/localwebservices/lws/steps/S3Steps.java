package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.*;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.io.File;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.*;

public class S3Steps {

  private final WorldContext world;
  private byte[] lastDownloadedContent;
  private File tempFile;

  public S3Steps(WorldContext world) {
    this.world = world;
  }

  @Given("a bucket {string} was created")
  public void aBucketWasCreated(String bucket) {
    try (S3Client client = world.s3Client()) {
      try {
        client.createBucket(r -> r.bucket(bucket));
      } catch (Exception ignored) {
      }
    }
  }

  @Given("an object {string} was put into bucket {string} with content {string}")
  public void anObjectWasPutIntoBucketWithContent(String key, String bucket, String content) {
    try (S3Client client = world.s3Client()) {
      client.putObject(
          r -> r.bucket(bucket).key(key),
          RequestBody.fromBytes(content.getBytes(StandardCharsets.UTF_8)));
    }
  }

  @Given("a multipart upload was created for key {string} in bucket {string}")
  public void aMultipartUploadWasCreatedForKeyInBucket(String key, String bucket) {
    try (S3Client client = world.s3Client()) {
      CreateMultipartUploadResponse r =
          client.createMultipartUpload(req -> req.bucket(bucket).key(key));
      world.lastUploadId = r.uploadId();
      world.lastBucket = bucket;
      world.lastKey = key;
    }
  }

  @Given("a policy was set on bucket {string}")
  public void aPolicyWasSetOnBucket(String bucket) {
    try (S3Client client = world.s3Client()) {
      client.putBucketPolicy(
          r -> r.bucket(bucket).policy("{\"Version\":\"2012-10-17\",\"Statement\":[]}"));
    }
  }

  @Given("a file was created with content {string}")
  public void aFileWasCreatedWithContent(String content) throws Exception {
    tempFile = File.createTempFile("lws-test-", ".txt");
    tempFile.deleteOnExit();
    Files.write(tempFile.toPath(), content.getBytes(StandardCharsets.UTF_8));
  }

  @Given("part {int} with content {string} was uploaded")
  public void partWithContentWasUploaded(int partNumber, String content) {
    try (S3Client client = world.s3Client()) {
      byte[] bytes = content.getBytes(StandardCharsets.UTF_8);
      UploadPartResponse r =
          client.uploadPart(
              req ->
                  req.bucket(world.lastBucket)
                      .key(world.lastKey)
                      .uploadId(world.lastUploadId)
                      .partNumber(partNumber),
              RequestBody.fromBytes(bytes));
      world.lastETag = r.eTag();
    }
  }

  @Given("tags were set on bucket {string} with key {string} and value {string}")
  public void tagsWereSetOnBucketWithKeyAndValue(String bucket, String key, String value) {
    try (S3Client client = world.s3Client()) {
      client.putBucketTagging(
          r ->
              r.bucket(bucket)
                  .tagging(
                      Tagging.builder()
                          .tagSet(Tag.builder().key(key).value(value).build())
                          .build()));
    }
  }

  @Given("website configuration was set on bucket {string} with index {string}")
  public void websiteConfigurationWasSetOnBucketWithIndex(String bucket, String index) {
    try (S3Client client = world.s3Client()) {
      client.putBucketWebsite(
          r ->
              r.bucket(bucket)
                  .websiteConfiguration(
                      WebsiteConfiguration.builder().indexDocument(i -> i.suffix(index)).build()));
    }
  }

  @When("I create bucket {string}")
  public void iCreateBucket(String bucket) {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(client.createBucket(r -> r.bucket(bucket)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I delete bucket {string}")
  public void iDeleteBucket(String bucket) {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(client.deleteBucket(r -> r.bucket(bucket)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I head bucket {string}")
  public void iHeadBucket(String bucket) {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(client.headBucket(r -> r.bucket(bucket)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I list buckets")
  public void iListBuckets() {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(client.listBuckets());
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I list S3 buckets")
  public void iListS3Buckets() {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(client.listBuckets());
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I list S3 buckets with timing")
  public void iListS3BucketsWithTiming() {
    long start = System.currentTimeMillis();
    try (S3Client client = world.s3Client()) {
      world.timedOutput = client.listBuckets();
      world.timedSuccess = true;
    } catch (Exception e) {
      world.timedSuccess = false;
      world.timedOutput = e;
    } finally {
      world.timedElapsedMs = System.currentTimeMillis() - start;
    }
  }

  @When("I list objects in bucket {string}")
  public void iListObjectsInBucket(String bucket) {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(client.listObjectsV2(r -> r.bucket(bucket)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I get object {string} from bucket {string}")
  public void iGetObjectFromBucket(String key, String bucket) {
    try (S3Client client = world.s3Client()) {
      lastDownloadedContent = client.getObjectAsBytes(r -> r.bucket(bucket).key(key)).asByteArray();
      world.setSuccess(lastDownloadedContent);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I put object {string} into bucket {string} from the file")
  public void iPutObjectIntoBucketFromTheFile(String key, String bucket) {
    try (S3Client client = world.s3Client()) {
      byte[] content = tempFile != null ? Files.readAllBytes(tempFile.toPath()) : new byte[0];
      world.setSuccess(
          client.putObject(r -> r.bucket(bucket).key(key), RequestBody.fromBytes(content)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I head object {string} in bucket {string}")
  public void iHeadObjectInBucket(String key, String bucket) {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(client.headObject(r -> r.bucket(bucket).key(key)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I delete object {string} from bucket {string}")
  public void iDeleteObjectFromBucket(String key, String bucket) {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(client.deleteObject(r -> r.bucket(bucket).key(key)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I delete objects {string} and {string} from bucket {string}")
  public void iDeleteObjectsAndFromBucket(String key1, String key2, String bucket) {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(
          client.deleteObjects(
              r ->
                  r.bucket(bucket)
                      .delete(
                          d ->
                              d.objects(
                                  ObjectIdentifier.builder().key(key1).build(),
                                  ObjectIdentifier.builder().key(key2).build()))));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I copy object {string} in bucket {string} from source {string}")
  public void iCopyObjectInBucketFromSource(String destKey, String bucket, String source) {
    // source is in format "sourceBucket/sourceKey"
    int slash = source.indexOf('/');
    String sourceBucket = slash >= 0 ? source.substring(0, slash) : bucket;
    String sourceKey = slash >= 0 ? source.substring(slash + 1) : source;
    try (S3Client client = world.s3Client()) {
      world.setSuccess(
          client.copyObject(
              r ->
                  r.sourceBucket(sourceBucket)
                      .sourceKey(sourceKey)
                      .destinationBucket(bucket)
                      .destinationKey(destKey)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I get the location of bucket {string}")
  public void iGetTheLocationOfBucket(String bucket) {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(client.getBucketLocation(r -> r.bucket(bucket)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I get tags from bucket {string}")
  public void iGetTagsFromBucket(String bucket) {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(client.getBucketTagging(r -> r.bucket(bucket)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I put tags on bucket {string} with key {string} and value {string}")
  public void iPutTagsOnBucketWithKeyAndValue(String bucket, String key, String value) {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(
          client.putBucketTagging(
              r ->
                  r.bucket(bucket)
                      .tagging(
                          Tagging.builder()
                              .tagSet(Tag.builder().key(key).value(value).build())
                              .build())));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I delete tags from bucket {string}")
  public void iDeleteTagsFromBucket(String bucket) {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(client.deleteBucketTagging(r -> r.bucket(bucket)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I get the policy of bucket {string}")
  public void iGetThePolicyOfBucket(String bucket) {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(client.getBucketPolicy(r -> r.bucket(bucket)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I put a policy on bucket {string}")
  public void iPutAPolicyOnBucket(String bucket) {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(
          client.putBucketPolicy(
              r -> r.bucket(bucket).policy("{\"Version\":\"2012-10-17\",\"Statement\":[]}")));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I get the notification configuration of bucket {string}")
  public void iGetTheNotificationConfigurationOfBucket(String bucket) {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(client.getBucketNotificationConfiguration(r -> r.bucket(bucket)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I put a notification configuration on bucket {string}")
  public void iPutANotificationConfigurationOnBucket(String bucket) {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(
          client.putBucketNotificationConfiguration(
              r ->
                  r.bucket(bucket)
                      .notificationConfiguration(NotificationConfiguration.builder().build())));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I get website configuration from bucket {string}")
  public void iGetWebsiteConfigurationFromBucket(String bucket) {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(client.getBucketWebsite(r -> r.bucket(bucket)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I put website configuration on bucket {string} with index {string}")
  public void iPutWebsiteConfigurationOnBucketWithIndex(String bucket, String index) {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(
          client.putBucketWebsite(
              r ->
                  r.bucket(bucket)
                      .websiteConfiguration(
                          WebsiteConfiguration.builder()
                              .indexDocument(i -> i.suffix(index))
                              .build())));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I delete website configuration from bucket {string}")
  public void iDeleteWebsiteConfigurationFromBucket(String bucket) {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(client.deleteBucketWebsite(r -> r.bucket(bucket)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I create a multipart upload for key {string} in bucket {string}")
  public void iCreateAMultipartUploadForKeyInBucket(String key, String bucket) {
    try (S3Client client = world.s3Client()) {
      CreateMultipartUploadResponse r =
          client.createMultipartUpload(req -> req.bucket(bucket).key(key));
      world.lastUploadId = r.uploadId();
      world.lastBucket = bucket;
      world.lastKey = key;
      world.setSuccess(r);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I upload part 1 with content {string}")
  public void iUploadPart1WithContent(String content) {
    try (S3Client client = world.s3Client()) {
      byte[] bytes = content.getBytes(StandardCharsets.UTF_8);
      UploadPartResponse r =
          client.uploadPart(
              req ->
                  req.bucket(world.lastBucket)
                      .key(world.lastKey)
                      .uploadId(world.lastUploadId)
                      .partNumber(1),
              RequestBody.fromBytes(bytes));
      world.lastETag = r.eTag();
      world.setSuccess(r);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I list parts of the multipart upload")
  public void iListPartsOfTheMultipartUpload() {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(
          client.listParts(
              r -> r.bucket(world.lastBucket).key(world.lastKey).uploadId(world.lastUploadId)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I complete the multipart upload")
  public void iCompleteTheMultipartUpload() {
    try (S3Client client = world.s3Client()) {
      CompletedPart part =
          CompletedPart.builder()
              .partNumber(1)
              .eTag(world.lastETag != null ? world.lastETag : "dummy")
              .build();
      world.setSuccess(
          client.completeMultipartUpload(
              r ->
                  r.bucket(world.lastBucket)
                      .key(world.lastKey)
                      .uploadId(world.lastUploadId)
                      .multipartUpload(CompletedMultipartUpload.builder().parts(part).build())));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I abort the multipart upload")
  public void iAbortTheMultipartUpload() {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(
          client.abortMultipartUpload(
              r -> r.bucket(world.lastBucket).key(world.lastKey).uploadId(world.lastUploadId)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @Then("bucket {string} will exist")
  public void bucketWillExist(String bucket) {
    try (S3Client client = world.s3Client()) {
      ListBucketsResponse r = client.listBuckets();
      boolean found = r.buckets().stream().anyMatch(b -> b.name().equals(bucket));
      assertTrue(found, "Expected bucket " + bucket + " to exist");
    }
  }

  @Then("bucket {string} will not appear in list-buckets")
  public void bucketWillNotAppearInListBuckets(String bucket) {
    try (S3Client client = world.s3Client()) {
      ListBucketsResponse r = client.listBuckets();
      boolean found = r.buckets().stream().anyMatch(b -> b.name().equals(bucket));
      assertFalse(found, "Expected bucket " + bucket + " to not exist");
    }
  }

  @Then("bucket {string} will have 0 objects")
  public void bucketWillHave0Objects(String bucket) {
    try (S3Client client = world.s3Client()) {
      ListObjectsV2Response r = client.listObjectsV2(req -> req.bucket(bucket));
      assertEquals(0, r.contents().size(), "Expected 0 objects in bucket " + bucket);
    }
  }

  @Then("bucket {string} will have no website configuration")
  public void bucketWillHaveNoWebsiteConfiguration(String bucket) {
    try (S3Client client = world.s3Client()) {
      try {
        client.getBucketWebsite(r -> r.bucket(bucket));
        fail("Expected no website configuration for bucket " + bucket);
      } catch (Exception e) {
        // expected
        assertTrue(true);
      }
    }
  }

  @Then("bucket {string} will have website index document {string}")
  public void bucketWillHaveWebsiteIndexDocument(String bucket, String index) {
    try (S3Client client = world.s3Client()) {
      GetBucketWebsiteResponse r = client.getBucketWebsite(req -> req.bucket(bucket));
      assertEquals(index, r.indexDocument().suffix());
    }
  }

  @Then("the bucket list will include {string}")
  public void theBucketListWillInclude(String bucket) {
    try (S3Client client = world.s3Client()) {
      ListBucketsResponse r = client.listBuckets();
      boolean found = r.buckets().stream().anyMatch(b -> b.name().equals(bucket));
      assertTrue(found, "Expected bucket " + bucket + " in list");
    }
  }

  @Then("the object list will include {string}")
  public void theObjectListWillInclude(String key) {
    assertTrue(world.lastSuccess, "Last command did not succeed");
    if (world.lastOutput instanceof ListObjectsV2Response resp) {
      boolean found = resp.contents().stream().anyMatch(o -> o.key().equals(key));
      assertTrue(found, "Expected object " + key + " in list");
    }
  }

  @Then("the downloaded file will have content {string}")
  public void theDownloadedFileWillHaveContent(String expected) {
    assertNotNull(lastDownloadedContent, "No content was downloaded");
    assertEquals(expected, new String(lastDownloadedContent, StandardCharsets.UTF_8));
  }

  @Then("object {string} in bucket {string} will have content {string}")
  public void objectInBucketWillHaveContent(String key, String bucket, String expected) {
    try (S3Client client = world.s3Client()) {
      software.amazon.awssdk.core.ResponseBytes<
              software.amazon.awssdk.services.s3.model.GetObjectResponse>
          resp = client.getObjectAsBytes(r -> r.bucket(bucket).key(key));
      String content = resp.asUtf8String();
      assertEquals(expected, content);
    } catch (Exception e) {
      fail("Failed to get object: " + e.getMessage());
    }
  }

  @Then("object {string} in bucket {string} will have binary content {string}")
  public void objectInBucketWillHaveBinaryContent(String key, String bucket, String expected) {
    try (S3Client client = world.s3Client()) {
      byte[] content = client.getObjectAsBytes(r -> r.bucket(bucket).key(key)).asByteArray();
      assertNotNull(content, "Expected binary content");
    } catch (Exception e) {
      fail("Failed to get object: " + e.getMessage());
    }
  }

  @Then("the output will contain an ETag")
  public void theOutputWillContainAnETag() {
    assertTrue(world.lastSuccess, "Last command did not succeed");
  }

  @Then("the output will contain an upload ID")
  public void theOutputWillContainAnUploadId() {
    assertNotNull(world.lastUploadId, "Expected an upload ID");
  }

  @Then("the output will contain website index document {string}")
  public void theOutputWillContainWebsiteIndexDocument(String index) {
    assertTrue(world.lastSuccess, "Last command did not succeed");
    if (world.lastOutput instanceof GetBucketWebsiteResponse resp) {
      assertEquals(index, resp.indexDocument().suffix());
    }
  }
}
