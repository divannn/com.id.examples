package com.id.examples.misc;

import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;

public class UrlEncoding {
    public static void main(String[] args) throws UnsupportedEncodingException, URISyntaxException, MalformedURLException {
        String s = "http://localhost:9004/dpa-api/reportmenu?query=name=All that*";
        System.err.println("         str:" + s);
        System.err.println("html encoded:" + URLEncoder.encode(s, "UTF-8"));
        URI uri = new URI("http", null, "localhost", 9004, "/dpa-api/reportmenu", "query=name=All that*", null);
        System.err.println(" url encoded:" + uri.toURL());//or use uri.toASCIIString().
    }
}