import ballerina/http;
service /funds on new http:Listener(9090) {
    resource function post donate(@http:Payload json requestPayload) returns json|error {
        string sender_email = check requestPayload.email;

        http:Client user_verify_client = check new ("https://my-json-server.typicode.com/NatashaWso2/TestAPI/verified_emails");
        json[] user_verify_res = check user_verify_client->get("/");

        foreach var item in user_verify_res {
            if (item.email == sender_email) {
                return {"email":check item.email, "status":"donation received successful!"};
            }
        }
        return {"status": "user verification failed. please try again with a verified user email."};
    }
    resource function get total() returns json|error {
       http:Client user_verify_client = check new ("https://my-json-server.typicode.com/NatashaWso2/TestAPI/funds");
       return check user_verify_client->get("/");
    }
}