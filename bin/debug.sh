#!/usr/bin/env bash
#
# Copyright (C) ${project.inceptionYear} Jeremy Custenborder (jcustenborder@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

mvn clean package

if [ $? -eq 0 ]
then
    echo "maven finished"
else
    echo "Maven failed"
    exit 1
fi

export CLASSPATH="$(find target/ -type f -name '*.jar'| grep '\-package' | tr '\n' ':')"
export KAFKA_JMX_OPTS='-Xdebug -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005'

$CONFLUENT_HOME/bin/connect-standalone connect/connect-avro-docker.properties config/SplunkHttpSink.properties