# mqtt_matlab_interface
MATLAB interface to mqtt, based on the [Paho Java client](https://www.eclipse.org/paho/clients/java/)

Bare bones implementation which allows to connect to an mqtt broker (e.g. http://emqtt.io/), publish and subscribe to multiple topics.

Extending functionalities is straightforward:
1. the java source files in the `src` directory can be modified to add the functionalities one wants
2. once the src files have been modified, a .jar file can be generated from the .java by running `sh pack_to_jar.sh` from the `src` directory
3. the java classes packed in the jar files in the `jars` folder can be then imported in MATLAB using `javaaddpath` as done in `example.m`
