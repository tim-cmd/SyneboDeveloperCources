public class AnimalsCallouts {
    
    public static String makeGetDataCallout(String id){        
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + id);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            String results = response.getBody();
            System.debug('JSON body: ' + results);
            return results;            
        }
        return 'not 200 response code';
    }
}