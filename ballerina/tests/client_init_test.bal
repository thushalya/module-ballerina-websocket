// Copyright (c) 2021 WSO2 Inc. (//www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// //www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/test;

service isolated class ClientPingPongCallBackService {
    *PingPongService;
    remote isolated function onPing(Client caller, byte[] localData) {
    }

    remote isolated function onPong(Client caller, byte[] localData) {
    }
}

@test:Config {}
public function testErrorCallbackService() returns Error? {
    Error|Client wsClient = new("ws://localhost:21057/pingpong", config = {pingPongHandler : new ClientPingPongCallBackService()});
    if wsClient is Error {
        test:assertEquals("Error: The callback service should be a PingPongService", wsClient.message());
    } else {
        test:assertFail("Expected an error in call back service");
    }
}
