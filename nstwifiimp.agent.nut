// Test software for data throughput using Electric imp @ NST - agent side

// agent URL 
server.log("nstimp agent is found @  " + http.agenturl());

reply <- blob();

// response payload handling and data relay to requesting app
function handleDevicePayload(data) 
{
 // copy data in global var for app response
 reply = data;
}

// HTTP Request handlers expect two parameters:
// request: the incoming request
// response: the response we send back to whoever made the request
function appRequestHandler(request, response) {
    // The parameter request is the incoming HTTP request
    // The parameter response is an auto-generated HTTP response
    try
    {
        // Process incoming http request
    
        // Check if the variable d was passed into the query
         if ("get_data" in request.query) {
            // if it was, send the value of it to the device
            device.send("get_data", null);
        }
        
        // If everything worked as expected, send the data to the app
        response.send(200, reply);
    }
    catch (exception)
    {
        response.send(500, "Internal Server Error: " + exception);
    }
}

//agent registers to app calls
http.onrequest(appRequestHandler);
// register functions to handle messages from the device to the agent
device.on("data", handleDevicePayload);
