// Test software for data throughput using Electric imp @ NST - device side

// get server data 
server.log(" nstimp connected to WiFi SSID: " + imp.getssid() + " with BSSID " + imp.getbssid());

// receive payload from agent 
function handleAgentRequest(ignored_val=null)
{ 
    // Add n bytes blob of arbitrary binary data to send out
    local ndata = 2048;
    local payload = blob(ndata);
    // add data in the payload field
    agent.send("data", payload);
}

// throughput = RWIN/RTT
// RTT - round trip time: get it from ping pong
// RWIN - receive window: is default 3KB but up to 30KB using this function 
// imp.setsendbuffersize(8000); // in bytes and 3KB is default

// register function to process messages from agent to device
agent.on("get_data", handleAgentRequest);
