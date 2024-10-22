-- // Support solara & very useful for cracking whitelist
local OldReq = request or http.request

local req = function(options)
    print("Logging request to:", options.Url)
    print("Method:", options.Method)
    print("Headers:", options.Headers)
    print("Body:", options.Body)
    return OldReq(options)
end

