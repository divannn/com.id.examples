package com.id.examples.misc;

import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;

public class UrlEncoding {
    public static void main(String[] args) throws UnsupportedEncodingException, URISyntaxException, MalformedURLException {
        String s = "http://localhost:9004/dpa-api/reportmenu?query=name=All that*";
        String htmlEncoded = URLEncoder.encode(s, "UTF-8");
        System.err.println("html encoded:" + htmlEncoded);
        URI uri = new URI("http", null, "localhost", 9004, "/dpa-api/reportmenu", "query=name=All that*", null);
        System.err.println(" url encoded:" + uri.toURL());//or use uri.toASCIIString().
    }
}