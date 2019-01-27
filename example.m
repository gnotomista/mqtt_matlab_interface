clc
clear java
close all
javaaddpath('jars/org.eclipse.paho.client.mqttv3-1.2.0.jar')
javaaddpath('jars/iMqttClient.jar')
addpath(genpath(pwd))

% create mqtt interface object
mqttinterface = MqttInterface('matlab_mqtt_node', 'localhost', 1883, 10); % set maxInflight=10
% mqttinterface = MqttInterface('matlab_mqtt_node', 'localhost', 1883); % maxInflight will be set to 1000

% subscribe to a topic
sub_topic_1 = 'sub_topic_1';
sub_topic_2 = 'sub_topic_2';
mqttinterface.subscribe(sub_topic_1, 1); % set qos=1
mqttinterface.subscribe(sub_topic_2); % qos will be set to 0

while true
    % receive a message from sub_topic
    sub_topic_msg_1 = mqttinterface.receive(sub_topic_1);
    sub_topic_msg_2 = mqttinterface.receive(sub_topic_2);
    disp(['received msg: ', sub_topic_msg_1, ' from ', sub_topic_1])
    disp(['received msg: ', sub_topic_msg_2, ' from ', sub_topic_2])
    
    % publish a message to pub_topic
    mqttinterface.send('pub_topic_1', 'pub_msg_1', 1); % set qos=1
    mqttinterface.send('pub_topic_2', 'pub_msg_2'); % qos will be set to 0
    
    pause(1)
end
