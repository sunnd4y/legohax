-- // Support solara & very useful for cracking whitelist
local OldReq = request or http.request

getgenv().request = function(options)
    print("Logging request to:", options.Url)
    print("Method:", options.Method)
    print("Headers:", options.Headers)
    print("Body:", options.Body)
    return OldReq(options)
end

getgenv().http.request = function(options)
    print("Logging request to:", options.Url)
    print("Method:", options.Method)
    print("Headers:", options.Headers)
    print("Body:", options.Body)
    return OldReq(options)
end

local response = request({
    Url = "http://httpbin.org/post",  
    Method = "POST",
    Headers = {
        ["Content-Type"] = "application/json"  
    },
    Body = game:GetService("HttpService"):JSONEncode({hello = "world"})
})

print("Response:", response)
