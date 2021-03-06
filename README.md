[![Build Status](https://travis-ci.org/wso2-ballerina/package-kafka.svg?branch=master)](https://travis-ci.org/wso2-ballerina/package-kafka)

# **Ballerina Kafka Client Endpoint**

Ballerina Kafka Client Endpoint is used to connect Ballerina with Kafka Brokers. With this Kafka Client Endpoint, Ballerina can act as Kafka Consumers and Kafka Producers.

Steps to Configure
==================================

Extract wso2-kafka-<version>.zip and  Run the install.sh script to install the package.
You can uninstall the package by running uninstall.sh.

Building From the Source
==================================
If you want to build Ballerina Kafka client endpoint from the source code:

1. Get a clone or download the source from this repository:
    https://github.com/wso2-ballerina/package-kafka
2. Run the following Maven command from the ballerina directory:
    mvn clean install
3. Extract the distribution created at `/component/target/wso2-kafka-<version>.zip`. Run the install.{sh/bat} script to install the package.
You can uninstall the package by running uninstall.{sh/bat}.
`

## Ballerina as a Kafka Consumer

Following is a simple service (kafkaService) which is subscribed to topic 'test-kafka-topic' on remote Kafka broker cluster. In this example, offsets are manually committed inside the resource
by setting property `autoCommit: false` at endpoint parameter.

```ballerina
import wso2/kafka;
import ballerina/io;

endpoint kafka:SimpleConsumer consumer {
    bootstrapServers:"localhost:9092",
    groupId:"group-id",
    topics:["test-kafka-topic"],
    pollingInterval:1000,
    autoCommit:false
};

service<kafka:Consumer> kafkaService bind consumer {

    onMessage(kafka:ConsumerAction consumerAction, kafka:ConsumerRecord[] records) {
        // Dispatched set of Kafka records to service, We process each one by one.
        foreach kafkaRecord in records {
            processKafkaRecord(kafkaRecord);
        }
        // Commit offsets returned for returned records, marking them as consumed.
        consumerAction.commit();
    }
}

function processKafkaRecord(kafka:ConsumerRecord kafkaRecord) {
    blob serializedMsg = kafkaRecord.value;
    string msg = serializedMsg.toString("UTF-8");
    // Print the retrieved Kafka record.
    io:println("Topic: " + kafkaRecord.topic + " Received Message: " + msg);
}
````

## Ballerina as a Kafka Producer

Following example demonstrates a way to publish a message to a specified topic. A Kafka record is created from serialized string, and then it is published to topic 'test-kafka-topic' partition '0' in remote Kafka broker cluster.

```ballerina
import wso2/kafka;

endpoint kafka:SimpleProducer kafkaProducer {
    // Here we create a producer configs with optional parameters client.id - used for broker side logging.
    // acks - number of acknowledgments for request complete,
    // noRetries - number of retries if record send fails.
    bootstrapServers: "localhost:9092",
    clientID:"basic-producer",
    acks:"all",
    noRetries:3
};

function main (string... args) {
    string msg = "Hello World Advance";
    blob serializedMsg = msg.toBlob("UTF-8");
    kafkaProducer->send(serializedMsg, "test-kafka-topic", partition = 0);
}
````

For more Kafka Connector Ballerina configurations please refer to the samples directory.
