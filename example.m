clc
clear java
close all
javaaddpath('jars/org.eclipse.paho.client.mqttv3-1.2.0.jar')
javaaddpath('jars/Subscriber.jar')
addpath(genpath(pwd))

% create mqtt interface object
mqttinterface = MqttInterface('matlab_mqtt_node', 'localhost', 1883);

% add publisher to a topic
pub_topic = 'pub_topic_name';
mqttinterface.add_publisher(pub_topic);

% add subscriber to a topic
sub_topic = 'sub_topic_name';
mqttinterface.add_subscriber(sub_topic);

% connect to the mqtt broker
mqttinterface.connect();

% receive a message from sub_topic
sub_topic_msg = mqttinterface.receive(sub_topic);

% publish a message to pub_topic
pub_topic_msg = 'pub_topic_msg';
mqttinterface.send(pub_topic, pub_topic_msg);
