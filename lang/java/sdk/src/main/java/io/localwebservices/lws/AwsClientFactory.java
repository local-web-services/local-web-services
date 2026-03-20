package io.localwebservices.lws;

import java.net.URI;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.docdb.DocDbClient;
import software.amazon.awssdk.services.elasticache.ElastiCacheClient;
import software.amazon.awssdk.services.elasticsearch.ElasticsearchClient;
import software.amazon.awssdk.services.glacier.GlacierClient;
import software.amazon.awssdk.services.memorydb.MemoryDbClient;
import software.amazon.awssdk.services.neptune.NeptuneClient;
import software.amazon.awssdk.services.opensearch.OpenSearchClient;
import software.amazon.awssdk.services.rds.RdsClient;

/** Factory for building AWS SDK clients targeting local LWS emulators. */
class AwsClientFactory {

  private AwsClientFactory() {}

  static StaticCredentialsProvider testCredentials() {
    return StaticCredentialsProvider.create(AwsBasicCredentials.create("test", "test"));
  }

  static URI endpointFor(String service, int basePort, LwsSession session) {
    return URI.create("http://127.0.0.1:" + session.portFor(service));
  }

  static RdsClient rdsClient(LwsSession session) {
    return RdsClient.builder()
        .endpointOverride(URI.create("http://127.0.0.1:" + session.portFor("rds")))
        .region(Region.US_EAST_1)
        .credentialsProvider(testCredentials())
        .build();
  }

  static DocDbClient docDbClient(LwsSession session) {
    return DocDbClient.builder()
        .endpointOverride(URI.create("http://127.0.0.1:" + session.portFor("docdb")))
        .region(Region.US_EAST_1)
        .credentialsProvider(testCredentials())
        .build();
  }

  static NeptuneClient neptuneClient(LwsSession session) {
    return NeptuneClient.builder()
        .endpointOverride(URI.create("http://127.0.0.1:" + session.portFor("neptune")))
        .region(Region.US_EAST_1)
        .credentialsProvider(testCredentials())
        .build();
  }

  static ElastiCacheClient elastiCacheClient(LwsSession session) {
    return ElastiCacheClient.builder()
        .endpointOverride(URI.create("http://127.0.0.1:" + session.portFor("elasticache")))
        .region(Region.US_EAST_1)
        .credentialsProvider(testCredentials())
        .build();
  }

  static MemoryDbClient memoryDbClient(LwsSession session) {
    return MemoryDbClient.builder()
        .endpointOverride(URI.create("http://127.0.0.1:" + session.portFor("memorydb")))
        .region(Region.US_EAST_1)
        .credentialsProvider(testCredentials())
        .build();
  }

  static GlacierClient glacierClient(LwsSession session) {
    return GlacierClient.builder()
        .endpointOverride(URI.create("http://127.0.0.1:" + session.portFor("glacier")))
        .region(Region.US_EAST_1)
        .credentialsProvider(testCredentials())
        .build();
  }

  static ElasticsearchClient elasticsearchClient(LwsSession session) {
    return ElasticsearchClient.builder()
        .endpointOverride(URI.create("http://127.0.0.1:" + session.portFor("elasticsearch")))
        .region(Region.US_EAST_1)
        .credentialsProvider(testCredentials())
        .build();
  }

  static OpenSearchClient openSearchClient(LwsSession session) {
    return OpenSearchClient.builder()
        .endpointOverride(URI.create("http://127.0.0.1:" + session.portFor("opensearch")))
        .region(Region.US_EAST_1)
        .credentialsProvider(testCredentials())
        .build();
  }
}
