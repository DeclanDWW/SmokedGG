utility_post_request(endpoint, data) {
    headers = [];
    headers["Content-Type"] = "application/json";
    headers["X-Api-Key"] = getDvar("smoked_api_token");

    req = httpPost(getDvar("smoked_api_endpoint") + endpoint, jsonSerialize(data, 0), headers);
    req waittill("done", result);

    // Log results for testing
    writeFile("scripts/zm/logs/api/" + endpoint + ".log", result);

    return result;
}