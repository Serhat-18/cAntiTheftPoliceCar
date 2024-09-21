Config = {}
Config.SystemWait = 1000 -- Stabilized !
Config.WebhookURL = "WEBHOOK_HERE"
Config.Vehicles = {
    [`police`] = {'police'},              
    [`ambulance`] = {'ambulance'},          
    [`firetruck`] = {'firefighter'},        
    [`police2`] = {'police', 'security'},  
    -- Add More
}

Config.Notify = {
    QBCoreNotify = true,
    Message = "Bu aracı süremezsiniz! Mesleğiniz uygun değil !",
    Type = "error",
    Time = 5000,
    Custom = {
        ExportResourceName = "cf-notify",
        ExportFunctionName = "sendnotify"
    }
}