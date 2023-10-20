public Class sendSMSClass
{        
    public static void mySMS(String strURL)
    {
   
            system.debug('strURL In mySMS Class: ' + strURL);
            HttpRequest req = new HttpRequest();
            req.setEndpoint (strURL);
            req.setMethod ('GET');
            system.debug('req: ' + req);
            Http http = new Http();
            HTTPResponse res = http.send(req);
            system.debug('HTTPResponse : '+ res);
     
    }
}