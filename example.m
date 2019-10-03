clc
clear java

javaaddpath('jars/org.eclipse.paho.client.mqttv3-1.2.2.jar')
javaaddpath('jars/iMqttClient.jar')
addpath(genpath(pwd))

%% topics
SUB_TOPIC_1 = 'sub_pub_topic_1';
SUB_TOPIC_2 = 'sub_pub_topic_2';
PUB_TOPIC_1 = 'sub_pub_topic_1';
PUB_TOPIC_2 = 'sub_pub_topic_2';

%% create mqtt interface object
% with default maxInflight value (1000)
% mqttinterface = MqttInterface('matlab_mqtt_node', 'localhost', 1883);
% or with custom maxInflight=10
mqttinterface = MqttInterface('matlab_mqtt_node', 'localhost', 1883, 10);

%% subscribe to a topic
mqttinterface.subscribe(SUB_TOPIC_1, 1); % set qos=1
mqttinterface.subscribe(SUB_TOPIC_2); % qos will be set to 0

%% receive and publish messages
while true
    % receive messages from topics
    sub_msg_1 = mqttinterface.receive(SUB_TOPIC_1);
    sub_msg_2 = mqttinterface.receive(SUB_TOPIC_2);
    
    disp(['Received ', sub_msg_1, ' from topic ', SUB_TOPIC_1])
    disp(['Received ', sub_msg_2, ' from topic ', SUB_TOPIC_2])
    
    % publish messages to topics
    pub_msg_1 = 'pub_msg_1_test_string';
    pub_msg_2 = 'pub_msg_2_test_string';
    % with default qos value (0)
    mqttinterface.send(PUB_TOPIC_1, pub_msg_1);
    % or with custom qos=1
    mqttinterface.send(PUB_TOPIC_2, pub_msg_2, 1);
    
    disp(['Published ', pub_msg_1, ' to topic ', PUB_TOPIC_1])
    disp(['Published ', pub_msg_2, ' to topic ', PUB_TOPIC_2])
    
    pause(1)
end
