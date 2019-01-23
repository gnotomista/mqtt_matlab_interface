classdef MqttInterface < handle
    properties
        client_id
        ip
        port
        publisher
        subscribers
        pub_topics
        sub_topics
    end
    
    methods
        function obj = MqttInterface(client_id, ip, port)
            obj.pub_topics = {};
            obj.sub_topics = {};
            obj.subscribers = containers.Map;
            
            obj.client_id = client_id;
            obj.ip = ip;
            obj.port = port;
            
            persistence = org.eclipse.paho.client.mqttv3.persist.MemoryPersistence();
            obj.publisher = org.eclipse.paho.client.mqttv3.MqttClient(['tcp://',obj.ip,':',num2str(obj.port)], [obj.client_id,'_pub'], persistence);
        end
        function connect(obj)
            connOpts = org.eclipse.paho.client.mqttv3.MqttConnectOptions();
            connOpts.setCleanSession(true);
            obj.publisher.connect(connOpts);
        end
        function add_publisher(obj, pub_topic)
            obj.pub_topics{end+1} = pub_topic;
        end
        function add_subscriber(obj, sub_topic)
            obj.subscribers(sub_topic) = Subscriber([obj.client_id,'_',sub_topic,'_sub'], obj.ip, num2str(obj.port), sub_topic);
            obj.sub_topics{end+1} = sub_topic;
        end
        function [recv_msg, err_flag, err] = receive(obj, sub_topic)
            recv_msg = [];
            err_flag = false;
            err = '';
            try
                recv_msg = jsondecode(char(obj.subscribers(sub_topic).mqtt_message));
            catch e
                err_flag = true;
                err = e.message;
            end
        end
        function [err_flag, err] = send(obj, pub_topic, msg)
            err_flag = false;
            err = '';
            try
                S = jsonencode(msg);
                send_msg = org.eclipse.paho.client.mqttv3.MqttMessage(uint8(S));
                send_msg.setQos(0);
                obj.publisher.publish(pub_topic, send_msg);
            catch e
                err_flag = false;
                err = e.message;
            end
        end
    end
end
