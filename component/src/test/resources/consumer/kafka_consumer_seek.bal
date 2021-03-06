// Copyright (c) 2018 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import wso2/kafka;

function funcKafkaConnect() returns kafka:SimpleConsumer {
    endpoint kafka:SimpleConsumer kafkaConsumer {
        bootstrapServers: "localhost:9094",
        groupId: "test-group",
        offsetReset: "earliest",
        topics: ["test"]
    };
    return kafkaConsumer;
}

function funcKafkaClose(kafka:SimpleConsumer consumer) returns boolean {
    endpoint kafka:SimpleConsumer consumerEP {};
    consumerEP = consumer;
    var conErr = consumerEP->close();
    return true;
}

function funcKafkaPoll(kafka:SimpleConsumer consumer) returns int {
    endpoint kafka:SimpleConsumer consumerEP {};
    consumerEP = consumer;
    kafka:ConsumerRecord[] records;
    records = check consumerEP->poll(1000);
    return lengthof records;
}

function funcKafkaGetPositionOffset(kafka:SimpleConsumer consumer, kafka:TopicPartition part) returns int {
    endpoint kafka:SimpleConsumer consumerEP {};
    consumerEP = consumer;
    int offset;
    offset = check consumerEP->getPositionOffset(part);
    return offset;
}

function funcKafkaSeekOffset(kafka:SimpleConsumer consumer, kafka:Offset offset) {
    endpoint kafka:SimpleConsumer consumerEP {};
    consumerEP = consumer;
    check consumerEP->seek(offset);
}

function funcKafkaSeekToBegin(kafka:SimpleConsumer consumer, kafka:TopicPartition[] partitions) {
    endpoint kafka:SimpleConsumer consumerEP {};
    consumerEP = consumer;
    check consumerEP->seekToBeginning(partitions);
}

function funcKafkaSeekToEnd(kafka:SimpleConsumer consumer, kafka:TopicPartition[] partitions) {
    endpoint kafka:SimpleConsumer consumerEP {};
    consumerEP = consumer;
    check consumerEP->seekToEnd(partitions);
}

function funcKafkaBeginOffsets(kafka:SimpleConsumer consumer, kafka:TopicPartition[] partitions)
             returns kafka:Offset[] {

    endpoint kafka:SimpleConsumer consumerEP {};
    consumerEP = consumer;
    kafka:Offset[] offsets;
    offsets = check consumerEP->getBeginningOffsets(partitions);
    return offsets;
}

function funcKafkaEndOffsets(kafka:SimpleConsumer consumer, kafka:TopicPartition[] partitions)
             returns kafka:Offset[] {

    endpoint kafka:SimpleConsumer consumerEP {};
    consumerEP = consumer;
    kafka:Offset[] offsets;
    offsets = check consumerEP->getEndOffsets(partitions);
    return offsets;
}
