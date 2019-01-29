classdef MqttInterface < handle
    properties
        client_id
        ip
        port
        imqtt
    end

    methods
        function obj = MqttInterface(client_id, ip, port, max_inflight)
            obj.client_id = client_id;
            obj.ip = ip;
            obj.port = port;

            if nargin < 4
                obj.imqtt = iMqttClient(obj.client_id, obj.ip, num2str(obj.port));
            else
                obj.imqtt = iMqttClient(obj.client_id, obj.ip, num2str(obj.port), max_inflight);
            end
        end
        function subscribe(obj, topic, qos)
            if nargin < 3
                qos = 0;
            end
            obj.imqtt.subscribe(topic, qos);
        end
        function [recv_msg, err_flag, err] = receive(obj, topic)
            recv_msg = [];
            err_flag = false;
            err = '';
            try
                recv_msg = char(obj.imqtt.getMessage(topic));
            catch e
                err_flag = true;
                err = e.message;
            end
        end
        function [recv_msg, err_flag, err] = receive_json(obj, topic)
            recv_msg = [];
            err_flag = false;
            err = '';
            try
                recv_msg = jsondecode(char(obj.imqtt.getMessage(topic)));
            catch e
                err_flag = true;
                err = e.message;
            end
        end
        function [err_flag, err] = send(obj, topic, msg, qos)
            err_flag = false;
            err = '';
            try
                if nargin < 4
                    obj.imqtt.sendMessage(topic, msg)
                else
                    obj.imqtt.sendMessage(topic, msg, qos)
                end
            catch e
                err_flag = false;
                err = e.message;
            end
        end
        function [err_flag, err] = send_json(obj, topic, msg, qos)
            err_flag = false;
            err = '';
            try
                s = jsonencode(msg);
                if nargin < 4
                    obj.imqtt.sendMessage(topic, s)
                else
                    obj.imqtt.sendMessage(topic, s, qos)
                end
            catch e
                err_flag = false;
                err = e.message;
            end
        end
    end
end
