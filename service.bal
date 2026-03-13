import ballerina/http;
import ballerina/io;

configurable string service2URL = ?;

service / on new http:Listener(9090) {

    resource function get service1(http:Request req) returns string|error {
        // Send a response back to the caller.
        string requestID = check req.getHeader("x-request-id");

        io:println("Received request with x-request-id: ", requestID);

        http:Client service1 = check new (service2URL);
        http:Response response = check service1->get("", headers = {"x-request-id": requestID});

        string responsePayload = check response.getTextPayload();
        return responsePayload;

    }
}
